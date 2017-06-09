namespace BudgetManager.Infrastructure.Attributes
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.Web.Mvc;

    [AttributeUsage(AttributeTargets.Property)]
    public class StringRangeAttribute : ValidationAttribute//, IClientValidatable
    {
        public int _minLength = 0;
        public int _maxLength = 0;
        public string validationType = string.Empty;
        public string StringRangeErrorMessage
        {
            get;
            set;
        }

        public StringRangeAttribute(int minLength)
            : base("{0} must match the value provided for {1}")
        {
            this._minLength = minLength;
            this.validationType = "min";
        }

        public StringRangeAttribute(int minLength, int maxLength)
        {
            this._minLength = minLength;
            this._maxLength = maxLength;
            this.validationType = "between";
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            string strValue = value as string;
            int strLength = strValue.Length;
            bool validationResult = false;
            switch (validationType)
            {
                case "min":
                    validationResult = (strLength >= _minLength);
                    break;
                case "between":
                    validationResult = ((strLength >= _minLength) && (strLength <= _maxLength));
                    break;
                default:
                    validationResult = false;
                    break;
            }
            //string errMessage = FormatErrorMessage(validationContext.DisplayName);
            if (!validationResult)
            {
                return new ValidationResult(StringRangeErrorMessage);
            }
            return ValidationResult.Success;
        }

        public override string FormatErrorMessage(string name)
        {
            return base.FormatErrorMessage(name == "" ? ErrorMessage : name);
        }

        /// <summary>
        /// Including the client side validation for this attribute
        /// </summary>
        /// <param name="metadata"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        //public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        //{
        //    var rule = new ModelClientValidationRule();
        //    //rule.ErrorMessage = FormatErrorMessage("");
        //    //Unobtrusive method name - the same name should be used in defining the unobtrusive validation method
        //    rule.ValidationType = "stringRange";
        //    //Don't have any parameters to add at this time 
        //    //rule.ValidationParameters.Add();
        //    yield return rule;
        //}
    }
}
