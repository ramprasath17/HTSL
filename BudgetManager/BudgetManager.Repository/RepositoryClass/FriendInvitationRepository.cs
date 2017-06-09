namespace BudgetManager.Repository.RepositoryClass
{
    using BudgetManager.DataLibrary;
    using BudgetManager.Entities;
    using BudgetManager.Entities.NamedConstants;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Security.UserSessionHandler;
    using System;
    using System.Data;

    public class FriendInvitationRepository : IFriendInvitationRepository
    {
        /// <summary>
        /// User session
        /// </summary>
        private readonly IUserSession userSession;

        public FriendInvitationRepository(IUserSession userSession)
        {
            this.userSession = userSession;
        }

        /// <summary>
        /// Accept Invitation
        /// </summary>
        /// <param name="companyId">Company Id to join</param>
        /// <param name="invitationType">Invitation type to process</param>
        public void AcceptInvitation(string userId, long? companyId, string invitationType)
        {
            object[] objFriendInvitation = new object[3];
            objFriendInvitation[0] = companyId;
            objFriendInvitation[1] = userId;
            objFriendInvitation[2] = invitationType;
            DataLibrary.ExecuteQuery(ref objFriendInvitation, "bspAcceptInvitation");
        }

        /// <summary>
        /// Get Users by user name 
        /// </summary>
        /// <param name="userName">User Name</param> 
        /// <param name="loggedInUserId">Logged In User Id</param>
        /// <returns>Dataset</returns>
        public DataSet GetUsers(string userName, string loggedInUserId)
        {
            object[] objGetUsersByUserName = new object[3];
            objGetUsersByUserName[0] = userName;
            objGetUsersByUserName[1] = loggedInUserId;
            objGetUsersByUserName[2] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref objGetUsersByUserName, "bspGetUsersByUserName");
        }

        /// <summary>
        /// Get User Details
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <returns>Data set</returns>
        public DataSet GetUserDetails(string userId)
        {
            object[] objUserDetails = new object[2];
            objUserDetails[0] = userId;
            objUserDetails[1] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref objUserDetails, "bspGetUserDetailsForFriendInvitation");
        }

        /// <summary>
        /// Log Invitation
        /// </summary>
        /// <param name="invitedUserID">Invited User Id</param>
        /// <param name="invitedBy">Invited By</param>
        /// <param name="invitedCompanyId">Invited User Company Id</param>
        /// <returns>True if success else false</returns>
        public bool LogInvitation(string invitedUserID, string invitedBy, string invitedCompanyId)
        {
            bool isLogged = true;
            object[] objLogInvitation = new object[4];
            objLogInvitation[0] = invitedUserID;
            objLogInvitation[1] = invitedBy;
            objLogInvitation[2] = invitedCompanyId;
            objLogInvitation[3] = userSession.CompanyId;

            try
            {
                DataLibrary.ExecuteQuery(ref objLogInvitation, "bspLogInvitation");
            }
            catch (Exception ex)
            {
                isLogged = false;
                throw ex;
            }

            return isLogged;
        }
    }
}
