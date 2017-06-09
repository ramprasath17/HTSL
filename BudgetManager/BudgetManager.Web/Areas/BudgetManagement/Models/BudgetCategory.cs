namespace BudgetManager.Web.Areas.BudgetManagement.Models
{
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;

    public class BudgetCategory
    {
        /// <summary>
        /// Gets or sets Category ID
        /// </summary>
        public int CategoryId { get; set; }

        /// <summary>
        /// Gets or sets Category Name
        /// </summary>
        [Required(ErrorMessage = "Category Name cannot be empty")]
        [StringLength(50, ErrorMessage = "Maximum upto 50 characters is allowed.")]
        [Remote("CheckCategoryAlreadyExists", "BudgetManagement", ErrorMessage = "Category already exists.")]
        public string CategoryName { get; set; }

        /// <summary>
        /// Budget Category Created By
        /// </summary>
        [Display(Name = "Created By")]
        public string CreatedBy { get; set; }
    }
}