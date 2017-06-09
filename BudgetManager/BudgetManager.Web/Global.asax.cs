namespace BudgetManager.Web
{
    using System.Reflection;
    using System.Web.Http;
    using System.Web.Mvc;
    using System.Web.Optimization;
    using System.Web.Routing;
    using BudgetManager.Infrastructure.DependencyInjection;
    using BudgetManager.ReportSchemaValidator;
    using BudgetManager.Web.App_Start;

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            ReportSchemaValidator.Validate();
            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            DependencyResolver.SetResolver(new DependencyInjector());
            ApplicationScreens.RegisterScreens(Assembly.GetExecutingAssembly());
            ViewEngineConfig.RegisterViewEngines();
            AutoMapperConfig.Configure();
        }

        protected void Application_Error()
        {
            //Exception errorDetail = Server.GetLastError();
            //Server.Transfer("~/Account/Home.cshtml");            
        }

        //protected void Application_BeginRequest()
        //{
        //    MiniProfiler.Start();
        //}

        //protected void Application_EndRequest()
        //{
        //    MiniProfiler.Stop();
        //}

    }
}