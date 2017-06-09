namespace BudgetManager.Web.Areas.Expenses.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Web.Mvc;
    using BudgetManager.Helpers;
    using BudgetManager.Infrastructure.Helpers;
    using BudgetManager.Repository.Interface;
    using BudgetManager.SharedAssembly.ExpenseEntity;
    using BudgetManager.Web.ActionFilters;
    using BudgetManager.Web.Areas.Expenses.Models;
    using Aspose.Cells;
    using BudgetManager.Web.Attributes;
    using BudgetManager.ReportUtility;
    using BudgetManager.Entities.NamedConstants;
    using BudgetManager.ReportUtility.Factory.Contract;

    [Authorize]
    [PermissionActionFilter]
    [GroupMenuTitle(Title = "User expenses")]
    public class ExpenseController : Controller
    {
        /// <summary>
        /// Expense Repository 
        /// </summary>
        private readonly IExpenseRepository expenseRepository;

        private readonly IUserRepository userRepository;

        /// <summary>
        /// Initialises new instance of <see cref="ExpenseController"/>
        /// </summary>
        /// <param name="expenseRepository">Expense Repository</param>
        public ExpenseController(IExpenseRepository expenseRepository, IUserRepository userRepository)
        {
            this.expenseRepository = expenseRepository;
            this.userRepository = userRepository;
        }

        /// <summary>
        /// Gets or sets Session User Id
        /// </summary>
        private string SessionUserId
        {
            get
            {
                return Convert.ToString(Session["userId"]);
            }
        }

        /// <summary>
        /// Add user expense
        /// </summary>
        /// <returns>Add my expense view</returns>
        [LinkFilter(LinkText = "Add my expense")]
        [HttpGet]
        public ActionResult AddMyExpense()
        {
            DataSet expenseDetailsDataSet = expenseRepository.GetExpenseLookUp();
            ExpenseViewModel expenseViewModel = new ExpenseViewModel
            {
                Users = expenseDetailsDataSet.Tables[0].LoadLookUps<string, string>(),
                UserGroups = expenseDetailsDataSet.Tables[1].LoadLookUps<string, int>(),
                BudgetCategories = expenseDetailsDataSet.Tables[2].LoadLookUps<string, int>(),
                SpentByUsers = expenseDetailsDataSet.Tables[0].LoadLookUps<string, string>(SessionUserId)
            };
            return View("AddMyExpense", expenseViewModel);
        }

        /// <summary>
        /// Save expense
        /// </summary>
        /// <param name="expenseViewModel">Expense View Model</param>
        /// <returns>Return Add Expense View</returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddMyExpense(ExpenseViewModel expenseViewModel)
        {
            if (ModelState.IsValid)
            {
                ExpenseMembers expenseMembers = new ExpenseMembers
                {
                    Description = expenseViewModel.Description,
                    BudgetCategory = expenseViewModel.SelectedBudget,
                    SelectedGroupId = expenseViewModel.SelectedGroupId.ToList(),
                    SpentAmount = expenseViewModel.SpentAmount.Value,
                    SpentBy = expenseViewModel.SpentBy,
                    SpentOn = expenseViewModel.FormattedSpentDate,
                    IncludedUsers = expenseViewModel.IncludedUsers != null ? expenseViewModel.IncludedUsers.ToList() : new List<string>(),
                    ExcludedUsers = expenseViewModel.ExcludedUsers != null ? expenseViewModel.ExcludedUsers.ToList() : new List<string>(),
                    CreatedBy = SessionUserId
                };
                expenseRepository.AddExpense(expenseMembers);
                return RedirectToAction("AddMyExpense");
            }
            else
            {
                DataSet expenseDetailsDataSet = expenseRepository.GetExpenseLookUp();
                expenseViewModel.Users = expenseDetailsDataSet.Tables[0].LoadLookUps<string, int>();
                expenseViewModel.UserGroups = expenseDetailsDataSet.Tables[1].LoadLookUps<string, int>();
                expenseViewModel.BudgetCategories = expenseDetailsDataSet.Tables[2].LoadLookUps<string, int>();
                expenseViewModel.SpentByUsers = expenseDetailsDataSet.Tables[0].LoadLookUps<string, string>(SessionUserId);
                ModelState.AddModelError("", "Error saving your expense.");
                return View("AddMyExpense", expenseViewModel);
            }
        }

        /// <summary>
        /// Manage Expenses
        /// </summary>
        /// <returns>Manage Expenses View</returns>
        [HttpGet]
        [LinkFilter(LinkText = "Manage expense")]
        public ActionResult ManageExpenses()
        {
            using (expenseRepository)
            {
                DataSet expenseDetail = expenseRepository.GtExpenseDetails();
                var usersInExpense = expenseDetail.Tables[1].AsEnumerable().Select(userResults => new UsersInExpense
                {
                    UserId = userResults.Field<string>("UserId").GetDefaultValueIfNull<string>(),
                    UserDisplayName = userResults.Field<string>("DisplayName"),
                    ExpenseID = userResults.Field<int>("ExpenseId"),
                    GroupId = userResults.Field<int>("GroupId"),
                });
                List<ExpenseViewModel> expenseViewModel = expenseDetail.Tables[0].AsEnumerable().Select(results => new ExpenseViewModel
                {
                    Description = results.Field<string>("Description"),
                    SpentBy = results.Field<string>("SpentBy"),
                    DisplaySpentDate = results.Field<DateTime>("SpentOn").GetDefaultValueIfNull<DateTime>(),
                    SpentAmount = results.Field<decimal>("SpentAmount").GetDefaultValueIfNull<float>(),
                    SelectedBudget = results.Field<string>("BudgetName"),
                    Id = results.Field<int>("ExpenseID").GetDefaultValueIfNull<int>(),
                    Users = usersInExpense.Where(users => users.GroupId == results.Field<int>("GroupId").GetDefaultValueIfNull<int>()
                        && users.ExpenseID == results.Field<int>("ExpenseId").GetDefaultValueIfNull<int>())
                    .Select(userResults => new SelectListItem
                    {
                        Text = userResults.UserDisplayName,
                        Value = userResults.UserId
                    }),
                }).ToList();

                DataSet expenseDetailsDataSet = expenseRepository.GetExpenseLookUp();
                ManageExpenseViewModel manageExpenseViewModel = new ManageExpenseViewModel
                {
                    ExpenseDetails = expenseViewModel,
                    ExpenseLookUpData = new SharedAssembly.ApplicationLookUps.ExpenseLookUp
                    {
                        Users = AppDataTableExtensions.LoadLookUpsDictionary<string, string>(expenseDetailsDataSet.Tables[0], field1: "Value", field2: "Text"),
                        Category = AppDataTableExtensions.LoadLookUpsDictionary<string, string>(expenseDetailsDataSet.Tables[2], field1: "Value", field2: "Text")
                    }
                };
                return View("ManageExpenses", manageExpenseViewModel);
            }
        }

        /// <summary>
        /// View Overall expenses
        /// </summary>
        /// <returns>Overall expenses data</returns>
        [HttpGet]
        [LinkFilter(LinkText = "Overall expenses")]
        public ActionResult OverallExpenses()
        {
            IEnumerable<CalculatedExpenseViewModel> expenseViewModel = null;
            using (expenseRepository)
            {
                expenseViewModel = expenseRepository.GetOverallExpenses().Tables[0].AsEnumerable().Select(expenses => new CalculatedExpenseViewModel
                {
                    ExpenseId = expenses.Field<int>("ExpenseId"),
                    ExpenseDescription = expenses.Field<string>("Description"),
                    IsRemittance = expenses.Field<bool>("IsRemittance"),
                    SpentBy = expenses.Field<string>("SpentBy"),
                    UserInExpense = expenses.Field<string>("UserName"),
                    SpentAmount = expenses.Field<decimal?>("SpentAmount"),
                    AmountInReturn = expenses.Field<decimal?>("AmountInReturn"),
                    SpentOn = expenses.Field<DateTime>("SpentOn"),
                    BudgetGroup = expenses.Field<string>("BudgetGroup"),
                    AmountToShare = expenses.Field<decimal?>("AmountToShare"),
                }).OrderBy(expenses => expenses.ExpenseDescription);
            }

            return View("OverallExpenses", expenseViewModel);
        }

        [PermissionActionFilter(false)]
        public void Download(String fileType)
        {
            DataTable overAllExpenseTable = expenseRepository.GetOverallExpenses().Tables[0];
            IReportFactory reportFactory = ReportFactoryCreator.CreateReportInstance(ReportType.Expense);
            reportFactory.GenerateReport(overAllExpenseTable, fileType.ConvertToEnum<ReportFormat>(), ReportType.Expense);            
        }
    }
}