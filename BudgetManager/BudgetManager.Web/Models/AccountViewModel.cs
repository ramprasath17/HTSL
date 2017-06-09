namespace BudgetManager.Web.Models
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.ComponentModel.DataAnnotations;
    using System.Web.Mvc;
    using BudgetManager.Infrastructure.Attributes;
    using BudgetManager.Security.EncDec;
    using BudgetManager.Entities;
    using System.ComponentModel;

    public class LogInViewModel
    {
        [Display(Name = "User Name", Description = "Enter the user name/ e-mail id")]
        [Required(ErrorMessage = "User name cannot be empty!")]
        [StringLength(30, ErrorMessage = "OOPs! Looks like you have exceeded the character limit.")]
        public virtual string userName
        {
            get;
            set;
        }

        [Display(Name = "Password", Description = "Enter the password")]
        [Required(ErrorMessage = "Password field cannot be left blank")]
        [DataType(DataType.Password)]
        [Editable(false)]
        public virtual string password
        {
            get;
            set;
        }

        [Display(Name = "Remember Me")]
        public bool rememberMe
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets Invalid log in attempts by user
        /// </summary>
        public int InvalidLogInAttempts { get; set; }
    }
}

//Important: For Remote attribute to  work, make sure the validating method must be a [AllowAnonymous] method which should not do any authorization if does then the validation fails