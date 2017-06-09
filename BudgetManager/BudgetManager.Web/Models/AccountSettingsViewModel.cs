namespace BudgetManager.Web.Models
{
    using System;
    using System.Collections.Generic;
    using System.Web.Mvc;
    using System.ComponentModel.DataAnnotations;

    public class AccountSettingsViewModel
    {
        public string UserName { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string MiddleName { get; set; }

        public string PetName { get; set; }

        [DataType(DataType.Date, ErrorMessage = "Date of Birth should be a valid date")]        
        public string DateOfBirth { get; set; }

        public string Gender { get; set; }

        //public IEnumerable<SelectListItem> GenderList
        //{
        //    get
        //    {
        //        return new List<SelectListItem>
        //        {
        //            new SelectListItem
        //            {
        //               Text = "Male",
        //               Value = "M"                       
        //            },
        //            new SelectListItem
        //            {
        //               Text = "Female",
        //               Value = "F"
        //            }
        //        };
        //    }
        //}

        public string Email { get; set; }

        [DataType(DataType.PhoneNumber,ErrorMessage = "Phone Number should be numeric")]
        public string Phone { get; set; }

        [Remote("CheckUserPassword", "Account", ErrorMessage = "Your old password is mismatch.")]
        public string CurrentPassword { get; set; }

        public string NewPassword { get; set; }

        [System.Web.Mvc.Compare("NewPassword")]
        public string ConfirmPassword { get; set; }

        public bool AllowInvites { get; set; }

        public int CompanyId { get; set; }

        public string CompanyName { get; set; }

        public string AddressLine1 { get; set; }

        public string AddressLine2 { get; set; }

        public string City { get; set; }

        [DataType(DataType.PostalCode,ErrorMessage ="Postal Code should be numeric")]
        public string PinCode { get; set; }

        public string Country { get; set; }

        public string Mobile { get; set; }
    }
}