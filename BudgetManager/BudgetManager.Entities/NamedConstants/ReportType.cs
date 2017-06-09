namespace BudgetManager.Entities.NamedConstants
{
    using BudgetManager.Entities.EntityAttributes;

    public enum ReportType
    {
        [ReportDefinition("Expense")]
        Expense,

        [ReportDefinition("BudgetSummary")]
        BudgetSummary,

        [ReportDefinition("Transaction")]
        Transaction
    }
}
