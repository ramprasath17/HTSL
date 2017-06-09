namespace BudgetManager.Web.Areas.InviteFriends.Models
{
    using System;
    using System.Web;

    public class UserDetailsViewModel
    {
        /// <summary>
        /// Gets or sets Company Id
        /// </summary>
        public int CompanyId { get; set; }

        /// <summary>
        /// Gets or sets Company Name
        /// </summary>
        public string CompanyName { get; set; }

        /// <summary>
        /// Gets or sets Email Id
        /// </summary>
        public string EmailId { get; set; }

        /// <summary>
        /// Gets or sets User Id
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets User Name
        /// </summary>
        public string UserName { get; set; }

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
        /// Gets or sets a value indicating whether the user has already invited or not
        /// </summary>
        public bool IsInvited { get; set; }
    }
}