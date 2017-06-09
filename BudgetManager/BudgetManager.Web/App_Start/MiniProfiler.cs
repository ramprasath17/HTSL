[assembly: WebActivator.PreApplicationStartMethod(
	typeof(BudgetManager.Web.App_Start.MiniProfilerPackage), "PreStart")]

[assembly: WebActivator.PostApplicationStartMethod(
	typeof(BudgetManager.Web.App_Start.MiniProfilerPackage), "PostStart")]

namespace BudgetManager.Web.App_Start 
{    
    using StackExchange.Profiling;
    using StackExchange.Profiling.Mvc;
    using System.Linq;
    using System.Web.Mvc;
    using Microsoft.Web.Infrastructure.DynamicModuleHelper;

    public static class MiniProfilerPackage
    {
        public static void PreStart()
        {
            //TODO: Non SQL Server based installs can use other formatters like: new StackExchange.Profiling.SqlFormatters.InlineFormatter()
            MiniProfiler.Settings.SqlFormatter = new StackExchange.Profiling.SqlFormatters.SqlServerFormatter();

            //Make sure the MiniProfiler handles BeginRequest and EndRequest
            DynamicModuleUtility.RegisterModule(typeof(MiniProfilerStartupModule));

            //Setup profiler for Controllers via a Global ActionFilter
            GlobalFilters.Filters.Add(new ProfilingActionFilter());
        }

        public static void PostStart()
        {
            // Intercept ViewEngines to profile all partial views and regular views.
            // If you prefer to insert your profiling blocks manually you can comment this out
            var copy = ViewEngines.Engines.ToList();
            ViewEngines.Engines.Clear();
            foreach (var item in copy)
            {
                ViewEngines.Engines.Add(new ProfilingViewEngine(item));
            }
        }
    }
}

