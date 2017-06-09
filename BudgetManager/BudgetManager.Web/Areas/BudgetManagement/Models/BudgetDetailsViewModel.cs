namespace BudgetManager.Web.Areas.BudgetManagement.Models
{
    using BudgetManager.Helpers.Permissions;
    using BudgetManager.Infrastructure.Attributes;
    using BudgetManager.SharedAssembly;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;

    public class BudgetDetails : PermissionBase
    {
        /// <summary>
        /// Budget ID
        /// </summary>
        [Display(Name = "Budget ID")]
        public int? BudgetId { get; set; }

        /// <summary>
        /// Budget Name
        /// </summary>
        [Display(Name = "Budget Name")]
        [Required(ErrorMessage = "Budget Name cannot be empty")]
        [Remote("IsBudgetExists", "BudgetManagement", ErrorMessage = "Budget already exists with this name.")]
        public string BudgetName { get; set; }

        /// <summary>
        /// Budget Description
        /// </summary>
        [Display(Name = "Budget Description")]
        public string BudgetDescription { get; set; }

        /// <summary>
        /// Budget Creation Date
        /// </summary>
        [Display(Name = "Creation Date")]
        public DateTime CreationDate { get; set; }

        /// <summary>
        /// Budget Created By
        /// </summary>
        [Display(Name = "Created By")]
        public string CreatedBy { get; set; }

        /// <summary>
        /// Gets or sets Category
        /// </summary>
        [Display(Name = "SelectedCategory")]
        [Required(ErrorMessage = "Must select a category")]
        public string SelectedCategory { get; set; }

        /// <summary>
        /// Budget Category
        /// </summary>
        [Display(Name = "Categories")]
        public IEnumerable<SelectListItem> Categories { get; set; }

        /// <summary>
        /// Budget Modified Date
        /// </summary>
        [Display(Name = "Modified Date")]
        public string ModifiedDate { get; set; }

        /// <summary>
        /// Budget Modified By whom
        /// </summary>
        [Display(Name = "Modified By")]
        public string ModifiedBy { get; set; }

        /// <summary>
        /// Budget Minimum Amount Allocated
        /// </summary>
        [Display(Name = "Minimum Amount Allocated")]
        [Required(ErrorMessage = "Minimum Amount cannot be left empty")]
        public string MinimumAmountAllocated { get; set; }

        /// <summary>
        /// Budget Maximum Amount Allocated
        /// </summary>
        [Display(Name = "Maximum Amount Allocated")]
        [Required(ErrorMessage = "Maximum Amount cannot be left empty")]
        [GreaterThan("MinimumAmountAllocated", ErrorMessage = "Value must be grater than minimum allocated amount.")]
        public string MaximumAmountAllocated { get; set; }

        /// <summary>
        /// Starting date of the budget
        /// </summary>
        [Display(Name = "Start Date")]
        [Required]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", NullDisplayText = "Select start date")]
        public DateTime StartDate { get; set; }

        /// <summary>
        /// Ending date of the budget
        /// </summary>
        [Display(Name = "End Date")]
        [Required]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", NullDisplayText = "Select end date")]
        public DateTime EndDate { get; set; }

        /// <summary>
        /// Gets or sets budget period
        /// </summary>
        [Display(Name = "Budget Period")]
        [Required(ErrorMessage = "Must select the budget period")]
        public string BudgetPeriod { get; set; }

        /// <summary>
        /// The Budget is whether active or not
        /// </summary>
        [Display(Name = "Is Active")]
        public bool IsActive { get; set; }

        /// <summary>
        /// Is the budget set for future
        /// </summary>
        [Display(Name = "Is Future")]
        public bool IsFuture { get; set; }

        /// <summary>
        /// Can Budget Amount exceed the maximum level
        /// </summary>
        [Display(Name = "Can exceed maximum amount")]
        public bool CanExceedMaximumAmount { get; set; }

        /// <summary>
        /// Gets or sets spent amount.
        /// </summary>
        public decimal? SpentAmount { get; set; }

        /// <summary>
        /// Gets or sets status.
        /// </summary>
        public ToolTipLabel Status { get; set; }

        /// <summary>
        /// Gets or sets level.
        /// </summary>
        public ToolTipLabel Level { get; set; }
    }
}