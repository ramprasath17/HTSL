namespace BudgetManager.Web.Tests.Controllers.Account.Post
{
    using System.Web;
    using System.Web.Mvc;
    using BudgetManager.Infrastructure.Contracts;
    using BudgetManager.Infrastructure.DependencyInjection;
    using BudgetManager.Infrastructure.WebSecurity;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Security.EncDec;
    using BudgetManager.Web.Controllers;
    using BudgetManager.Web.Models;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using Moq;
    using WebMatrix.WebData;

    [TestClass]
    public class LogInTest
    {
        private AccountController accountControllerMockObject;

        private Mock<IWebFormsAuthentication> webFormAuthentication;

        private Mock<IUserRepository> userRepository;

        private Mock<IDataMorpher> dataMorpher;

        private Mock<IMailer> mailer;

        private Mock<AppFittersMembershipProvider> appFittersMembershipProviderMockObject;

        private Mock<ExtendedMembershipProvider> extendeMembershipProviderMockObject;

        [TestInitialize]
        public void Init()
        {
            webFormAuthentication = new Mock<IWebFormsAuthentication>();
            userRepository = new Mock<IUserRepository>();
            dataMorpher = new Mock<IDataMorpher>();
            DependencyResolver.SetResolver(new DependencyInjector());
            mailer = new Mock<IMailer>();
            appFittersMembershipProviderMockObject = new Mock<AppFittersMembershipProvider>();
            extendeMembershipProviderMockObject = new Mock<ExtendedMembershipProvider>();
            accountControllerMockObject = new AccountController(webFormAuthentication.Object, userRepository.Object, dataMorpher.Object, mailer.Object);
        }

        [TestMethod]
        public void LogIn_Check_With_ValidModel_And_ValidUser_With_RedirectUrlAsNull()
        {
            // ARRANGE
            string userName = "userName";
            webFormAuthentication.Setup(method => method.LogIn(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<bool>())).Returns(true);
            accountControllerMockObject = new AccountController(webFormAuthentication.Object, userRepository.Object, dataMorpher.Object, mailer.Object);
            // Set controller context
            Mock<ControllerContext> controllerContext = new Mock<ControllerContext>();
            // Set session state
            Mock<HttpSessionStateBase> sessionStateBase = new Mock<HttpSessionStateBase>();
            controllerContext.Setup(m => m.HttpContext.Session).Returns(sessionStateBase.Object);
            // Assign controller controller
            accountControllerMockObject.ControllerContext = controllerContext.Object;

            // ACT
            var result = accountControllerMockObject.Login(GetLogInFormData(userName, "password"), null) as RedirectToRouteResult;

            // ASSERT 
            Assert.AreEqual("DashBoard", result.RouteValues["action"]);
            Assert.AreEqual("UserPermission", result.RouteValues["controller"]);
            Assert.AreEqual("UserPermission", result.RouteValues["area"]);
            Assert.IsTrue(accountControllerMockObject.ModelState.IsValid);
            // Assert.AreEqual(userName, accountControllerMockObject.Session["UserId"]);
        }

        [TestMethod]
        public void LogIn_Check_With_ValidModel_And_InValidUser()
        {
            // ARRANGE
            string userName = "userName";
            webFormAuthentication.Setup(method => method.LogIn(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<bool>())).Returns(false);
            accountControllerMockObject = new AccountController(webFormAuthentication.Object, userRepository.Object, dataMorpher.Object, mailer.Object);

            // ACT
            var actionResult = accountControllerMockObject.Login(GetLogInFormData(userName, "password"), string.Empty);
            var viewResult = actionResult as ViewResult;

            // ASSERT 
            Assert.IsNotNull("LogIn", viewResult.ViewName);
            Assert.IsTrue(!accountControllerMockObject.ModelState.IsValid);
        }

        /// <summary>
        /// Get Log in form data
        /// </summary>
        /// <param name="userName">User name</param>
        /// <param name="password">Password</param>
        /// <param name="rememberMe">Remember me</param>
        /// <returns>Login View model</returns>
        private LogInViewModel GetLogInFormData(string userName, string password, bool rememberMe = false)
        {
            return new LogInViewModel
            {
                userName = userName,
                password = password,
                rememberMe = rememberMe
            };
        }
    }
}
