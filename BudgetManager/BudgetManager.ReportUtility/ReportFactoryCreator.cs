namespace BudgetManager.ReportUtility
{
    using BudgetManager.Entities.NamedConstants;
    using BudgetManager.ReportUtility.Factory.Contract;
    using System;
    using System.IO;
    using System.Reflection;

    public static class ReportFactoryCreator
    {
        internal static string reportClassSuffix = "Report";
        internal const string assemblyNamespace = "BudgetManager.ReportUtility.Reports.";
        internal static string className = null;

        /// <summary>
        /// Create report instance by report type.
        /// </summary>
        /// <param name="reportType">Report type.</param>
        /// <returns>Report factory instance.</returns>
        public static IReportFactory CreateReportInstance(ReportType reportType)
        {
            className = string.Format("{0}{1}{2}", assemblyNamespace, reportType.ToString(), reportClassSuffix);
            if (string.IsNullOrWhiteSpace(className))
            {
                throw new Exception(string.Format("Could not load the {0} report. Please check whether the component exists.", reportType.ToString()));
            }

            Type classType = Type.GetType(className);
            return (IReportFactory)Activator.CreateInstance(classType);
        }
    }
}
