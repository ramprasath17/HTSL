using System.Web.Mvc;

namespace BudgetManager.Web.Areas.InviteFriends
{
    public class InviteFriendsAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "InviteFriends";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "InviteFriends_default",
                "InviteFriends/{controller}/{action}/{id}",
                new { area = "InviteFriends", controller = "InviteFriends", action = "InviteAFriendToCompany", id = UrlParameter.Optional }
            );
        }
    }
}
