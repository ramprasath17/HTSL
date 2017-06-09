namespace BudgetManager.Web.Areas.InviteFriends.Models
{
    using System;
    using System.Web;

    public class UserSearchResultViewModel
    {
        /// <summary>
        /// Gets or sets User id
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets User Name
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// Gets or sets Is Active
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// Gets or sets Company Name
        /// </summary>
        public string CompanyName { get; set; }

        /// <summary>
        /// Gets a value indicating whether the user is currently logged in or not
        /// </summary>
        public bool IsLoggedInUser
        {
            get
            {
                return Convert.ToString(HttpContext.Current.Session["UserId"]).Equals(this.UserId, StringComparison.InvariantCultureIgnoreCase);
            }
        }

        /// <summary>
        /// Gets or sets Invitation Status
        /// </summary>
        public int? InvitationStatus { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether the user has already invited or not
        /// </summary>
        public bool ShowToInvite { get; set; }
    }
}