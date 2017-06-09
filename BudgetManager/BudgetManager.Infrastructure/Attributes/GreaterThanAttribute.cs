namespace BudgetManager.Infrastructure.Attributes
{
    using BudgetManager.Infrastructure.ClientValidateRules;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Diagnostics.CodeAnalysis;
    using System.Globalization;
    using System.Reflection;
    using System.Web.Mvc;

    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    [SuppressMessage("Microsoft.Performance", "CA1813:AvoidUnsealedAttributes", Justification = "This attribute is designed to be a base class for other attributes.")]
    public class GreaterThanAttribute : ValidationAttribute, IClientValidatable
    {
        private string _fieldToCompare { get; set; }

        public GreaterThanAttribute(string fieldToCompare)
        {
            if (fieldToCompare == null)
            {
                throw new ArgumentNullException("Must specify the property to compare with.");
            }

            _fieldToCompare = fieldToCompare;
        }

        //
        // Summary:
        //     Validates the specified value with respect to the current validation attribute.
        //
        // Parameters:
        //   value:
        //     The value to validate.
        //
        //   validationContext:
        //     The context information about the validation operation.
        //
        // Returns:
        //     An instance of the System.ComponentModel.DataAnnotations.ValidationResult
        //     class.
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            PropertyInfo otherPropertyInfo = validationContext.ObjectType.GetProperty(_fieldToCompare);
            if (otherPropertyInfo == null)
            {
                return new ValidationResult(String.Format(CultureInfo.CurrentCulture, "Unknown property", _fieldToCompare));
            }

            object otherPropertyValue = otherPropertyInfo.GetValue(validationContext.ObjectInstance, null);
            if (!(Convert.ToDouble(value) >= Convert.ToDouble(otherPropertyValue)))
            {
                return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
            }
            return null;
        }

        public static string FormatPropertyForClientValidation(string property)
        {
            if (property == null)
            {
                throw new ArgumentException("Cannot be empty", "property");
            }
            return "*." + property;
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            yield return new ModelClientValidationGreaterThanRule(FormatErrorMessage(metadata.GetDisplayName()), FormatPropertyForClientValidation(_fieldToCompare));
        }
    }
}
