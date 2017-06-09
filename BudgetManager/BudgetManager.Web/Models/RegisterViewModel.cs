namespace BudgetManager.Web.Models
{
    using System;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;
    using BudgetManager.Entities;
    using BudgetManager.Security.EncDec;
    using BudgetManager.Web.Models;

    /// <summary>
    /// Registration View Model
    /// </summary>
    public class RegisterViewModel : LogInViewModel
    {
        #region Dependency Injector
        IDataMorpher encDecryption;
        #endregion

        #region Injection Constructor

        public RegisterViewModel() :
            this(DependencyResolver.Current.GetService<IDataMorpher>())
        {

        }

        public RegisterViewModel(IDataMorpher encDecryption)
        {
            this.encDecryption = encDecryption;
        }

        #endregion


        [Display(Name = "User Name", Description = "Enter your user name")]
        [Required(ErrorMessage = "Please provide user name!")]
        [StringLength(30, ErrorMessage = "Maximum of upto 30 characters are allowed")]
        [Remote("CheckUserNameIsExists", "Account", ErrorMessage = "Looks you're too late to register with this user name! Try some other.")]
        public override string userName
        {
            get;
            set;
        }

        [StringLength(15, ErrorMessage = "Cannot exceed more than 15 characters.")]
        [Display(Name = "Display Name")]
        public string displayName
        {
            get;
            set;
        }

        [Display(Name = "Password", Description = "Enter the password")]
        [Required(ErrorMessage = "Please provide a password!")]
        [StringLength(30, MinimumLength = 8, ErrorMessage = "Password field must contain atleast 8 characters")]
        [DataType(DataType.Password)]
        public override string password
        {
            get;
            set;
        }

        [Display(Name = "Confirm Password", Description = "Re-enter you password")]
        [DataType(DataType.Password)]
        [System.Web.Mvc.Compare("password")]
        public string confirmPassword
        {
            get;
            set;
        }

        [Display(Name = "Email ID", Description = "Enter your e-mail id")]
        [Required(ErrorMessage = "Email id is required")]
        [RegularExpression(Messages.EmailValidationFormat, ErrorMessage = Messages.InvalidEmailErrorMessage)]
        [Remote("CheckUserEmailIsExists", "Account", ErrorMessage = Messages.RegisteredEmailAddressErrorMessage)]
        [Category("Registration Email")]
        [DataType(DataType.EmailAddress)]
        public string email
        {
            get;
            set;
        }

        [ScaffoldColumn(false)]
        public string emailVerifiationId
        {
            get
            {
                return encDecryption.Encrypt(userName + "~" + email + "~" + displayName + "~" + DateTime.Now.TimeOfDay.ToString());
            }
        }
    }
}