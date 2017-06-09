namespace BudgetManager.Infrastructure.ClientValidateRules
{
    using System.Web.Mvc;

    public class ModelClientValidationGreaterThanRule : ModelClientValidationRule
    {
        public ModelClientValidationGreaterThanRule(string errorMessage, object other)
        {
            ErrorMessage = errorMessage;
            ValidationType = "greaterthan";
            ValidationParameters["other"] = other;
        }
    }
}
