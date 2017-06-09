namespace BudgetManager.SharedAssembly.ApplicationLookUps
{
    using System.Collections.Generic;

    public class ExpenseLookUp : BudgetLookUp
    {
        /// <summary>
        /// Gets or sets Look up for Application Users
        /// </summary>
        public Dictionary<string, string> Users { get; set; }
    }
}
