using System.Web.Mvc;

namespace BudgetManager.Web.Areas.UserAndGroupManagement
{
    public class UserAndGroupManagementAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "UserAndGroupManagement";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "UserAndGroupManagement_default",
                "UserAndGroupManagement/{action}/{id}",
                new { area = "UserAndGroupManagement", controller = "ManageGroup", action = "ManageGroups", id = UrlParameter.Optional }
            );
        }
    }
}
