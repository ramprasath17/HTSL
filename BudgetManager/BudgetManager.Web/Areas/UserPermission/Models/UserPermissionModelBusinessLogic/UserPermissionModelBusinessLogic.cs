namespace BudgetManager.Web.Areas.UserPermission.Models.UserPermissionModelBusinessLogic
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Web;
    using System.Web.Mvc;
    using BudgetManager.Entities.NamedConstants;
    using BudgetManager.Infrastructure.Helpers;
    using BudgetManager.SharedAssembly;

    public class UserPermissionModelBusinessLogic
    {
        /// <summary>
        /// Get Icon List
        /// </summary>
        /// <typeparam name="TSource">TSource</typeparam>
        /// <returns>Gets icon list</returns>
        public static IEnumerable<SelectListItem> GetIconList<TSource>() where TSource : struct
        {
            return Enum.GetNames(typeof(TSource)).AsEnumerable().Select(result => new SelectListItem
            {
                Text = result,
                Value = EnumExtensions.GetEnumAttributeFromValue<TSource>(result),
            }).OrderBy(result => result.Text);
        }

        /// <summary>
        /// Gets the screens list for the logged in user
        /// </summary>
        /// <returns>Screen List</returns>
        public static IEnumerable<SelectListItem> GetScreenList(string sessionUserId)
        {
            List<UserScreenLink> screenLink = new List<UserScreenLink>();
            IEnumerable<UserMenu> screens = (IEnumerable<UserMenu>)HttpRuntime.Cache["UserNavLinks_" + sessionUserId];
            foreach (UserMenu menu in screens)
            {
                foreach (UserScreenLink link in menu.Links)
                {
                    screenLink.Add(new UserScreenLink
                    {
                        ActionLinkText = link.ActionLinkText,
                        ScreenID = link.ScreenID
                    });
                }
            }

            return screenLink.Select(result => new SelectListItem
            {
                Text = result.ActionLinkText,
                Value = Convert.ToString(result.ScreenID),
            });
        }

        /// <summary>
        /// Get Permissions
        /// </summary>
        /// <param name="userPermissionTable">user Permission table data</param>
        /// <returns>Users permissions</returns>
        public static List<ScreenAndPermissions> GetUserPermissionFromDataTable(DataTable userPermissionTable, string sessionUserId)
        {
            return userPermissionTable.AsEnumerable()
                .Select(result => new ScreenAndPermissions
                {
                    ScreeenId = result.Field<int?>("screenId"),
                    ScreeenName = result.Field<string>("ScreenName"),
                    IsRead = result.Field<bool>("isRead"),
                    IsWrite = result.Field<bool>("isWrite"),
                    IsDelete = result.Field<bool>("canDelete"),
                    LinkIcon = result.Field<string>("linkIcon"),
                    LinkOrder = TypeConversionHelper.GetDefaultValueIfNull<int>(result.Field<int?>("linkOrder")),
                    ParentScreenId = TypeConversionHelper.GetDefaultValueIfNull<int>(result.Field<int?>("parentScreenId")),
                    SelectedLinkIconInSelectList = GetIconList<FontIcons>().Select(results => new SelectListItem
                    {
                        Text = results.Text,
                        Value = results.Value,
                        Selected = results.Value.Equals(result.Field<string>("linkIcon"), StringComparison.InvariantCultureIgnoreCase)
                    }),
                    SelectedParentScreenInSelectList = GetScreenList(sessionUserId).Select(results => new SelectListItem
                    {
                        Text = results.Text,
                        Value = results.Value,
                        Selected = results.Value.Equals(TypeConversionHelper.GetDefaultValueIfNull<string>(result.Field<int?>("parentScreenId")), StringComparison.InvariantCultureIgnoreCase)
                    }),
                }).ToList();
        }
    }
}