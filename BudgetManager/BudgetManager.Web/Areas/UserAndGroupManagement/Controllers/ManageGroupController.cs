namespace BudgetManager.Web.Areas.UserAndGroupManagement.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Web.Mvc;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Web.ActionFilters;
    using BudgetManager.Web.Areas.UserAndGroupManagement.Models;
    using BudgetManager.Web.Attributes;

    [Authorize]
    [PermissionActionFilter]
    [GroupMenuTitle(Title = "Users & Groups")]
    public class ManageGroupController : Controller
    {
        /// <summary>
        /// User Group Repository
        /// </summary>
        private readonly IUserAndGroupRepository userAndGroupRepository;

        /// <summary>
        /// User Repository
        /// </summary>
        private readonly IUserRepository userRepository;

        /// <summary>
        /// Initialises new instance of <see cref="ManageGroupController"/>
        /// </summary>
        /// <param name="userRepository">UserRepository</param>
        public ManageGroupController(IUserAndGroupRepository userAndGroupRepository, IUserRepository userRepository)
        {
            this.userAndGroupRepository = userAndGroupRepository;
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
        /// Manage Group User 
        /// </summary>
        /// <returns></returns>
        [LinkFilter(LinkText = "Manage groups")]
        [HttpGet]
        public ActionResult ManageGroups()
        {
            DataSet userGroup = this.userAndGroupRepository.GetUserGroups();

            List<GroupViewModel> userGroupList = new List<GroupViewModel>();
            if (userGroup.Tables.Count > 0)
            {
                var usersInGroup = userGroup.Tables[1].AsEnumerable().Select(userResults => new UserAndGroup
                {
                    UserId = userResults.Field<string>("UserId"),                    
                    GroupId = userResults.Field<int>("GroupId"),
                    UserName = userResults.Field<string>("UserName"),
                });

                userGroupList = userGroup.Tables[0].AsEnumerable().Select(result => new GroupViewModel
                {
                    GroupId = result.Field<int>("GroupId"),
                    GroupName = result.Field<string>("GroupName"),
                    IsActive = result.Field<bool>("IsActive") ,
                    UserList = usersInGroup.Where(users => users.GroupId == result.Field<int>("GroupId"))                        
                    .Select(userResults => new SelectListItem
                    {
                        Text = userResults.UserName,
                        Value = userResults.UserId
                    }),
                }).ToList();
            }

            ManageUserGroupViewModel manageUserGroupViewModel = new ManageUserGroupViewModel
            {
                groupViewModelForCreate = new GroupViewModel(),
                groupViewModelListForViewAndEdit = userGroupList
            };
            return View("ManageGroups", userGroupList);
        }

        /// <summary>
        /// Manage  User 
        /// </summary>
        /// <returns></returns>        
        [HttpGet]
        [LinkFilter(LinkText = "Manage users")]
        public ActionResult ManageUsers()
        {
            DataSet applicationUser = this.userAndGroupRepository.GetAllApplicationUsers();
            ManageUsersViewModel manageUsers = new ManageUsersViewModel
            {
                TableId = "User"
            };
            List<ApplicationUserInformation> applicationUserViewModel = new List<ApplicationUserInformation>();
            if (applicationUser.Tables.Count > 0)
            {
                applicationUserViewModel = applicationUser.Tables[0].AsEnumerable().Select(result => new ApplicationUserInformation
                {
                    UserId = result.Field<string>("UserId"),
                    FirstName = result.Field<string>("FirstName"),
                    MiddleName = result.Field<string>("MiddleName"),
                    LastName = result.Field<string>("LastName"),
                    DisplayName = result.Field<string>("DisplayName"),
                    CompanyId = result.Field<int>("CompanyId"),
                    CompanyName = result.Field<string>("CompanyName"),
                }).ToList();
                manageUsers.ApplicationUserInformation = applicationUserViewModel;
            }
            return View("ManageUsers", manageUsers);
        }

        /// <summary>
        /// Create User Group
        /// </summary>
        /// <returns>Create User Group View</returns>        
        [HttpGet]
        [LinkFilter(LinkText = "Create user group")]
        public ActionResult CreateUserGroup()
        {
            GroupViewModel groupViewModel = new GroupViewModel
            {
                UserList = GetAllApplicationUsers(userRepository)
            };
            return View("CreateUserGroup", groupViewModel);
        }

        /// <summary>
        /// CreateUserGroup
        /// </summary>
        /// <param name="userId">User Id</param>       
        /// <param name="groupName">Group Name</param>
        /// <returns>return Json Result</returns>
        [HttpPost]
        [PermissionActionFilter(false)]
        public ActionResult CreateUserGroup(GroupViewModel groupViewModel, string[] SelectedUsers)
        {
            if (ModelState.IsValid)
            {
                using (userAndGroupRepository)
                {
                    if (userAndGroupRepository.AddUserGroup(SessionUserId, groupViewModel.GroupName, String.Join(",", SelectedUsers)))
                    {
                        this.HttpContext.Request.Headers.Add("Status-Alert", "User group - " + groupViewModel.GroupName + " has been successfully created.");
                        return RedirectToAction("CreateUserGroup");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Error in creating User group. Try again!");
                        groupViewModel.UserList = GetAllApplicationUsers(userRepository);
                        return View("CreateUserGroup", groupViewModel);
                    }
                }
            }
            else
            {
                groupViewModel.UserList = GetAllApplicationUsers(userRepository);
                ModelState.AddModelError("", "The submitted form contain errors. Please correct them and submit again!");
                return View("CreateUserGroup", groupViewModel);
            }
        }

        /// <summary>
        /// Check is group already exists
        /// </summary>
        /// <param name="groupName">Group Name</param>
        /// <returns>Json result</returns>
        [HttpGet]
        [PermissionActionFilter(false)]
        public JsonResult CheckIsGroupAlreadyExists(string groupName)
        {
            using (userAndGroupRepository)
            {
                return Json(!userAndGroupRepository.CheckGroupAlreadyExists(groupName), JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Gets the list of users available in the application
        /// </summary>
        /// <param name="userRepository">User Repository</param>
        /// <returns>User List</returns>
        internal static IEnumerable<SelectListItem> GetAllApplicationUsers(IUserRepository userRepository)
        {
            return userRepository.GetAllApplicationUsers().Select(results => new SelectListItem
            {
                Text = results.Value,
                Value = results.Key
            });
        }
    }
}
