namespace BudgetManager.ReportUtility.Factory.Contract
{
    using Aspose.Cells;
    using BudgetManager.Entities.NamedConstants;
    using System.Data;

    public interface IReportFactory
    {
        string ReportName { get; }

        string ReportDescription { get; }

        void SetReportStyle(Workbook workbook);

        string[] ExcludedColumns { get; }

        Workbook _workbook { get; set; }

        void GenerateReport(DataTable reportData, ReportFormat reportFormat, ReportType reportType);
    }
}
