namespace BudgetManager.Web.Areas.Expenses.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;
    using BudgetManager.Helpers.Permissions;
    using Newtonsoft.Json;
    using System.Globalization;

    public class ExpenseViewModel : PermissionBase
    {
        /// <summary>
        /// Gets or sets Expense ID
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// Gets or sets Description of expense
        /// </summary>
        [Display(Name = "Description")]
        [StringLength(80, MinimumLength = 10, ErrorMessage="Must be with in 10 to 80 characters")]
        [Required(ErrorMessage = "Must enter a description")]
        public string Description { get; set; }

        /// <summary>
        /// Gets or sets spent amount
        /// </summary>
        [Display(Name = "Spent Amount")]
        [Required(ErrorMessage = "Spent Amount cannot be empty")]   
        [Range(1, double.MaxValue,ErrorMessage="Entered amount must be greater than zero or is out of range.")]
        //[RegularExpression(@"^\d+(\.\d{1,2})")]
        public float? SpentAmount { get; set; }

        /// <summary>
        /// Gets or sets Included Users
        /// </summary>
        [Display(Name = "Users to Include")]
        public string[] IncludedUsers { get; set; }

        /// <summary>
        /// Gets or sets Excluded Users
        /// </summary>
        [Display(Name = "Users to Exclude")]
        public string[] ExcludedUsers { get; set; }

        /// <summary>
        /// Gets or sets Group Id
        /// </summary>        
        [Required(ErrorMessage = "Group must be selected.")]
        [Display(Name = "Group")]
        public string[] SelectedGroupId { get; set; }

        /// <summary>
        /// Gets or sets Application User List
        /// </summary>
        public IEnumerable<SelectListItem> Users { get; set; }

        /// <summary>
        /// Gets or sets Application User Group List
        /// </summary>
        public IEnumerable<SelectListItem> UserGroups { get; set; }

        /// <summary>
        /// Gets or sets Budget Category
        /// </summary>
        public IEnumerable<SelectListItem> BudgetCategories { get; set; }

        /// <summary>
        /// Gets or sets Spent Date
        /// </summary>
        [Display(Name = "Spent Date")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        [DataType(DataType.DateTime)]
        [Required(ErrorMessage = "Spent Date cannot be empty")]
        public string SpentDate { get; set; }

        /// <summary>
        /// Gets formatted speen date
        /// </summary>
        public DateTime FormattedSpentDate
        {
            get
            {
                //Convert.ToDateTime(DateTime.ParseExact(expenseViewModel.SpentDate, "dd MM yyyy", CultureInfo.InvariantCulture)),
                if (String.IsNullOrWhiteSpace(SpentDate))
                {
                    return DateTime.Today;
                }

                return DateTime.ParseExact(this.SpentDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
        }

        /// <summary>
        /// Gets or sets Display Spent Date
        /// </summary>
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        [DataType(DataType.Date)]        
        public DateTime DisplaySpentDate { get; set; }

        /// <summary>
        /// Gets or sets Selected Budget
        /// </summary>
        [Required(ErrorMessage="Budget must be selected")]
        [Display(Name = "Budget")]
        public string SelectedBudget { get; set; }

        /// <summary>
        /// Gets or sets Spent By
        /// </summary>
        [Required(ErrorMessage = "Must select the user"), Display(Name = "Spent By")]
        public string SpentBy { get; set; }

        /// <summary>
        /// Gets or sets Spent By Users
        /// </summary>
        public IEnumerable<SelectListItem> SpentByUsers { get; set; }
    }
}