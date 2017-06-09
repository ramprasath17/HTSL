namespace BudgetManager.Web.Areas.UserAndGroupManagement.Models
{
    using System.Collections.Generic;

    public class ManageUserGroupViewModel
    {
        /// <summary>
        /// Gets or sets group view model for creating new group
        /// </summary>
        public GroupViewModel groupViewModelForCreate { get; set; }

        /// <summary>
        /// Gets or sets Group view model for view and edit
        /// </summary>
        public List<GroupViewModel> groupViewModelListForViewAndEdit { get; set; }
    }
}