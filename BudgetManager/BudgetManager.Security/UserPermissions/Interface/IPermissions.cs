namespace BudgetManager.Security.UserPermissions.Interface
{
    public interface IPermissions
    {
        /// <summary>
        /// Set user permission
        /// </summary>
        /// <param name="read">Read</param>
        /// <param name="write">Write</param>
        /// <param name="delete">Delete</param>
        void SetPermission(bool read, bool write, bool delete);

        /// <summary>
        /// Reset user permission
        /// </summary>
        void ResetPermission();

        /// <summary>
        /// Get Permission for the selected mode of action
        /// </summary>
        /// <param name="mode">Action mode</param>
        /// <returns>permission</returns>
        bool GetPermission(string mode);
    }
}
