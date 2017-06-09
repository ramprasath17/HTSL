namespace BudgetManager.Web.Areas.BudgetManagement
{
    using System.Web.Mvc;

    public class BudgetManagementAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "BudgetManagement";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "BudgetManagement_default",
                "BudgetManagement/{action}/{id}",
                new { area = "BudgetManagement", controller = "BudgetManagement", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
