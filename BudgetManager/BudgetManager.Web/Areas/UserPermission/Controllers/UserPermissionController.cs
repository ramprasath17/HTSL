namespace BudgetManager.Web.Areas.UserPermission
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Web.Mvc;
    using System.Web.Security;
    using BudgetManager.Entities.NamedConstants;
    using BudgetManager.Infrastructure.HttpCacheExtensions;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Web.ActionFilters;
    using BudgetManager.Web.Areas.UserPermission.Models;
    using BudgetManager.Web.Areas.UserPermission.Models.UserPermissionModelBusinessLogic;
    using BudgetManager.Web.Attributes;
    using BudgetManager.SharedAssembly;
    using System.Drawing;

       
    [Authorize]
    [PermissionActionFilter]
    [GroupMenuTitle(Title = "User permissions")]
    public class UserPermissionController : Controller
    {
        /// <summary>
        /// User Repository
        /// </summary>
        private readonly IUserRepository userRepository;

        /// <summary>
        /// Initialises new instance of <see cref="UserPermissionController"/>
        /// </summary>
        /// <param name="userRepository">UserRepository</param>
        public UserPermissionController(IUserRepository userRepository)
        {
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
        /// Loads the user dashboard
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [LinkFilter(LinkText = "Dashboard", Read = true)]
        public ActionResult DashBoard()
        {
           var random = new Random();
            //var color = ; 
            DashboardViewModel dashboardViewModel;
            using (userRepository)
            {
                DataSet dashBoadData = userRepository.GetDashboardData(SessionUserId);
                dashboardViewModel =  new DashboardViewModel
                {
                    TotalGroups = dashBoadData.Tables[0].Rows[0].Field<int>("GroupCount"),
                    TotalUsers = dashBoadData.Tables[0].Rows[0].Field<int>("UserCount"),
                    TotalBudgets = dashBoadData.Tables[0].Rows[0].Field<int>("BudgetCount"),
                    BudgetChartData = dashBoadData.Tables[1].AsEnumerable().Select(chartData => new ChartTemplate
                    {
                        label = chartData.Field<string>("Name"),
                        data = chartData.Field<string>("BudgetAmount"),
                        color = String.Format("#{0:X6}", random.Next(0x1000000)),
                    })
                };
            }

            return View("DashBoard", dashboardViewModel);
        }

        /// <summary>
        /// Logs out the current user session
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [PermissionActionFilter(false)]
        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Home", "Account", routeValues: new { area = "" });
        }

        /// <summary>
        /// User Permission
        /// </summary>
        /// <returns>userPermision View</returns>
        [HttpGet]
        [LinkFilter(LinkText = "User permissions", Read = true, Write = true, Delete = true)]
        public ActionResult UserPermissions()
        {
            string sessionId = Convert.ToString(Session["UserId"]);
            DataSet userPermissionDataSet = userRepository.GetUserPermissions(sessionId, true);

            UserPermissionsViewModel userPermissionsViewModel = new UserPermissionsViewModel();
            userPermissionsViewModel.ApplicationUsers = new List<ApplicationUsers>();
            userPermissionsViewModel.ScreenAndPermissions = new List<ScreenAndPermissions>();

            userPermissionsViewModel.ApplicationUsersSelectList = userPermissionDataSet.Tables[0].AsEnumerable()
                .Select(result => new SelectListItem
                {
                    Text = result.Field<string>("DisplayName"),
                    Value = result.Field<string>("UserId"),
                    Selected = String.Equals(result.Field<string>("UserId"), sessionId, StringComparison.InvariantCultureIgnoreCase)
                });

            userPermissionsViewModel.ScreenAndPermissions = UserPermissionModelBusinessLogic.GetUserPermissionFromDataTable(userPermissionDataSet.Tables[1], sessionId);

            return View("UserPermissions", userPermissionsViewModel);
        }

        /// <summary>
        /// Update screen permission
        /// </summary>
        /// <param name="screenId">Screen Id</param>
        /// <param name="permissionType">Permission Type</param>
        /// <param name="isChecked">Is Checked</param>
        /// <param name="sesId">Session Id</param>
        /// <returns>return Json Result</returns>
        [HttpPost]
        [PermissionActionFilter(false)]
        public JsonResult UpdateScreenPermission(int screenId, char permissionType, int isChecked, string sesId)
        {
            char actionType = permissionType;
            userRepository.UpdateScreenPermission(screenId, actionType, isChecked, sesId);
            HttpCacheExtensions.DeleteObjectFromCache("UserNavLinks_" + SessionUserId);
            HttpCacheExtensions.GetLoggedInUserScreens(SessionUserId, userRepository);
            return Json(string.Empty, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Update screen data
        /// </summary>
        /// <param name="screenId">Screen Id</param>
        /// <param name="screenParameter">Screen Parameter</param>
        /// <returns>Json data</returns>
        [HttpPost]
        [PermissionActionFilter(false)]
        public JsonResult UpdateScreenData(int screenId, string screenParameter, string sessionUserId, char type)
        {
            userRepository.UpdateScreenData(sessionUserId, screenId, screenParameter, type);
            return Json(string.Empty, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Get Permissions for logged in user
        /// </summary>
        /// <param name="sesId">Session Id</param>
        /// <returns>Return Partial View</returns>
        [PermissionActionFilter(false)]
        public PartialViewResult GetPermissionsForSelectedUser(string sesId)
        {
            DataSet userPermissionDataSet = userRepository.GetUserPermissions(sesId);
            UserPermissionsViewModel userPermissionsViewModel = new UserPermissionsViewModel();
            userPermissionsViewModel.ApplicationUsers = new List<ApplicationUsers>();
            userPermissionsViewModel.ScreenAndPermissions = new List<ScreenAndPermissions>();

            userPermissionsViewModel.ScreenAndPermissions = UserPermissionModelBusinessLogic.GetUserPermissionFromDataTable(userPermissionDataSet.Tables[0], SessionUserId);
            userPermissionsViewModel.IconList = UserPermissionModelBusinessLogic.GetIconList<FontIcons>();

            return PartialView("_UserPermissions", userPermissionsViewModel);
        }
    }
}
