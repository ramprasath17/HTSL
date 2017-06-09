namespace BudgetManager.Infrastructure.DependencyInjection
{
    using System;
    using System.Collections.Generic;
    using System.Web.Mvc;
    using System.Web.Routing;
    using BudgetManager.Helpers.Permissions;
    using BudgetManager.Helpers.Permissions.Contract;
    using BudgetManager.Infrastructure.Communication;
    using BudgetManager.Infrastructure.ContractImplementation;
    using BudgetManager.Infrastructure.Contracts;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Repository.RepositoryClass;
    using BudgetManager.Security.EncDec;
    using BudgetManager.Security.UserSessionHandler;
    using Ninject;

    public class DependencyInjector : DefaultControllerFactory, IDependencyResolver
    {
        private IKernel kernel;

        public DependencyInjector()
        {
            kernel = new StandardKernel();
            AddBindings();
        }

        public object GetService(Type serviceType)
        {
            return kernel.TryGet(serviceType);
        }

        public IEnumerable<object> GetServices(Type serviceType)
        {
            return kernel.GetAll(serviceType);
        }

        protected override IController GetControllerInstance(RequestContext requestContext, Type controllerType)
        {
            return controllerType == null ? null : (IController)kernel.Get(controllerType);
        }

        private void AddBindings()
        {
            kernel.Bind<IWebFormsAuthentication>().To<WebFormsAuthentication>();
            kernel.Bind<IDataMorpher>().To<DataMorpher>();
            kernel.Bind<IUserRepository>().To<UserRepository>();
            kernel.Bind<IBudgetRepository>().To<BudgetRepository>();
            kernel.Bind<IUserAndGroupRepository>().To<UserAndGroupRepository>();
            kernel.Bind<ICommonRepository>().To<CommonRepository>();
            kernel.Bind<IExpenseRepository>().To<ExpenseRepository>();
            kernel.Bind<IFriendInvitationRepository>().To<FriendInvitationRepository>();
            kernel.Bind<IPermissionHelper>().To<PermissionHelper>();
            kernel.Bind<IMailer>().To<Mailer>();
            kernel.Bind<IUserSession>().To<UserSession>();
        }

    }
}
