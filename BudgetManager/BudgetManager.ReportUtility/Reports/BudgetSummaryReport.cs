namespace BudgetManager.ReportUtility.Reports
{
    using Aspose.Cells;
    using BudgetManager.ReportUtility.Contracts;

   public  class BudgetSummaryReport : ReportUtilityFactory
    {
        public override string ReportName
        {
            get { return "BudgetSummary Report"; }
        }

        public override string ReportDescription
        {
            get { return "This report will give a summary information on the Budget."; }
        }

        public override void SetReportStyle(Workbook workbook)
        {
            workbook.DefaultStyle.BackgroundColor = System.Drawing.Color.Aquamarine;
        }
        public override string[] ExcludedColumns
        {
            get
            {
                return new string[] { "" };
            }
        }
    }
}
