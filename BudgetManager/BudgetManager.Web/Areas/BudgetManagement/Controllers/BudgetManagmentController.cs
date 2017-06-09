namespace BudgetManager.Web.Areas.BudgetManagement.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Web.Mvc;
    using BudgetManager.Entities.NamedConstants;
    using BudgetManager.Helpers;
    using BudgetManager.Infrastructure.Helpers;
    using BudgetManager.ReportUtility;
    using BudgetManager.ReportUtility.Factory.Contract;
    using BudgetManager.Repository.Interface;
    using BudgetManager.SharedAssembly;
    using BudgetManager.SharedAssembly.ApplicationLookUps;
    using BudgetManager.Web.ActionFilters;
    using BudgetManager.Web.Areas.BudgetManagement.Models;
    using BudgetManager.Web.Attributes;
    using BudgetEntity = BudgetManager.SharedAssembly.BudgetEntity;

    [Authorize]
    [PermissionActionFilter]
    [GroupMenuTitle(Title = "Budget management")]
    public class BudgetManagementController : Controller
    {
        /// <summary>
        /// Budget Repository
        /// </summary>
        private readonly IBudgetRepository budgetRepository;

        /// <summary>
        /// Initialises new instance of <see cref="BudgetManagementController"/>
        /// </summary>
        public BudgetManagementController(IBudgetRepository budgetRepository)
        {
            this.budgetRepository = budgetRepository;
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
        /// Show the list pf available budget
        /// </summary>
        /// <returns>View Budget</returns>
        [LinkFilter(LinkText = "View Budget")]
        public ActionResult ViewBudget()
        {
            DataSet budgetListSet = budgetRepository.GetAvailableBudgets(SessionUserId);
            List<BudgetDetails> budgetViewModel = new List<BudgetDetails>();
            BudgetLookUp budgetLookUp = new BudgetLookUp();
            if (budgetListSet.Tables.Count > 0)
            {
                budgetViewModel = budgetListSet.Tables[0].AsEnumerable().Select(result => new BudgetDetails
                {
                    BudgetId = result.Field<int?>("BudgetId"),
                    BudgetName = result.Field<string>("Name"),
                    BudgetDescription = result.Field<string>("Description"),
                    StartDate = result.Field<DateTime>("StartDate"),
                    EndDate = result.Field<DateTime>("EndDate"),
                    IsActive = result.Field<bool?>("IsActive").GetDefaultValueIfNull<bool>(),
                    SelectedCategory = result.Field<string>("Category"),
                    CreatedBy = result.Field<string>("CreatedBy"),
                    MinimumAmountAllocated = result.Field<decimal>("MinAmount").GetDefaultValueIfNull<string>(),
                    MaximumAmountAllocated = result.Field<decimal>("MaxAmount").GetDefaultValueIfNull<string>(),
                    CanExceedMaximumAmount = result.Field<bool>("CanExceedMaximumAmount").GetDefaultValueIfNull<bool>()
                }).ToList();

                budgetLookUp.Category = budgetListSet.Tables[1].AsEnumerable().ToDictionary<DataRow, string, string>(
                    result => result.Field<int>("CategoryId").GetDefaultValueIfNull<string>(),
                    result => result.Field<string>("CategoryName").GetDefaultValueIfNull<string>()
                    );
            }

            ManageBudgetViewModel manageBudgetData = new ManageBudgetViewModel
            {
                BudgetDetails = budgetViewModel,
                BudgetLookUpData = budgetLookUp

            };
            manageBudgetData.BudgetDetails = budgetViewModel;
            return View("ViewBudget", manageBudgetData);
        }

        /// <summary>
        /// Gets the available Budget Category
        /// </summary>
        /// <returns>Budget Category View</returns>
        [LinkFilter(LinkText = "Manage budget category")]
        [HttpGet]
        public ActionResult ManageBudgetCategory()
        {
            ManageBudgetCategoryViewModel budgetDetailsViewModel = new ManageBudgetCategoryViewModel
            {
                AddCategory = new BudgetCategory(),
                Categories = budgetRepository.GetAvailableBudgetCategory().Tables[0].AsEnumerable().Select(result => new BudgetCategory
                {
                    CategoryId = result.Field<int>("CategoryId"),
                    CategoryName = result.Field<string>("CategoryName"),
                    CreatedBy = result.Field<string>("CreatedBy")
                }).ToList()
            };
            return View("ManageBudgetCategory", budgetDetailsViewModel);
        }

        /// <summary>
        /// Save the budget category
        /// </summary>
        /// <returns>budget category</returns>        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ManageBudgetCategory(ManageBudgetCategoryViewModel budgetDetailsViewModel, string categoryName)
        {
            if (ModelState.IsValid)
            {
                using (budgetRepository)
                {
                    if (budgetRepository.AddBudgetCategory(categoryName, SessionUserId))
                    {
                        return RedirectToAction("ManageBudgetCategory");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Error in creating budget category. Try again!");
                    }
                }
            }
            else
            {
                ModelState.AddModelError("", "The submitted form contain errors. Please correct them and submit again!");
            }

            budgetDetailsViewModel.AddCategory = new BudgetCategory
            {
                CategoryName = categoryName
            };
            return View("ManageBudgetCategory", budgetDetailsViewModel);
        }

        /// <summary>
        /// Get the create budget screen
        /// </summary>
        /// <returns>Create budget view</returns>
        [LinkFilter(LinkText = "Create budget")]
        [HttpGet]
        public ActionResult CreateBudget()
        {
            BudgetDetails budgetDetailsViewModel = new BudgetDetails
            {
                Categories = GetAvailableBudgetCategory(budgetRepository)
            };
            return View("CreateBudget", budgetDetailsViewModel);
        }

        /// <summary>
        /// Creating Budget on post back
        /// </summary>
        /// <param name="budgetDetailsViewModel"></param>
        /// <returns>Create budget view</returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateBudget(BudgetDetails budgetDetailsViewModel, string selectedCategory)
        {
            if (ModelState.IsValid)
            {
                using (budgetRepository)
                {
                    string[] dateRange;
                    if (budgetDetailsViewModel.BudgetPeriod.Contains('-'))
                    {
                        dateRange = budgetDetailsViewModel.BudgetPeriod.Split('-');
                    }
                    else
                    {
                        dateRange = new string[] { budgetDetailsViewModel.BudgetPeriod, budgetDetailsViewModel.BudgetPeriod };
                    }

                    BudgetEntity.BudgetDetails createBudgetData = new BudgetEntity.BudgetDetails
                    {
                        BudgetName = budgetDetailsViewModel.BudgetName,
                        BudgetDescription = budgetDetailsViewModel.BudgetDescription,
                        MinimumAmount = budgetDetailsViewModel.MinimumAmountAllocated,
                        MaximumAmount = budgetDetailsViewModel.MaximumAmountAllocated,
                        StartDate = Convert.ToDateTime(dateRange[0].TrimEnd()),
                        EndDate = Convert.ToDateTime(dateRange[1].TrimStart()),
                        CreatedBy = SessionUserId,
                        Category = selectedCategory
                    };
                    if (budgetRepository.AddBudget(createBudgetData))
                    {
                        return RedirectToAction("CreateBudget");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Error in creating budget. Try again!");
                    }
                }
            }
            else
            {
                ModelState.AddModelError("", "The submitted form contain errors. Please correct them and submit again!");
            }

            budgetDetailsViewModel.Categories = GetAvailableBudgetCategory(budgetRepository);
            return View("CreateBudget", budgetDetailsViewModel);
        }

        /// <summary>
        /// Get budget summary
        /// </summary>
        /// <returns>Budget summary view</returns>
        [HttpGet]
        [LinkFilter(LinkText = "Summary")]
        public ActionResult Summary()
        {
            ManageBudgetViewModel budgetSummaryViewModel = new ManageBudgetViewModel();

            using (budgetRepository)
            {
                DataSet budgetSummaryResult = budgetRepository.GetBudgetSummary();

                budgetSummaryViewModel.BudgetDetails = budgetSummaryResult.Tables[0].AsEnumerable().Select(summary => new BudgetDetails()
            {
                BudgetName = summary.Field<string>("Name"),
                BudgetDescription = summary.Field<string>("Description"),
                SelectedCategory = summary.Field<string>("Category"),
                StartDate = summary.Field<DateTime>("StartDate"),
                EndDate = summary.Field<DateTime>("EndDate"),
                MaximumAmountAllocated = summary.Field<decimal?>("MaxAmount").GetDefaultValueIfNull<string>(),
                SpentAmount = summary.Field<decimal?>("SpentAmount") ?? 0,
                Level = new ToolTipLabel
                {
                    LabelText = summary.Field<int>("Level").GetEnumAttributeFromValue<BudgetLevels>(EnumAttributeTypes.DisplayIcon),
                    ToolTipText = summary.Field<int>("Level").GetEnumAttributeFromValue<BudgetLevels>(EnumAttributeTypes.Description)
                },
                Status = new ToolTipLabel
                {
                    LabelText = summary.Field<int>("Status").GetEnumAttributeFromValue<BudgetStatus>(EnumAttributeTypes.DisplayIcon),
                    ToolTipText = summary.Field<int>("Status").GetEnumAttributeFromValue<BudgetStatus>(EnumAttributeTypes.Description)
                }
            }).ToList();
            }

            budgetSummaryViewModel.BudgetDetails = budgetSummaryViewModel.BudgetDetails ?? new List<BudgetDetails>();
            return View("Summary", budgetSummaryViewModel);
        }

        /// <summary>
        /// Check is budget already exists
        /// </summary>
        /// <param name="BudgetName"></param>
        /// <returns></returns>
        [PermissionActionFilter(false)]
        public JsonResult IsBudgetExists(string budgetName)
        {
            using (budgetRepository)
            {
                return Json(!budgetRepository.CheckBudgetExists(budgetName), JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Check category already exists
        /// </summary>
        /// <param name="categoryName">Category Name</param>
        /// <returns>Json result</returns>        
        [PermissionActionFilter(false)]
        public JsonResult CheckCategoryAlreadyExists(string categoryName)
        {
            using (budgetRepository)
            {
                return Json(!budgetRepository.CheckCategoryExists(categoryName), JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Get Available Budget Category
        /// </summary>
        /// <param name="budgetRepository">Budget Repository</param>
        /// <returns>Category List</returns>
        internal static IEnumerable<SelectListItem> GetAvailableBudgetCategory(IBudgetRepository budgetRepository)
        {
            return budgetRepository.GetAvailableBudgetCategory().Tables[0].AsEnumerable().Select(result => new SelectListItem
            {
                Text = result.Field<string>("CategoryName"),
                Value = TypeConversionHelper.GetDefaultValueIfNull<string>(result.Field<int>("CategoryId"))
            });
        }

        /// <summary>
        /// Generate BudgetSummary Report
        /// </summary>
        /// <returns>BudgetSummary data</returns>
        [PermissionActionFilter(false)]
        public ActionResult Download(String fileType)
        {
            DataTable BudgetSummaryTable = budgetRepository.GetBudgetSummary().Tables[0];
            IReportFactory reportFactory = ReportFactoryCreator.CreateReportInstance(ReportType.BudgetSummary);
            ReportFormat reportFormat;
            Enum.TryParse<ReportFormat>(fileType, true, out reportFormat);
            reportFactory.GenerateReport(BudgetSummaryTable, reportFormat, ReportType.BudgetSummary);
            return View();
        }
    }
}