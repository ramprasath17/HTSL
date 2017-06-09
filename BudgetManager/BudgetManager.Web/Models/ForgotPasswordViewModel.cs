namespace BudgetManager.Web.Models
{
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using BudgetManager.Entities;

    public class ForgotPasswordViewModel
    {
        [Display(Name = "Email ID", Description = "Enter your e-mail id")]
        [Required(ErrorMessage = "Email id is required to recover your password.")]
        [RegularExpression(Messages.EmailValidationFormat, ErrorMessage = "Doesn't seems to be a valid email id.")]
        [Category("Forgot password email")]
        public string email
        {
            get;
            set;
        }
    }
}