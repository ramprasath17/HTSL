using BudgetManager.Helpers.Permissions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BudgetManager.Web.Areas.UserPermission.Models
{
    /// <summary>
    /// User Permission View model
    /// </summary>
    public class UserPermissionsViewModel : PermissionBase
    {
        /// <summary>
        /// Gets or sets Application Users
        /// </summary>
        public List<ApplicationUsers> ApplicationUsers { get; set; }

        /// <summary>
        /// Gets or sets Application User dropdown list
        /// </summary>
        public IEnumerable<SelectListItem> ApplicationUsersSelectList { get; set; }

        /// <summary>
        /// Gets or sets Screens and permission
        /// </summary>
        public List<ScreenAndPermissions> ScreenAndPermissions { get; set; }

        /// <summary>
        /// Gets or sets screen list
        /// </summary>
        public IEnumerable<SelectListItem> ScreenList { get; set; }

        /// <summary>
        /// Gets or sets Icon List
        /// </summary>
        public IEnumerable<SelectListItem> IconList { get; set; }
    }

    /// <summary>
    /// Application Users
    /// </summary>
    public class ApplicationUsers
    {
        /// <summary>
        /// Gets or sets User Id
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets User Name
        /// </summary>
        public string UserName { get; set; }
    }

    /// <summary>
    /// Screens and Permissions
    /// </summary>
    public class ScreenAndPermissions : PermissionBase
    {
        /// <summary>
        /// Gets or sets Screen Id
        /// </summary>
        public int? ScreeenId { get; set; }

        /// <summary>
        /// Gets or sets Screen Name
        /// </summary>
        public string ScreeenName { get; set; }

        /// <summary>
        /// Gets or sets whether is readable
        /// </summary>
        public bool IsRead { get; set; }

        /// <summary>
        /// Gets or sets whether is writable
        /// </summary>
        public bool IsWrite { get; set; }

        /// <summary>
        /// Gets or sets is deletable
        /// </summary>
        public bool IsDelete { get; set; }

        /// <summary>
        /// Gets or sets the checked attribute
        /// </summary>
        public string Checked
        {
            get
            {
                return "checked = checked";
            }
        }

        /// <summary>
        /// Gets or sets attribute for isreadable
        /// </summary>
        public string Isreadable
        {
            get
            {
                if (IsRead)
                {
                    return Checked;
                }

                return string.Empty;
            }
        }

        /// <summary>
        /// Gets or sets attribute for is deletable
        /// </summary>
        public string IsDeletable
        {
            get
            {
                if (IsDelete)
                {
                    return Checked;
                }

                return string.Empty;
            }
        }

        /// <summary>
        /// Gets or sets attribute for is writable
        /// </summary>
        public string IsWritable
        {
            get
            {
                if (IsWrite)
                {
                    return Checked;
                }

                return string.Empty;
            }
        }

        /// <summary>
        /// Gets or sets Link Icon
        /// </summary>
        public string LinkIcon { get; set; }

        /// <summary>
        /// Gets or sets Link order
        /// </summary>
        public int? LinkOrder { get; set; }

        /// <summary>
        /// Gets or sets parent screen id
        /// </summary>
        public int? ParentScreenId { get; set; }

        /// <summary>
        /// Gets or sets Application User dropdown list
        /// </summary>
        public IEnumerable<SelectListItem> SelectedLinkIconInSelectList { get; set; }

        /// <summary>
        /// Gets or sets Selected parent screen user dropdown list
        /// </summary>
        public IEnumerable<SelectListItem> SelectedParentScreenInSelectList { get; set; }

        /// <summary>
        /// Gets the seleted icon to display on read only mode
        /// </summary>
        public string[] SelectedIcon
        {
            get
            {
                if (SelectedLinkIconInSelectList.ToArray().Where(mm => mm.Selected == true).Count() > 0)
                {
                    return new string[]{SelectedLinkIconInSelectList.ToArray().Where(mm => mm.Selected == true).First().Text,
                                        SelectedLinkIconInSelectList.ToArray().Where(mm => mm.Selected == true).First().Value};
                }
                else
                {
                    return new string[]{SelectedLinkIconInSelectList.ToArray().First().Text,
                                        SelectedLinkIconInSelectList.ToArray().First().Value};
                }
            }
        }

        /// <summary>
        /// Gets the seleted icon to display on read only mode
        /// </summary>
        public string[] SelectedParentScreen
        {
            get
            {
                if (SelectedParentScreenInSelectList.ToArray().Where(mm => mm.Selected == true).Count() > 0)
                {
                    return new string[]{SelectedParentScreenInSelectList.ToArray().Where(mm => mm.Selected == true).First().Text,
                                        SelectedParentScreenInSelectList.ToArray().Where(mm => mm.Selected == true).First().Value};
                }
                else
                {
                    return new string[]{SelectedParentScreenInSelectList.ToArray().First().Text,
                                        SelectedParentScreenInSelectList.ToArray().First().Value};
                }
            }            
        }
    }
}