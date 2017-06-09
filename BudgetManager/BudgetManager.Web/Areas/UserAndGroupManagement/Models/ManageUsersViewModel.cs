namespace BudgetManager.Web.Areas.UserAndGroupManagement.Models
{
    using System.Collections.Generic;
    using BudgetManager.SharedAssembly;    

    public class ManageUsersViewModel
    {
        /// <summary>
        /// Gets or sets Table Id
        /// </summary>
        public string TableId { get; set; }

        /// <summary>
        /// Gets or sets Application User Information
        /// </summary>
        public List<ApplicationUserInformation> ApplicationUserInformation { get; set; }
    }
}