namespace BudgetManager.Repository.Interface
{
    using System;
    using System.Data;

    public interface IUserAndGroupRepository : IDisposable
    {
        /// <summary>
        /// Get User group Details by Userid
        /// </summary>        
        /// <returns>User Group Data</returns>
        DataSet GetUserGroups();

        /// <summary>
        /// Create USer Group
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <param name="groupName">Group Name</param>
        void CreateUserGroup(string userId, string groupName);

        /// <summary>
        /// Get the list of application users
        /// </summary>
        /// <returns>Dictionary object of user list</returns>
        DataSet GetAllApplicationUsers();

        /// <summary>
        /// To add the user group to the application
        /// </summary>
        /// <returns>True if success else false</returns>
        bool AddUserGroup(string userId, string groupName, string selectedUsers);

        /// <summary>
        /// Check group already exists
        /// </summary>
        /// <param name="groupName">Group Name</param>
        /// <returns>True if exists else false</returns>
        bool CheckGroupAlreadyExists(string groupName);
    }
}
