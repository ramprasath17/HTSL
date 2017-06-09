namespace BudgetManager.Web.Areas.Expenses.Models
{
    using System;
    using System.ComponentModel.DataAnnotations;

    public class CalculatedExpenseViewModel
    {
        public int ExpenseId { get; set; }

        public string ExpenseDescription { get; set; }

        public string SpentBy { get; set; }

        public string SpentByUserId { get; set; }

        public string BudgetGroup { get; set; }

        public string UserInExpense { get; set; }

        public string AmountToBearUserId { get; set; }

        public bool IsRemittance { get; set; }

        public decimal? AmountInReturn { get; set; }

        public decimal? SpentAmount { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        [DataType(DataType.DateTime)]
        public DateTime SpentOn { get; set; }

        public decimal? AmountToShare { get; set; }
    }
}