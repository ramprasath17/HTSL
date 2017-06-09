namespace BudgetManager.Web.Models
{
    using System.ComponentModel.DataAnnotations;

    public class ProfileDetailViewModel
    {
        [UIHint("DatePicker")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        public string dateOfBirth
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets Gender
        /// </summary>
        public enum Gender
        {
            Male = 0,
            Female
        }

        [Required(ErrorMessage = "Address is required")]
        [StringLength(20)]
        [Display(Name = "Address Line 1")]
        public string addressLineOne
        {
            get;
            set;
        }

        [StringLength(20)]
        [Display(Name = "Address Line 2")]
        public string addressLineTwo
        {
            get;
            set;
        }

        [Required(ErrorMessage = "")]
        [StringLength(15)]
        [Display(Name = "City")]
        public string city
        {
            get;
            set;
        }

        [Required(ErrorMessage = "")]
        [Display(Name = "Pincode")]
        public string pincode
        {
            get;
            set;
        }

        [Required(ErrorMessage = "")]
        [Display(Name = "State")]
        public string state
        {
            get;
            set;
        }

        [Required(ErrorMessage = "")]
        [Display(Name = "Country")]
        public string country
        {
            get;
            set;
        }
    }

}