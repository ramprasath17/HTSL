namespace BudgetManager.Web.Areas.Expenses.Models
{
    using BudgetManager.Web.Models;
    using System.Collections.Generic;

    public class OverallExpenseViewModel
    {
        public IEnumerable<CalculatedExpenseViewModel> CalculatedExpense { get; set; }

        public SearchLookUpData SearchLookUp { get; set; }
    }
}