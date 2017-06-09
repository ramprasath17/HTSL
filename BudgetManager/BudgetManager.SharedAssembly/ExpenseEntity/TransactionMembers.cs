namespace BudgetManager.SharedAssembly.ExpenseEntity
{
    using System;

    public class TransactionMembers
    {
        public long ExpenseId { get; set; }

        public string ReceivedBy { get; set; }

        public string ReturnedBy { get; set; }

        public decimal AmountReturned { get; set; }

        public DateTime AmountReturnedOn { get; set; }

        public string Description { get; set; }
    }
}
