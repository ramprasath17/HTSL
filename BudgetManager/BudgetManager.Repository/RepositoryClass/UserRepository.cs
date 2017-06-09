namespace BudgetManager.Repository.RepositoryClass
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    using System.Linq;
    using BudgetManager.DataLibrary;
    using BudgetManager.Entities;
    using BudgetManager.Infrastructure.Helpers;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Security.EncDec;
    using BudgetManager.SharedAssembly;
    using BudgetManager.Helpers.Permissions.Contract;
    using BudgetManager.Security.UserSessionHandler;
    using BudgetManager.SharedAssembly.Account;
    using BudgetManager.Helpers.DBHelpers;

    public class UserRepository : IUserRepository
    {
        /// <summary>
        /// Data morpher
        /// </summary>
        private readonly IDataMorpher encDecryption;

        /// <summary>
        /// Permission Helper
        /// </summary>
        private readonly IPermissionHelper permissionHelper;

        /// <summary>
        /// User session
        /// </summary>
        private readonly IUserSession userSession;

        /// <summary>
        /// Initialises new instance of <see cref="UserRepository"/>
        /// </summary>
        public UserRepository()
        {
        }

        /// <summary>
        /// Initialises new instance of <see cref="UserRepository"/>
        /// </summary>
        /// <param name="encDecryption">Encryption Decryption</param>
        /// <param name="permissionHelper">Permission Helper</param>
        public UserRepository(IDataMorpher encDecryption, IPermissionHelper permissionHelper, IUserSession userSession)
        {
            this.encDecryption = encDecryption;
            this.permissionHelper = permissionHelper;
            this.userSession = userSession;
        }

        /// <summary>
        /// To check whether the user is a valid user
        /// </summary>
        /// <param name="UserName">User name</param>
        /// <param name="Password">password</param>
        /// <returns></returns>
        public bool CheckIsValidUser(string UserName, string Password)
        {
            object[] objUserCredentials = new object[2];
            objUserCredentials[0] = UserName;
            objUserCredentials[1] = encDecryption.Encrypt(Password);
            System.Data.DataSet userData = DataLibrary.ExecuteDataSet(ref objUserCredentials, "bspAuthorizeUserLogIn");
            if (userData.Tables.Count > 0)
            {
                if (userData.Tables[0].Rows.Count > 0)
                {
                    DataTable userDataTable = userData.Tables[0];

                    var resultSet = userDataTable.AsEnumerable().Select(result => new { UserName = result.Field<string>("userid"), DisplayName = result.Field<string>("DisplayName"), CompanyId = result.Field<int?>("CompanyId") }).FirstOrDefault();
                    Resources.DisplayName = resultSet.DisplayName;
                    userSession.SetSession("CompanyId", resultSet.CompanyId);
                    userSession.SetSession("DisplayName", resultSet.DisplayName);
                    userData = null;
                    userDataTable = null;
                    if (UserName.ToLower() == resultSet.UserName.ToLower())
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// To add the user to the application
        /// </summary>
        /// <returns>Bool</returns>
        public bool AddUser(string userName, string password, string emailId, string displayName)
        {
            object[] objAddUserParameters = new object[4];
            objAddUserParameters[0] = userName;
            objAddUserParameters[1] = encDecryption.Encrypt(password);
            objAddUserParameters[2] = emailId;
            objAddUserParameters[3] = displayName;
            System.Data.DataSet execResult = DataLibrary.ExecuteDataSet(ref objAddUserParameters, "bspAddUser");
            if (execResult.Tables.Count == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        /// <summary>
        /// Check whether the user name already exists or not
        /// </summary>
        /// <param name="UserName">chosen user name </param>
        /// <returns>return boolean value either true or false; if true user name exists else not exists.</returns>
        public bool CheckUserNameOrEmailIsExists(string userNameOrEmail, string fieldType = "Name")
        {
            object[] objUserCredentials = new object[2];
            objUserCredentials[0] = userNameOrEmail;
            objUserCredentials[1] = fieldType;
            System.Data.DataSet userData = DataLibrary.ExecuteDataSet(ref objUserCredentials, "bspCheckUserNameOrEmailIsExists");
            if (userData.Tables.Count > 0)
            {
                if (userData.Tables[0].Rows.Count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Get all available roles in the application
        /// </summary>
        /// <returns></returns>
        public string[] GetAllAvailableRoles()
        {
            object[] objUserRoles = new object[0];
            ArrayList userRoles = new ArrayList();
            SqlDataReader readData = DataLibrary.ExecuteReaderSql(ref objUserRoles, "bspGetAllAvailableRoles");
            while (readData.Read())
            {
                userRoles.Add(readData.GetValue(0).ToString());
            }
            readData.Dispose();
            return (string[])userRoles.ToArray();
        }

        /// <summary>
        /// Get the currently available roles for a logged in user 
        /// </summary>
        /// <param name="userName">Name of the logged in user</param>
        /// <returns>Return currently logged in user role</returns>
        public string GetCurrentUserRole(string userName)
        {
            object[] objUserRoles = new object[0];
            string userRole = string.Empty;
            SqlDataReader readData = DataLibrary.ExecuteReaderSql(ref objUserRoles, "bspGetCurrentUserRole");
            while (readData.Read())
            {
                userRole = readData.GetValue(0).ToString();
            }
            readData.Dispose();
            return userRole;
        }

        /// <summary>
        /// To verify the email id
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="emailId"></param>
        /// <returns></returns>
        public bool VerifyAccount(string userName, string emailId)
        {
            object[] objChkEmail = new object[2];
            objChkEmail[0] = userName;
            objChkEmail[1] = emailId;
            string userRole = string.Empty;
            bool? isValidVerfId = false;
            SqlDataReader readData = DataLibrary.ExecuteReaderSql(ref objChkEmail, "bspVerifyEmail");
            if (readData != null && !readData.IsClosed)
            {
                while (readData.Read())
                {
                    isValidVerfId = (Nullable<bool>)readData["verified"];
                }
            }

            readData.Dispose();
            return isValidVerfId ?? false;
        }

        /// <summary>
        /// Get the forgot password
        /// </summary>
        /// <param name="emailID"></param>
        /// <param name="newPassword">New password.</param>
        /// <returns>list of email id</returns>
        public string[] ResetPassword(string emailID, string newPassword)
        {
            try
            {
                object[] objForgotPassword = new object[] { emailID, newPassword };
                string[] forgottenPasswordResult = null;
                SqlDataReader readData = DataLibrary.ExecuteReaderSql(ref objForgotPassword, "bspResetPassword");
                if (readData != null && !readData.IsClosed)
                {
                    while (readData.Read())
                    {
                        forgottenPasswordResult = new string[] { readData["DisplayName"].ToString(), readData["PassKey"].ToString() };
                    }
                }

                readData.Dispose();
                return forgottenPasswordResult;
            }
            catch
            {
                return null;
            }

        }

        /// <summary>
        /// Gets all of the available screens
        /// </summary>
        /// <returns>List of screen route entity</returns>
        public List<SharedAssembly.ScreenRoute> GetAvailableScreens()
        {
            object[] objUserRoles = new object[0];
            ArrayList userRoles = new ArrayList();
            SqlDataReader readData = DataLibrary.ExecuteReaderSql(ref objUserRoles, "bspGetAllAvailableScreens");
            List<SharedAssembly.ScreenRoute> screenRouteData = new List<SharedAssembly.ScreenRoute>();
            while (readData.Read())
            {
                screenRouteData.Add(new SharedAssembly.ScreenRoute
                {
                    ActionName = readData["screenActionName"].ToString(),
                    AreaName = readData["screenControllerName"].ToString(),
                    ControllerName = readData["screenAreaName"].ToString(),
                });
            }

            readData.Dispose();
            return screenRouteData;
        }

        /// <summary>
        /// Add the application screens
        /// </summary>
        public void AddApplicationScreens(SharedAssembly.ScreenRoute screens)
        {
            object[] objAppScreens = new object[8];
            objAppScreens[0] = screens.ActionName;
            objAppScreens[1] = screens.ControllerName;
            objAppScreens[2] = screens.AreaName;
            objAppScreens[3] = screens.LinkText;
            objAppScreens[4] = screens.GroupMenuTitle;
            objAppScreens[5] = screens.Read;
            objAppScreens[6] = screens.Write;
            objAppScreens[7] = screens.Delete;
            DataLibrary.ExecuteQuery(ref objAppScreens, "bspAddApplicationScreens");
        }

        /// <summary>
        /// Check is user has access to screen
        /// </summary>
        /// <param name="userId">Currently logged in user's Id </param>
        /// <param name="screenParameters">Screen url parameters</param>
        /// <returns>True if user has access else false</returns>
        public bool CheckIsUserHasAccessOnScreen(string userId, SharedAssembly.ScreenRoute screenParameters)
        {
            object[] objAppScreens = new object[5];
            objAppScreens[0] = userId;
            objAppScreens[1] = screenParameters.ActionName;
            objAppScreens[2] = screenParameters.ControllerName;
            objAppScreens[3] = screenParameters.AreaName;
            objAppScreens[4] = userSession.CompanyId;
            bool isReadable = false;
            SqlDataReader userPermissionReader = DataLibrary.ExecuteReaderSql(ref objAppScreens, "bspIsUserHasAccess");
            while (userPermissionReader.Read())
            {
                isReadable = TypeConversionHelper.GetDefaultValueIfNull<bool>(userPermissionReader["isRead"]);
                permissionHelper.SetPermission(isReadable,
                TypeConversionHelper.GetDefaultValueIfNull<bool>(userPermissionReader["isWrite"]),
                TypeConversionHelper.GetDefaultValueIfNull<bool>(userPermissionReader["isDelete"]));
            }

            return isReadable;
        }

        /// <summary>
        /// Get the required data for the user permisssion screen
        /// </summary>
        /// <returns>Dataset</returns>
        public DataSet GetUserPermissions(string sessionId, bool showUserList = false)
        {
            object[] objUserPermissions = new object[3];
            objUserPermissions[0] = sessionId;
            objUserPermissions[1] = showUserList;
            objUserPermissions[2] = userSession.CompanyId;
            DataSet userPermissionDataSet = DataLibrary.ExecuteDataSet(ref objUserPermissions, "bspGetUserPermissions");
            return userPermissionDataSet;
        }

        /// <summary>
        /// Update the user permission for the selected screen
        /// </summary>
        /// <param name="screenId">Screen Id</param>
        /// <param name="actionType">Action Type (R-Read, W-Write, D-Delete)</param>
        /// <param name="isPermitted">Is allowed</param>
        public void UpdateScreenPermission(int screenId, char actionType, int isPermitted, string userId)
        {
            object[] objUserPermission = new object[5];
            objUserPermission[0] = screenId;
            objUserPermission[1] = actionType;
            objUserPermission[2] = isPermitted;
            objUserPermission[3] = userId;
            objUserPermission[4] = userSession.CompanyId;
            DataLibrary.ExecuteQuery(ref objUserPermission, "bspUpdateUserPermission");
        }

        /// <summary>
        /// Get the navigation links for the logged in user
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <returns><see cref="UserMenu"/></returns>
        public IEnumerable<UserMenu> GetLoggedInUserScreens(string userId)
        {
            object[] objUserId = new object[2];
            objUserId[0] = userId;
            objUserId[1] = userSession.CompanyId;
            DataSet userMenuDataSet = DataLibrary.ExecuteDataSet(ref objUserId, "bspGetUserScreens");
            IEnumerable<UserMenu> userMenu = userMenuDataSet.Tables[0].AsEnumerable().GroupJoin(userMenuDataSet.Tables[1].AsEnumerable(), a => a.Field<string>("ControllerName"),
                b => b.Field<string>("ControllerName"), (a, b) => new UserMenu
                {
                    GroupMenuTitle = a.Field<string>("GroupMenuTitle"),
                    Links = b.Select(links => new UserScreenLink
                    {
                        ActionLinkText = links.Field<string>("ActionLinkText"),
                        ActionName = links.Field<string>("ActionName"),
                        AreaName = links.Field<string>("AreaName"),
                        ControllerName = links.Field<string>("ControllerName").Replace("Controller", string.Empty),
                        LinkIcon = links.Field<string>("linkIcon"),
                        LinkOrderId = links.Field<int?>("linkOrderId"),
                        ScreenID = links.Field<int>("screenId")
                    }).ToList()
                });
            return userMenu;
        }

        /// <summary>
        /// Updates the screen data
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <param name="screenId">Screen Id</param>
        /// <param name="screenParameter">Screen Parameter</param>
        public void UpdateScreenData(string userId, int screenId, string screenParameter, char type)
        {
            object[] objScreenParameter = new object[5];
            objScreenParameter[0] = userId;
            objScreenParameter[1] = userSession.CompanyId;
            objScreenParameter[2] = screenId;
            objScreenParameter[3] = screenParameter;
            objScreenParameter[4] = type;

            DataLibrary.ExecuteQuery(ref objScreenParameter, "bspUpdateScreenData");
        }

        // <summary>
        // Get the list of application users
        // </summary>
        // <returns>Dictionary object of user list</returns>
        public Dictionary<string, string> GetAllApplicationUsers()
        {
            object[] objUserParameter = new object[1];
            objUserParameter[0] = userSession.CompanyId;
            Dictionary<string, string> userList = new Dictionary<string, string>();
            SqlDataReader userListReader = DataLibrary.ExecuteReaderSql(ref objUserParameter, "bspGetApplicationUsers");
            while (userListReader.Read())
            {
                userList.Add(TypeConversionHelper.GetDefaultValueIfNull<string>(userListReader["UserId"]), TypeConversionHelper.GetDefaultValueIfNull<string>(userListReader["DisplayName"]));
            }

            return userList;
        }

        /// <summary>
        /// Get the account settings data
        /// </summary>
        /// <param name="userId">Logged In User Id</param>
        /// <param name="companyId">Users company</param>
        /// <returns>Data set</returns>
        public DataSet GetAccountSettingsData(string userId, long? companyId)
        {
            companyId = userSession.CompanyId;
            object[] objAccountInputParameter = new object[2];
            objAccountInputParameter[0] = userId;
            objAccountInputParameter[1] = companyId;
            return DataLibrary.ExecuteDataSet(ref objAccountInputParameter, "bspGetAccountSettingsData");
        }

        /// <summary>
        /// Update account settings data.
        /// </summary>
        /// <param name="userInformation">User information</param>
        /// <returns></returns>
        public bool UpdateAccountSettingsData(UserInformation userInformation)
        {
            object[] userInformationObject = userInformation.BindModelToDBObject<UserInformation>();
            return DataLibrary.ExecuteQuery(ref userInformationObject, "bspUpdateAccountSettingsData") <= 0;
        }

        /// <summary>
        /// Get dashboard data
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <returns><see cref="DataSet"/></returns>
        public DataSet GetDashboardData(string userId)
        {
            object[] objDashBoard = new object[] { userId, userSession.CompanyId };
            return DataLibrary.ExecuteDataSet(ref objDashBoard, "bspGetDashboardBudgetSummary");
        }

        /// <summary>
        /// Check is valid password
        /// </summary>
        /// <param name="currentPassword">The current password.</param>
        /// <returns><see cref="bool"/></returns>
        public bool IsValidPassword(string currentPassword)
        {
            object[] objUserInput = new object[3];
            objUserInput[0] = userSession.UserId;
            objUserInput[1] = userSession.CompanyId;
            objUserInput[2] = encDecryption.Encrypt(currentPassword);
            SqlDataReader sdr = DataLibrary.ExecuteReaderSql(ref objUserInput, "bspCheckIsValidPassword");            
            return sdr.HasRows;
        }

        /// <summary>object
        /// Dispose unused references from memory 
        /// </summary>
        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }
}
