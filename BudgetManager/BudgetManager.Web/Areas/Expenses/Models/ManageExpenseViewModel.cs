namespace BudgetManager.Web.Areas.Expenses.Models
{
    using System.Collections.Generic;
    using BudgetManager.SharedAssembly.ApplicationLookUps;
    using Newtonsoft.Json;    

    public class ManageExpenseViewModel
    {
        /// <summary>
        /// Expense Details
        /// </summary>
        public List<ExpenseViewModel> ExpenseDetails { get; set; }

        /// <summary>
        /// Gets or sets Look up for Budget 
        /// </summary>
        public ExpenseLookUp ExpenseLookUpData { get; set; }

        /// <summary>
        /// Gets the serialized look up data for client side load
        /// </summary>
        public string SerializedLookUp
        {
            get
            {
                return JsonConvert.SerializeObject(ExpenseLookUpData);
            }
        }
    }
}