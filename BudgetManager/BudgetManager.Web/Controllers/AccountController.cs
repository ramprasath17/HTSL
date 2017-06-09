namespace BudgetManager.Web.Controllers
{
    #region NameSpace

    using System.Linq;
    using System.Web;
    using System.Web.Mvc;
    using BudgetManager.Entities;
    using BudgetManager.Infrastructure.Contracts;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Security.EncDec;
    using BudgetManager.Web.Models;
    using WebMatrix.WebData;
    using System.Data;
    using System;
    using BudgetManager.Infrastructure.Helpers;
    using AutoMapper;
    using BudgetManager.SharedAssembly.Account;

    #endregion

    [Authorize]
    public class AccountController : Controller
    {
        #region Dependency Injector Objects
        //Using dependency injection to make the items loosely coupled - It is also called as Inversion of Control      
        IWebFormsAuthentication webFormsAuthentication;

        /// <summary>
        /// UserRepository Factory
        /// </summary>
        IUserRepository userRepository;

        /// <summary>
        /// Mailer
        /// </summary>
        public readonly IMailer mailer;

        /// <summary>
        /// Data Morph factory
        /// </summary>
        public readonly IDataMorpher encDecryption;
        #endregion

        #region Dependency Injection

        public AccountController(IWebFormsAuthentication webFormsAuthentication, IUserRepository userRepository, IDataMorpher encDecryption, IMailer mailer)
        {
            this.webFormsAuthentication = webFormsAuthentication;
            this.userRepository = userRepository;
            this.encDecryption = encDecryption;
            this.mailer = mailer;
        }
        #endregion

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

        #region Action Methods

        /// <summary>
        /// Log in page
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet]
        public ActionResult Login()
        {
            return View("LogIn");
        }

        /// <summary>
        /// Log in and redirecct to the dashboard
        /// </summary>
        /// <param name="accountViewModel"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Login(LogInViewModel accountViewModel, string redirectUrl)
        {
            if (ModelState.IsValid)
            {
                using (userRepository)
                {
                    bool rememberMe = accountViewModel.rememberMe;
                    if (webFormsAuthentication.LogIn(accountViewModel.userName, accountViewModel.password, rememberMe))
                    {
                        //Set the 'display name' as username in the cookie                        
                        webFormsAuthentication.SetFormsAuthenticationForLoggedInUser(Resources.DisplayName, accountViewModel.rememberMe);
                        if (string.IsNullOrEmpty(redirectUrl))
                        {
                            Session["UserId"] = accountViewModel.userName;
                            return RedirectToAction("DashBoard", "UserPermission", routeValues: new { area = "UserPermission" });
                        }
                        else
                        {
                            return Redirect(redirectUrl);
                        }
                    }
                    else
                    {
                        accountViewModel.InvalidLogInAttempts++;
                        var logInErrorMessage = Messages.LogInError;
                        logInErrorMessage = accountViewModel.InvalidLogInAttempts > 2 ? string.Format(Messages.LogInErrorWithForgotPassword, Url.Action("ForgotPassword", "Account")) : logInErrorMessage;
                        ModelState.AddModelError("", logInErrorMessage);
                    }
                }
            }

            return View("LogIn", accountViewModel);
        }

        /// <summary>
        /// Get the home page
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [AllowAnonymous]
        [OutputCache(Duration = 30)]
        public ActionResult Home()
        {
            return View("Home");
        }

        /// <summary>
        /// Registration page
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View("Register");
        }

        /// <summary>
        /// Registration entry
        /// </summary>
        /// <param name="registerViewModel"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Register(RegisterViewModel registerViewModel)
        {
            if (ModelState.IsValid)
            {
                string userName = registerViewModel.userName;
                string password = registerViewModel.password;
                string emailId = registerViewModel.email;
                string displayName = registerViewModel.displayName;
                var statusMessage = Messages.ErrorSendingEmail;
                var hostName = Resources.GetHostName(HttpContext.Request.Url.ToString());
                string mailContent = mailer.MailContentBuilder(Messages.RegistrationMessageBody, new string[] { displayName, hostName, Url.Action("RegisterEmailVerfication", "Account", new { verfid = registerViewModel.emailVerifiationId }) });
                mailer.SetMailData(emailId, Messages.RegistrationSubject, mailContent, true, true);
                if (mailer.SendMail())
                {
                    using (userRepository)
                    {
                        if (!userRepository.AddUser(userName, password, emailId, displayName))
                        {
                            ModelState.AddModelError("", Messages.RegistrationError);
                            return View("Register", registerViewModel);
                        }

                        statusMessage = Messages.RegistrationSuccess;
                    }

                    TempData["statusMessage"] = statusMessage;
                    return RedirectToAction("Messager");
                }

                TempData["statusMessage"] = statusMessage;
                return RedirectToAction("Messager");
            }

            return View("Register", registerViewModel);
        }

        /// <summary>
        /// On successfull registration redirect here
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Messager()
        {
            ViewBag.verificationStatus = TempData["statusMessage"];
            TempData.Clear();
            return View("Messager");
        }

        /// <summary>
        /// Register Email verfication
        /// </summary>
        /// <param name="verfId">Verification Id</param>
        /// <returns>Return Messager View</returns>
        [HttpGet]
        [AllowAnonymous]
        public ActionResult RegisterEmailVerfication(string verfId)
        {
            using (encDecryption)
            {
                var verfData = encDecryption.Decrypt(verfId);
                string[] verfDataSplitted = verfData.Split('~');
                using (userRepository)
                {
                    string verificationStatus = Messages.EmailVerficationError;
                    if (webFormsAuthentication.ConfirmAccount(verfDataSplitted[0], verfDataSplitted[1]))
                    {
                        verificationStatus = Messages.EmailVerificationSuccess;
                    }

                    TempData["statusMessage"] = verificationStatus;
                    return RedirectToAction("Messager");
                }
            }
        }

        /// <summary>
        /// Remote Validation: To check whether the user already exists in the application on registering
        /// </summary>
        /// <returns>returns Json result</returns>
        [AllowAnonymous]
        public JsonResult CheckUserNameIsExists(string userName)
        {
            using (userRepository)
            {
                return Json(!userRepository.CheckUserNameOrEmailIsExists(userName), JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Remote Validation: To check whether the user already exists in the application on registering
        /// </summary>
        /// <returns>returns Json result</returns>
        [AllowAnonymous]
        public JsonResult CheckUserEmailIsExists(string email)
        {
            string fieldName = ModelState.Keys.First();
            using (userRepository)
            {
                return Json(!userRepository.CheckUserNameOrEmailIsExists(email, fieldName), JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Forgot Password
        /// </summary>
        /// <returns>View</returns>
        [HttpGet]
        [AllowAnonymous]
        public ActionResult ForgotPassword()
        {
            return View("ForgotPassword");
        }

        /// <summary>
        /// Send the fogotten password to the reegistered e-mail id
        /// </summary>
        /// <param name="forgotPasswordViewModel">Forgotten Password View Model</param>
        /// <returns>Return to Messages View</returns>
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ForgotPassword(ForgotPasswordViewModel forgotPasswordViewModel)
        {
            string statusMessage = Messages.ErrorSendingEmail;

            if (ModelState.IsValid)
            {
                using (userRepository)
                {
                    string resettedPassword = Zaretto.PasswordGenerator.Creator.Generate(12);
                    string[] forgottenPasswordResult = webFormsAuthentication.ResetPassword(forgotPasswordViewModel.email, encDecryption.Encrypt(resettedPassword));
                    string mesageBody = string.Empty;
                    if (forgottenPasswordResult != null)
                    {
                        if (forgottenPasswordResult.Length > 0)
                        {
                            forgottenPasswordResult[1] = encDecryption.Decrypt(forgottenPasswordResult[1]);
                            mesageBody = mailer.MailContentBuilder(Messages.ForgottenPasswordEmailBody, forgottenPasswordResult);
                            mailer.SetMailData(forgotPasswordViewModel.email, Messages.ForgottenPasswordEmailSubject, mesageBody, true, true);
                            statusMessage = mailer.SendMail() ? Messages.ForgottenPasswordResetSucess : Messages.ForgottenPasswordResetFailure;
                            TempData["statusMessage"] = statusMessage;
                            return RedirectToAction("Messager");
                        }
                    }
                    else
                    {
                        TempData["statusMessage"] = Messages.UserEmailNotExists;
                        return RedirectToAction("Messager");
                    }
                }

                statusMessage = Messages.ErrorRecoverPassword;
            }

            TempData["statusMessage"] = statusMessage;
            return RedirectToAction("Messager");
        }

        [HttpGet]
        public ActionResult Settings()
        {
            DataSet accountSettingsResultSet = userRepository.GetAccountSettingsData(SessionUserId, null);
            AccountSettingsViewModel accountSettings = accountSettingsResultSet.Tables[0].AsEnumerable().Select(results => new AccountSettingsViewModel
            {
                UserName = results.Field<string>("UserName"),
                FirstName = results.Field<string>("FirstName"),
                LastName = results.Field<string>("LastName"),
                MiddleName = results.Field<string>("MiddleName"),
                PetName = results.Field<string>("PetName"),
                Phone = results.Field<string>("Phone"),
                Mobile = results.Field<string>("Mobile"),
                Gender = results.Field<string>("Gender"),
                CompanyId = results.Field<int>("CompanyId"),
                CompanyName = results.Field<string>("CompanyName"),
                AllowInvites = results.Field<bool>("AllowInvites"),
                CurrentPassword = results.Field<string>("CurrentPassword"),
                DateOfBirth = results.Field<DateTime?>("DateOfBirth").GetDefaultValueIfNull<string>(),
                Email = results.Field<string>("Email"),
                AddressLine1 = results.Field<string>("AddressLine1"),
                AddressLine2 = results.Field<string>("AddressLine2"),
                City = results.Field<string>("City"),
                PinCode = results.Field<string>("PinCode"),
                Country = results.Field<string>("Country"),
            }).FirstOrDefault();
            return View("Settings", accountSettings);
        }

        [HttpPost]
        public ActionResult Settings(AccountSettingsViewModel accountSettingsViewModel)
        {
            if (ModelState.IsValid)
            {
                using (userRepository)
                {
                    accountSettingsViewModel.CurrentPassword = encDecryption.Encrypt(accountSettingsViewModel.CurrentPassword);
                    accountSettingsViewModel.NewPassword = encDecryption.Encrypt(accountSettingsViewModel.NewPassword);
                    UserInformation userInformation = Mapper.Map<UserInformation>(accountSettingsViewModel);
                    userRepository.UpdateAccountSettingsData(userInformation);
                }

                return RedirectToAction("Settings", "Account");
            }
            else
            {
                return View("Settings", accountSettingsViewModel);
            }
        }

        /// <summary>
        /// Check user password
        /// </summary>
        /// <param name="CurrentPassword"></param>
        /// <returns></returns>
        public JsonResult CheckUserPassword(string CurrentPassword)
        {
            return Json(userRepository.IsValidPassword(CurrentPassword), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// UnAuthorized access
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult UnAuthorizedAccess()
        {
            return View("UnAuthorizedAccess");
        }

        #endregion
    }
}
