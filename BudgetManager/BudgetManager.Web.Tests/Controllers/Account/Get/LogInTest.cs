namespace BudgetManager.Web.Tests.Controllers.Account.Get
{
    using System.Web.Mvc;
    using BudgetManager.Infrastructure.Contracts;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Security.EncDec;
    using BudgetManager.Web.Controllers;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using Moq;
    using WebMatrix.WebData;

    [TestClass]
    public class LogInTest
    {
        private AccountController accountController;

        private Mock<IWebFormsAuthentication> webFormAuthentication;

        private Mock<IUserRepository> userRepository;

        private Mock<IDataMorpher> dataMorpher;

        private Mock<IMailer> mailer;

        [TestInitialize]
        public void Init()
        {
            webFormAuthentication = new Mock<IWebFormsAuthentication>();
            userRepository = new Mock<IUserRepository>();
            dataMorpher = new Mock<IDataMorpher>();
            mailer = new Mock<IMailer>();
            accountController = new AccountController(webFormAuthentication.Object, userRepository.Object, dataMorpher.Object, mailer.Object);
        }

        [TestMethod]
        public void Login_Check()
        {
            // ARRANGE - Initialiase 
            string expectedViewName = "LogIn";

            // ACT - Execute the methods
            var actionResult = accountController.Login() as ViewResult;
            
            // ASSERT - Check the result
            Assert.AreEqual(expectedViewName, actionResult.ViewName);
        }
    }
}
