namespace BudgetManager.Repository.Interface
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using BudgetManager.SharedAssembly;
    using BudgetManager.SharedAssembly.Account;

    public interface IUserRepository : IDisposable
    {
        /// <summary>
        /// Check whether the user is valid or not
        /// </summary>
        /// <param name="UserName">User Name</param>
        /// <param name="Password">Password</param>
        /// <returns>True if valid else false</returns>
        bool CheckIsValidUser(string UserName, string Password);

        /// <summary>
        /// To add the user to the application
        /// </summary>
        /// <returns>Bool</returns>
        bool AddUser(string userName, string password, string emailId, string displayName);

        /// <summary>
        /// Check whether the user name already exists or not
        /// </summary>
        /// <param name="UserName">chosen user name </param>
        /// <returns>return boolean value either true or false; if true user name exists else not exists.</returns>
        bool CheckUserNameOrEmailIsExists(string userNameOrEmail, string fieldType = "Name");

        /// <summary>
        /// Get all available roles in the application
        /// </summary>
        /// <returns></returns>
        string[] GetAllAvailableRoles();

        /// <summary>
        /// Get the currently available roles for a logged in user 
        /// </summary>
        /// <param name="userName">Name of the logged in user</param>
        /// <returns>Return currently logged in user role</returns>
        string GetCurrentUserRole(string userName);

        /// <summary>
        /// Get the currently available roles for a logged in user 
        /// </summary>
        /// <param name="userName">Name of the logged in user</param>
        /// <returns>Return currently logged in user role</returns>
        bool VerifyAccount(string userName, string emailId);

        /// <summary>
        /// Get the forgot password
        /// </summary>
        /// <param name="emailID"></param>
        /// <param name="newPassword">New password.</param>
        /// <returns>list of email id</returns>
        string[] ResetPassword(string emailID, string newPassword);

        /// <summary>
        /// Gets all of the available screens
        /// </summary>
        /// <returns>List of screen route entity</returns>
        List<SharedAssembly.ScreenRoute> GetAvailableScreens();

        /// <summary>
        /// Add the application screens
        /// </summary>
        void AddApplicationScreens(SharedAssembly.ScreenRoute screens);

        /// <summary>
        /// Check is user has access to screen
        /// </summary>
        /// <param name="userId">Currently logged in user's Id </param>
        /// <param name="screenParameters">Screen url parameters</param>
        /// <returns>True if user has access else false</returns>
        bool CheckIsUserHasAccessOnScreen(string userId, SharedAssembly.ScreenRoute screenParameters);

        /// <summary>
        /// Get the required data for the user permisssion screen
        /// </summary>
        /// <returns>Dataset</returns>
        DataSet GetUserPermissions(string sessionId, bool showUserList = false);

        /// <summary>
        /// Update the user permission for the selected screen
        /// </summary>
        /// <param name="screenId">Screen Id</param>
        /// <param name="actionType">Action Type (R-Read, W-Write, D-Delete)</param>
        /// <param name="isPermitted">Is allowed</param>
        void UpdateScreenPermission(int screenId, char actionType, int isPermitted, string userId);

        /// <summary>
        /// Get the navigation links for the logged in user
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <returns><see cref="UserMenu"/></returns>
        IEnumerable<UserMenu> GetLoggedInUserScreens(string userId);

        /// <summary>
        /// Updates the screen data
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <param name="screenId">Screen Id</param>
        /// <param name="screenParameter">Screen Parameter</param>
        void UpdateScreenData(string userId, int screenId, string screenParameter, char type);

        /// <summary>
        /// Get the list of application users
        /// </summary>
        /// <returns>Dictionary object of user list</returns>
        Dictionary<string, string> GetAllApplicationUsers();

        /// <summary>
        /// Get the account settings data
        /// </summary>
        /// <param name="userId">Logged In User Id</param>
        /// <param name="companyId">Users company</param>
        /// <returns>Data set</returns>
        DataSet GetAccountSettingsData(string userId, long? companyId);

        /// <summary>
        /// Update account settings data.
        /// </summary>
        /// <param name="userInformation">User information</param>
        /// <returns></returns>
        bool UpdateAccountSettingsData(UserInformation userInformation);

        /// <summary>
        /// Get dashboard data
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <returns><see cref="DataSet"/></returns>
        DataSet GetDashboardData(string userId);

        /// <summary>
        /// Check is valid password
        /// </summary>
        /// <param name="currentPassword">The current password.</param>
        /// <returns><see cref="bool"/></returns>
        bool IsValidPassword(string currentPassword);
    }
}
