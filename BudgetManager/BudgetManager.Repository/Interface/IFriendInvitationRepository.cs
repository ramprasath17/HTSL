namespace BudgetManager.Repository.Interface
{
    using BudgetManager.Entities.NamedConstants;
    using System.Data;

    public interface IFriendInvitationRepository
    {
        /// <summary>
        /// Accept Invitation
        /// </summary>
        /// <param name="companyId">Company Id to join</param>
        /// <param name="invitationType">Invitation type to process</param>
        void AcceptInvitation(string userId, long? companyId, string invitationType);

        /// <summary>
        /// Get Users by user name 
        /// </summary>
        /// <param name="userName">User Name</param> 
        /// <param name="loggedInUserId">Logged In User Id</param>
        /// <returns>Dataset</returns>
        DataSet GetUsers(string userName, string loggedInUserId);

        /// <summary>
        /// Get User Details
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <returns>Data set</returns>
        DataSet GetUserDetails(string userId);

        /// <summary>
        /// Log Invitation
        /// </summary>
        /// <param name="invitedUserID">Invited User Id</param>
        /// <param name="invitedBy">Invited By</param>
        /// <param name="invitedCompanyId">Invited User Company Id</param>
        /// <returns>True if success else false</returns>
        bool LogInvitation(string invitedUserID, string invitedBy, string invitedCompanyId);
    }
}
