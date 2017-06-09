namespace BudgetManager.Web.Areas.UserAndGroupManagement.Models
{
    public class ApplicationUserInformation
    {
        /// <summary>
        /// Gets or sets User Id
        /// </summary>
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets First Name 
        /// </summary>
        public string FirstName { get; set; }

        /// <summary>
        /// Gets or sets Middle Name  
        /// </summary>
        public string MiddleName { get; set; }

        /// <summary>
        /// Gets or sets Last Name   
        /// </summary>
        public string LastName { get; set; }

        /// <summary>
        /// Gets or sets Display Name
        /// </summary>
        public string DisplayName { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether the user is active
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// Gets or sets Company Id
        /// </summary>
        public int CompanyId { get; set; }

        /// <summary>
        /// Gets or sets Company Name
        /// </summary>
        public string CompanyName { get; set; }
    }
}