namespace BudgetManager.Helpers.Permissions
{
    using System.Web;
    using BudgetManager.Infrastructure.Helpers;

    public class PermissionBase
    {
        /// <summary>
        /// Gets or sets a value indicating whether Is IsReadable
        /// </summary>
        public bool HasReadAccess
        {
            get
            {
                var isReadableSession = HttpContext.Current.Session["IsReadable"];
                return isReadableSession != null ? TypeConversionHelper.GetDefaultValueIfNull<bool>(isReadableSession) : false;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether Is Writeable
        /// </summary>
        public bool HasEditAccess
        {
            get
            {
                var isWritableSession = HttpContext.Current.Session["IsWritable"];
                return isWritableSession != null ? TypeConversionHelper.GetDefaultValueIfNull<bool>(isWritableSession) : false;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether Is IsDeletable
        /// </summary>
        public bool HasDeleteAccess
        {
            get
            {
                var isDeletableSession = HttpContext.Current.Session["IsDeletable"];
                return isDeletableSession != null ? TypeConversionHelper.GetDefaultValueIfNull<bool>(isDeletableSession) : false;
            }
        }

        /// <summary>
        /// Gets Iseditable based on write Permission 
        /// </summary>
        public string DisableRowEdit
        {
            get
            {
                return !HasEditAccess ? "disabled = disabled" : string.Empty;
            }
        }

        /// <summary>
        /// Get deletable option based on can delete permission 
        /// </summary>
        public string DisableRowDelete
        {
            get
            {
                return !HasDeleteAccess ? "disabled = disabled" : string.Empty;
            }
        }
    }
}
