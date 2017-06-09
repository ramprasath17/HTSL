namespace BudgetManager.Web.Areas.Expenses.Models
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;
    using BudgetManager.Entities.NamedConstants;

    public class TransactionAnalysisViewModel
    {
        /// <summary>
        /// Gets or sets Users available in the application.
        /// </summary>
        public IEnumerable<SelectListItem> Users { get; set; }

        /// <summary>
        /// Gets or sets list of groups.
        /// </summary>
        [Display(Name = "Groups")]        
        public IEnumerable<SelectListItem> Groups { get; set; }

        /// <summary>
        /// Gets or sets list of expenses.
        /// </summary>
        [Display(Name = "Expenses")]        
        public IEnumerable<SelectListItem> Expenses { get; set; }

        /// <summary>
        /// Gets or sets selected first user id.
        /// </summary>
        [Display(Name="User - I")]
        [Required(ErrorMessage = "Select the user - I")]
        public string SelectedFirstUserId { get; set; }

        /// <summary>
        /// Gets or sets selected second user id.
        /// </summary>
        [Display(Name = "User - II")] 
        [Required(ErrorMessage = "Select the user - II")]
        public string SelectedSecondUserId { get; set; }

        /// <summary>
        /// Gets or sets selected group id.
        /// </summary>
        public int? SelectedGroupId { get; set; }

        /// <summary>
        /// Gets or sets selected expense id.
        /// </summary>
        public int? SelectedExpenseId { get; set; }

        /// <summary>
        /// Gets list of action types.
        /// </summary>
        [Display(Name="Action")]
        public AnalysisActionType ActionType { get; set; }

        /// <summary>
        /// Gets or sets type of action to request the data.
        /// </summary>
        [Required(ErrorMessage = "Select an appropriate action type.")]
        [EnumDataType(typeof(AnalysisActionType))]
        public int? SelectedActionType { get; set; }
    }
}