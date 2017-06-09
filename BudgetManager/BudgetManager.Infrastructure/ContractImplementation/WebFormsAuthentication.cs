namespace BudgetManager.Infrastructure.ContractImplementation
{
    #region "Namespaces"
    using System.Web.Security;
    using BudgetManager.Infrastructure.Contracts;
    using WebMatrix.WebData;
    using BudgetManager.Repository.Interface;
    #endregion

    public class WebFormsAuthentication : IWebFormsAuthentication
    {
        private readonly IUserRepository userRepository;

        public WebFormsAuthentication(IUserRepository userRepository)
        {
            this.userRepository = userRepository;
        }

        /// <summary>
        /// Will sign out the user logged in
        /// </summary>
        /// <param name=""></param>
        public void SignOutLoggedInUser()
        {
            FormsAuthentication.SignOut();
        }

        /// <summary>
        /// To set the form authentication cookie on successful log in
        /// </summary>
        /// <param name="UserName">User name</param>
        /// <param name="IsPersistantCookie">whether the cookie is a persistant or short lived one</param>
        public void SetFormsAuthenticationForLoggedInUser(string UserName, bool IsPersistantCookie)
        {
            //Requires the addition of System.Web; System.Web.ApplicationServices; dlls reference when explicity defined out of the web application
            FormsAuthentication.SetAuthCookie(UserName, IsPersistantCookie);
        }

        /// <summary>
        /// Log in the user into the application
        /// </summary>
        /// <param name="userName">User name</param>
        /// <param name="password">Password</param>
        /// <param name="persistCookie">Persist cookie.</param>
        /// <returns>True if useer is valid else false.</returns>
        public bool LogIn(string userName, string password, bool persistCookie)
        {
            return WebSecurity.Login(userName, password, persistCookie);
        }

        /// <summary>
        /// Confirm account by e-mail verification
        /// </summary>
        /// <param name="userName">User name/Id</param>
        /// <param name="accountConfirmationToken">Email id to confirm.</param>
        /// <returns>true if verified else false.</returns>
        public bool ConfirmAccount(string userName, string accountConfirmationToken)
        {
            return WebSecurity.ConfirmAccount(userName, accountConfirmationToken);
        }

        /// <summary>
        /// Reset the password on request
        /// </summary>
        /// <param name="email">Email id</param>
        /// <param name="newPassword">new re-generated password</param>
        /// <returns>Return user name and regenerated password</returns>
        public string[] ResetPassword(string email, string newPassword)
        {
            return userRepository.ResetPassword(email, newPassword);
        }
    }
}
