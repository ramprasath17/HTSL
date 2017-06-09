namespace BudgetManager.Web.Areas.Expenses.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Web.Mvc;
    using AutoMapper;
    using BudgetManager.Helpers;
    using BudgetManager.Infrastructure.Helpers;
    using BudgetManager.Repository.Interface;
    using BudgetManager.SharedAssembly.ApplicationLookUps;
    using BudgetManager.SharedAssembly.ExpenseEntity;
    using BudgetManager.SharedAssembly.TransactionEntity;
    using BudgetManager.Web.ActionFilters;
    using BudgetManager.Web.Areas.Expenses.Models;
    using BudgetManager.Web.Attributes;

    [Authorize]
    [PermissionActionFilter]
    [GroupMenuTitle(Title = "User transactions")]
    public class TransactionController : Controller
    {
        /// <summary>
        /// Expense Repository 
        /// </summary>
        private readonly IExpenseRepository expenseRepository;

        /// <summary>
        /// User repository
        /// </summary>
        private readonly IUserRepository userRepository;

        /// <summary>
        /// Initialises new instance of <see cref="TransactionController"/> class.
        /// </summary>
        /// <param name="expenseRepository">Expense repository</param>
        /// <param name="userRepository">User repository</param>
        public TransactionController(IExpenseRepository expenseRepository, IUserRepository userRepository)
        {
            this.expenseRepository = expenseRepository;
            this.userRepository = userRepository;
        }

        /// <summary>
        /// Create transaction
        /// </summary>
        /// <returns></returns>
        [LinkFilter(LinkText = "Create")]
        public ActionResult Create()
        {
            TransactionViewModel transactionViewModel = new TransactionViewModel
            {
                Expenses = this.expenseRepository.GetAllMyExpenses().Tables[0].AsEnumerable().Select(expenses => new SelectListItem
                {
                    Text = expenses.Field<string>("Description"),
                    Value = TypeConversionHelper.GetDefaultValueIfNull<string>(expenses.Field<int>("ExpenseId"))
                }),
                UsersInExpense = new List<SelectListItem>().AsEnumerable(),
            };
            return View("Create", transactionViewModel);
        }

        /// <summary>
        /// Create a new transaction by expense id
        /// </summary>
        /// <param name="transactionViewModel">Transaction view model</param>
        /// <returns>Create transaction view.</returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(TransactionViewModel transactionViewModel)
        {
            if (expenseRepository.CheckAmountBeyondLevel(transactionViewModel.AmountReturned ?? 0, transactionViewModel.SelectedExpense, transactionViewModel.AmountReturnedBy,transactionViewModel.AmountReceivedBy))
            {
                ModelState.AddModelError("AmountReturned", "Entered amount returned is more than to return.");
            }

            if (ModelState.IsValid)
            {
                TransactionMembers transactionMembers = new TransactionMembers
                {
                    AmountReturned = transactionViewModel.AmountReturned.Value,
                    AmountReturnedOn = transactionViewModel.AmountReturnedOn.Value,
                    ReceivedBy = transactionViewModel.AmountReceivedBy,
                    ReturnedBy = transactionViewModel.AmountReturnedBy,
                    ExpenseId = transactionViewModel.SelectedExpense,
                    Description = transactionViewModel.Description
                };
                bool isSavedSuccessfully = false;
                using (this.expenseRepository)
                {
                    isSavedSuccessfully = this.expenseRepository.CreateTransaction(transactionMembers);
                }

                if (isSavedSuccessfully)
                {
                    return this.RedirectToAction("Create", "Transaction");
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "There was an issue saving the transaction. Please try again.");
                    ReloadModelOnError(transactionViewModel, this.expenseRepository);
                    return this.View("Create", transactionViewModel);
                }
            }
            else
            {
                ReloadModelOnError(transactionViewModel, this.expenseRepository);
                return this.View("Create", transactionViewModel);
            }
        }

        /// <summary>
        /// Get look up data
        /// </summary>
        /// <param name="lookupType">lookup type</param>
        /// <param name="lookupCondition">lookup condition</param>
        /// <returns>lookup data</returns>
        [HttpGet]
        [PermissionActionFilter(false)]
        public JsonResult GetLookupData(char lookupType, string lookupCondition)
        {
            DataSet lookupDataSet = this.expenseRepository.GetTransactionLookUpData(lookupType, lookupCondition);
            List<SelectListItem> lookupData = new List<SelectListItem>();
            if (lookupDataSet != null && lookupDataSet.Tables.Count > 0)
            {
                lookupData = lookupDataSet.Tables[0].AsEnumerable().Select(lookup => new SelectListItem()
                 {
                     Text = lookup.Field<string>("text"),
                     Value = lookup.Field<string>("value")
                 }).ToList();
            }

            return Json(lookupData, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Edit transaction
        /// </summary>
        /// <returns>Edit screen.</returns>
        [HttpGet]
        [LinkFilter(LinkText = "Edit")]
        public ActionResult Edit()
        {
            ManageTransactionViewModel manageTransactionVewModel = null;
            using (this.expenseRepository)
            {
                DataSet transactionData = this.expenseRepository.GetAllMyTransactions();
                manageTransactionVewModel = new ManageTransactionViewModel
                {
                    TransactionData = transactionData.Tables[0].AsEnumerable().Select(transaction => new TransactionViewModel
                    {
                        AmountReceivedBy = transaction.Field<string>("AmountReceivedBy"),
                        AmountReturned = transaction.Field<decimal>("AmountReturned"),
                        AmountReturnedOn = transaction.Field<DateTime>("ReturnedOn"),
                        AmountReturnedBy = transaction.Field<string>("AmountReturnedBy"),
                        SelectedExpenseName = transaction.Field<string>("Expense"),
                        Description = transaction.Field<string>("Description"),
                        TransactionId = transaction.Field<int>("TransactionId")
                    }).ToList(),
                    TransactionLookUpData = new TransactionLookUp
                    {
                        Expenses = AppDataTableExtensions.LoadLookUpsDictionary<string, string>(transactionData.Tables[1], field1: "Value", field2: "Text"),
                        Users = AppDataTableExtensions.LoadLookUpsDictionary<string, string>(transactionData.Tables[2], field1: "Value", field2: "Text"),
                    }
                };
            }

            manageTransactionVewModel = manageTransactionVewModel ?? new ManageTransactionViewModel();
            return View("Edit", manageTransactionVewModel);
        }

        /// <summary>
        /// Money flow calculation screen
        /// </summary>
        /// <returns>The Analysis view.</returns>
        [HttpGet]
        [LinkFilter(LinkText = "Money Flow")]
        public ActionResult Analysis()
        {
            TransactionAnalysisViewModel transactionAnalysisViewModel; 
            using (expenseRepository)
            {
                DataSet lookUpData = expenseRepository.GetAnalysisLookUps();
                transactionAnalysisViewModel = new TransactionAnalysisViewModel
                {
                    Users = lookUpData.Tables[0].AsEnumerable().Select(result => new SelectListItem
                    {
                        Text = result.Field<string>("DisplayName"),
                        Value = result.Field<string>("UserId")
                    }),
                    Groups = lookUpData.Tables[1].AsEnumerable().Select(result => new SelectListItem
                    {
                        Text = result.Field<string>("GroupName"),
                        Value = result.Field<int>("GroupId").ToString()
                    }),
                    Expenses = lookUpData.Tables[2].AsEnumerable().Select(result => new SelectListItem
                    {
                        Text = result.Field<string>("Description"),
                        Value = result.Field<int>("ExpenseId").ToString()
                    })
                };
            }

            return View("Analysis", transactionAnalysisViewModel);
        }

        /// <summary>
        /// Calculate the money flow based on analysis.
        /// </summary>
        /// <param name="transactionAnalysisViewModel"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public string Analysis(TransactionAnalysisViewModel transactionAnalysisViewModel)
        {
            AnalysisQuery analysisQuery = Mapper.Map<TransactionAnalysisViewModel, AnalysisQuery>(transactionAnalysisViewModel);
            DataSet analysisResult = expenseRepository.GetAnalysisData(analysisQuery);
            if (analysisResult.Tables[0].Rows.Count > 0)
            {
                return analysisResult.Tables[0].Rows[0].Field<decimal>("TotalAmountInReturn").GetDefaultValueIfNull<string>("0");
            }

            return string.Format("{0:N2}", default(float));
            // return PartialView("");
        }


        /// <summary>
        /// Reload Model on model state error
        /// </summary>
        /// <param name="transactionViewModel">The transaction view model.</param>
        /// <param name="expenseRepository">The expense repository.</param>
        /// <returns>Model with expense and users.</returns>
        internal static TransactionViewModel ReloadModelOnError(TransactionViewModel transactionViewModel, IExpenseRepository expenseRepository)
        {
            transactionViewModel.Expenses = expenseRepository.GetAllMyExpenses().Tables[0].AsEnumerable().Select(expenses => new SelectListItem
                {
                    Text = expenses.Field<string>("Description"),
                    Value = TypeConversionHelper.GetDefaultValueIfNull<string>(expenses.Field<int>("ExpenseId"))
                });
            transactionViewModel.UsersInExpense = new List<SelectListItem>().AsEnumerable();
            return transactionViewModel;
        }

        /// <summary>
        /// Check Amount Beyond Level
        /// </summary>
        /// <param name="amountReturned">Amount returned.</param>
        /// <param name="selectedExpense">The selected expense id.</param>
        /// <param name="amountReturnedBy">Amount returned by.</param>
        /// <returns>Json result</returns>        
        [PermissionActionFilter(false)]
        public JsonResult CheckAmountBeyondLevel(decimal amountReturned, long selectedExpense, string amountReturnedBy,string amountReceivedBy)
        {
            using (expenseRepository)
            {
                return Json(!expenseRepository.CheckAmountBeyondLevel(amountReturned, selectedExpense, amountReturnedBy, amountReceivedBy), JsonRequestBehavior.AllowGet);
            }
        }
    }
}
