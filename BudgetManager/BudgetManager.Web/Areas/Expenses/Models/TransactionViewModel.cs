namespace BudgetManager.Web.Areas.Expenses.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;
    using BudgetManager.Helpers.Permissions;

    public class TransactionViewModel : PermissionBase
    {
        [Required(ErrorMessage="Must enter the description.")]
        [StringLength(200, MinimumLength = 10, ErrorMessage="Description must contain atleast 10 and upto 200 characters.")]
        [Display(Name="Description")]
        public string Description { get; set; }

        [Required(ErrorMessage="Select the expense to match with.")]
        [Display(Name="Select the type of Expense")]
        public long SelectedExpense { get; set; }

        public string SelectedExpenseName { get; set; }

        public IEnumerable<SelectListItem> Expenses { get; set; }

        [Required(ErrorMessage="Select the user returned the amount.")]
        [Display(Name = "Amount returned by")]
        public string AmountReturnedBy { get; set; }

        [Required(ErrorMessage="Select the user received the amount.")]
        [Display(Name="Amount received by")]
        public string AmountReceivedBy { get; set; }
        public IEnumerable<SelectListItem> UsersInExpense { get; set; }

        [Required(ErrorMessage="Amount returned cannot be left empty.")]
        [Range(1, double.MaxValue, ErrorMessage = "Entered amount must be greater than zero or is out of range.")]
        [Display(Name="Amount returned")]
        [Remote("CheckAmountBeyondLevel", "Transaction", AdditionalFields = "SelectedExpense, AmountReceivedBy, AmountReturnedBy,AmountReturned", ErrorMessage = "Amount is beyond your amount to be returned.")]
        public decimal? AmountReturned { get; set; }

        [Required(ErrorMessage="Select the date returned")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        [DataType(DataType.DateTime)]
        [Display(Name = "Amount returned on")]
        public DateTime? AmountReturnedOn { get; set; }

        public long TransactionId { get; set; }
    }
}