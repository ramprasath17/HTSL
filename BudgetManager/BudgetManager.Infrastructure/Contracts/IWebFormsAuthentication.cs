namespace BudgetManager.Infrastructure.Contracts
{
    using System.Web.Security;
    public interface IWebFormsAuthentication
    {
        void SignOutLoggedInUser();
        void SetFormsAuthenticationForLoggedInUser(string userName, bool IsPersistantCookie);
        bool LogIn(string userName, string Password, bool persistCookie);

        /// <summary>
        /// Confirm account by e-mail verification
        /// </summary>
        /// <param name="userName">User name/Id</param>
        /// <param name="accountConfirmationToken">Email id to confirm.</param>
        /// <returns>true if verified else false.</returns>
        bool ConfirmAccount(string userName, string accountConfirmationToken);

        /// <summary>
        /// Reset the password on request
        /// </summary>
        /// <param name="email">Email id</param>
        /// <param name="newPassword">new re-generated password</param>
        /// <returns>Return user name and regenerated password</returns>
        string[] ResetPassword(string email, string newPassword);
    }
}
