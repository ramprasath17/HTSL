namespace BudgetManager.Web.Areas.BudgetManagement.Models
{
    using BudgetManager.Helpers.Permissions;
    using System.Collections.Generic;

    public class ManageBudgetCategoryViewModel : PermissionBase
    {
        /// <summary>
        /// Gets or sets Add category
        /// </summary>
        public BudgetCategory AddCategory { get; set; }

        /// <summary>
        /// Gets or sets Categories
        /// </summary>
        public List<BudgetCategory> Categories { get; set; }
    }
}