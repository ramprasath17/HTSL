namespace BudgetManager.Repository.RepositoryClass
{
    using System.Data;
    using BudgetManager.DataLibrary;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Entities;
    using System;
    using BudgetManager.Security.UserSessionHandler;

    public class UserAndGroupRepository : IUserAndGroupRepository
    {
        /// <summary>
        /// User session
        /// </summary>
        private readonly IUserSession userSession;

        public UserAndGroupRepository(IUserSession userSession)
        {
            this.userSession = userSession;
        }

        /// <summary>
        /// Get User group Details by Userid
        /// </summary>        
        /// <returns>User Group Data</returns>
        public DataSet GetUserGroups()
        {
            object[] objUserGroup = new object[1];
            objUserGroup[0] = userSession.CompanyId;
            DataSet userPermissionDataSet = DataLibrary.ExecuteDataSet(ref objUserGroup, "bspGetUSerGroup");
            return userPermissionDataSet;
        }

        /// <summary>
        /// Create USer Group
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <param name="groupName">Group Name</param>
        public void CreateUserGroup(string userId, string groupName)
        {
            object[] objCreateGroup = new object[2];
            objCreateGroup[0] = userId;
            objCreateGroup[1] = groupName;
            DataLibrary.ExecuteQuery(ref objCreateGroup, "bspAddApplicationUserGroup");
        }

        /// <summary>
        /// Get the list of application users
        /// </summary>
        /// <returns>Dataset</returns>
        public DataSet GetAllApplicationUsers()
        {
            object[] objUserParameter = new object[1];
            objUserParameter[0] = userSession.CompanyId;
            DataSet userPermissionDataSet = DataLibrary.ExecuteDataSet(ref objUserParameter, "bspGetApplicationUsers");
            return userPermissionDataSet;
        }

        /// <summary>
        /// To add the user group to the application
        /// </summary>
        /// <returns>True if success else false</returns>
        public bool AddUserGroup(string userId, string groupName, string selectedUsers)
        {
            object[] objAddUserGroup = new object[4];
            objAddUserGroup[0] = userId;
            objAddUserGroup[1] = groupName;
            objAddUserGroup[2] = selectedUsers;
            objAddUserGroup[3] = userSession.CompanyId;
            return DataLibrary.ExecuteQuery(ref objAddUserGroup, "bspCreateUserGroup") > 0 ? true : false;
        }

        /// <summary>
        /// Check group already exists
        /// </summary>
        /// <param name="groupName">Group Name</param>
        /// <returns>True if exists else false</returns>
        public bool CheckGroupAlreadyExists(string groupName)
        {
            object[] objCheckGroup = new object[2];
            objCheckGroup[0] = groupName;
            objCheckGroup[1] = userSession.CompanyId;
            return DataLibrary.ExecuteReaderSql(ref objCheckGroup, "bspCheckGroupAlreadyExists").HasRows;
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
