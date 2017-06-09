namespace BudgetManager.ReportUtility.Reports
{
    using Aspose.Cells;
    using BudgetManager.ReportUtility.Contracts;

    public class ExpenseReport : ReportUtilityFactory
    {

        public override string ReportName
        {
            get { return "Expense Report"; }
        }

        public override string ReportDescription
        {
            get { return "This report will give a complete information on the selected expenses."; }
        }

        public override void SetReportStyle(Workbook workbook)
        {
            workbook.DefaultStyle.BackgroundColor = System.Drawing.Color.Aquamarine;
        }

        public override string[] ExcludedColumns
        {
            get
            {
                return new string[] { "ExpenseID" };
            }
        }
    }
}
