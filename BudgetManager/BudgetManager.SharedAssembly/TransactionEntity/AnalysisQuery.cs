namespace BudgetManager.SharedAssembly.TransactionEntity
{
    using System;

    public class AnalysisQuery
    {
        public string User1 { get; set; }

        public string User2 { get; set; }

        public int? GroupId { get; set; }

        public int? ExpenseId { get; set; }

        public int Action { get; set; }

        public DateTime? From { get; set; }

        public DateTime? To { get; set; }
    }
}
