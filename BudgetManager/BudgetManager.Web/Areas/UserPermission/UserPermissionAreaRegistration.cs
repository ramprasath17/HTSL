using System.Web.Mvc;

namespace BudgetManager.Web.Areas.UserPermission
{
    public class UserPermissionAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "UserPermission";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "UserPermission_default",
                //"LoggedInProfile/{controller}/{action}/{id}",
                "UserPermission/{action}/{id}",
                new { area = "UserPermission", controller = "UserPermission", action = "DashBoard", id = UrlParameter.Optional }
            );
        }
    }
}
