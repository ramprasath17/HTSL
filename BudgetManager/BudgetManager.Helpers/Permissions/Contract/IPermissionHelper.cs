namespace BudgetManager.Helpers.Permissions.Contract
{
    public interface IPermissionHelper
    {
        /// <summary>
        /// Set User permissions
        /// </summary>
        /// <param name="isReadable">Is readable</param>
        /// <param name="isWritable">Is Writable</param>
        /// <param name="isDeletable">Is Deletable</param>
        void SetPermission(bool isReadable, bool isWritable, bool isDeletable);

        /// <summary>
        /// Reset Permission
        /// </summary>
        void ResetPermission();
    }
}
