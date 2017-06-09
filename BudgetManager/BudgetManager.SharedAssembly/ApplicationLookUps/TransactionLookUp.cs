namespace BudgetManager.SharedAssembly.ApplicationLookUps
{
    using System.Collections.Generic;

    public class TransactionLookUp
    {
        /// <summary>
        /// Gets or sets Look up for application Users
        /// </summary>
        public Dictionary<string, string> Users { get; set; }

        /// <summary>
        /// Gets or sets Look up for application expenses
        /// </summary>
        public Dictionary<string, string> Expenses { get; set; }
    }
}
