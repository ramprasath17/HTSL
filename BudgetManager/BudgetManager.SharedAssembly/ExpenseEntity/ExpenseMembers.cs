namespace BudgetManager.SharedAssembly.ExpenseEntity
{
    using System;
    using System.Collections.Generic;

    public class ExpenseMembers
    {
        public string Description { get; set; }

        public DateTime SpentOn { get; set; }

        public float SpentAmount { get; set; }

        public string SpentBy { get; set; }

        public List<string> IncludedUsers { get; set; }

        public List<string> ExcludedUsers { get; set; }

        public string BudgetCategory { get; set; }

        public List<string> SelectedGroupId { get; set; }

        /// <summary>
        /// Gets or sets Created By
        /// </summary>
        public string CreatedBy { get; set; }
    }
}
