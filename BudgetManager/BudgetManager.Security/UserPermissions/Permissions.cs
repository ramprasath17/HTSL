namespace BudgetManager.Security.UserPermissions
{    
    using System;
    using System.Collections.Generic;
    using BudgetManager.Security.UserPermissions.Interface;

    public class Permissions  : IPermissions
    {
        /// <summary>
        /// Gets or sets screen permission
        /// </summary>
        private Dictionary<string, bool> ScreenPermission { get; set; }

        /// <summary>
        /// Set user permission
        /// </summary>
        /// <param name="read">Read</param>
        /// <param name="write">Write</param>
        /// <param name="delete">Delete</param>
        public void SetPermission(bool read, bool write, bool delete)
        {
            ScreenPermission = new Dictionary<string, bool>();
            ScreenPermission["Read"] = read;
            ScreenPermission["Write"] = write;
            ScreenPermission["Delete"] = delete;
        }

        /// <summary>
        /// Reset user permission
        /// </summary>
        public void ResetPermission()
        {
            ScreenPermission = new Dictionary<string, bool>();
            ScreenPermission["Read"] = false;
            ScreenPermission["Write"] = false;
            ScreenPermission["Delete"] = false;
        }

        /// <summary>
        /// Get Permission for the selected mode of action
        /// </summary>
        /// <param name="mode">Action mode</param>
        /// <returns>permission</returns>
        public bool GetPermission(string mode)
        {
            return ScreenPermission[mode];
        }
    }
}
