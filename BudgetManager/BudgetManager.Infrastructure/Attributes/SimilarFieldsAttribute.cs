namespace BudgetManager.Infrastructure.Attributes
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.ComponentModel.DataAnnotations;
    using System.Reflection;
    using System.Web.Mvc;

    [AttributeUsage(AttributeTargets.Property)]
    public class SimilarFieldsAttribute : ValidationAttribute//, IClientValidatable
    {       
        public string _relatedPropertyValue = string.Empty;
        string _relatedField = string.Empty;
        public string ErrMessage
        {
            get;
            set;
        }

        Assembly asssembly = Assembly.GetExecutingAssembly();        

        public SimilarFieldsAttribute(string relatedField)
        {
            _relatedField = relatedField;  
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            string stringValue = value as string;
            var relatedPropertyInfo = validationContext.ObjectType.GetProperty(_relatedField);
            if (relatedPropertyInfo == null)
            {
                return new ValidationResult(string.Format("unknown property {0}", this._relatedField));
            }
            _relatedPropertyValue = (string)relatedPropertyInfo.GetValue(validationContext.ObjectInstance, null);
            if (stringValue != _relatedPropertyValue)
            {
                return new ValidationResult(ErrMessage);
            }
            else
            {
                return ValidationResult.Success;
            }
        }

        public override string FormatErrorMessage(string name)
        {
            return base.FormatErrorMessage(name);
        }
    }
}
