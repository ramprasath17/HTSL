namespace BudgetManager.Web.Areas.UserAndGroupManagement.Models
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;
    using BudgetManager.Helpers.Permissions;

    public class GroupViewModel : PermissionBase
    {
        /// <summary>
        /// Gets or Set Group Id
        /// </summary>
        public int GroupId { get; set; }

        /// <summary>
        /// Gets or Sets Group Name
        /// </summary>
        [Required(ErrorMessage = "Group Name cannot be empty")]
        [StringLength(100, ErrorMessage = "Cannot exceed 100 characters")]
        [Remote("CheckIsGroupAlreadyExists", "ManageGroup", ErrorMessage="Already a groupwith same name exists.")]
        public string GroupName { get; set; }

        /// <summary>
        /// Get the available users
        /// </summary>
        public IEnumerable<SelectListItem> UserList { get; set; }

        /// <summary>
        /// Selected Users
        /// </summary>
        [Required(ErrorMessage="Atleast one user must be in the group.")]
        public string[] SelectedUsers { get; set; }

        /// <summary>
        /// Gets or Sets Group Is Active
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// Gets is Checkbox Checked based on Active status
        /// </summary>
        public string IsChecked
        {
            get
            {
                return IsActive ? "checked = checked" : string.Empty;
            }
        }
    }
}