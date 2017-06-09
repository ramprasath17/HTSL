namespace BudgetManager.Helpers.Permissions
{
    using System.Web;
    using BudgetManager.Helpers.Permissions.Contract;
    
    public class PermissionHelper : IPermissionHelper
    {
        /// <summary>
        /// Set User permissions
        /// </summary>
        /// <param name="isReadable">Is readable</param>
        /// <param name="isWritable">Is Writable</param>
        /// <param name="isDeletable">Is Deletable</param>
        public void SetPermission(bool isReadable, bool isWritable, bool isDeletable)
        {
            HttpContext.Current.Session["IsReadable"] = isReadable;
            HttpContext.Current.Session["IsWritable"] = isWritable;
            HttpContext.Current.Session["IsDeletable"] = isDeletable;
        }

        /// <summary>
        /// Reset Permission
        /// </summary>
        public void ResetPermission()
        {
            HttpContext.Current.Session["IsReadable"] = false;
            HttpContext.Current.Session["IsWritable"] = false;
            HttpContext.Current.Session["IsDeletable"] = false;
        }
    }
}
