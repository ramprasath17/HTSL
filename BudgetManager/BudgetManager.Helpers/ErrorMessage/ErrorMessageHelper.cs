namespace BudgetManager.Infrastructure.Helpers.ErrorMessage
{
    using System;

    public static class ErrorMessageHelper
    {
        /// <summary>
        /// Gets or sets Error Description
        /// </summary>
        public static string Description { get; set; }

        /// <summary>
        /// Gets or sets Error Message
        /// </summary>
        public static string Message { get; set; }

        /// <summary>
        /// Gets or sets stack trace
        /// </summary>
        public static string StackTrace { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether exception is occurred or not
        /// </summary>
        private static bool IsExceptionOccurred { get; set; }

        /// <summary>
        /// Get Exception Message
        /// </summary>
        /// <returns></returns>
        public static string GetExceptionDetails()
        {
            string errorMessage = string.Empty;
            if (IsExceptionOccurred)
            {
                errorMessage = string.Format("Message: {0}<br/>Description: {1}<br/>Stack Trace: {2}",
                    Message, Description, string.Empty);
            }

            ClearErrorMessage();
            return errorMessage;
        }

        /// <summary>
        /// Sets the exception message
        /// </summary>
        /// <param name="exception"></param>
        public static void SetExceptionMessage(Exception exception)
        {
            if (exception != null)
            {
                Message = exception.Message;
                StackTrace = exception.StackTrace;
                Description = exception.InnerException.ToString();
            }
            else
            {
                IsExceptionOccurred = true;
            }

        }

        /// <summary>
        /// Clear error Message
        /// </summary>
        public static void ClearErrorMessage()
        {
            Message = string.Empty;
            StackTrace = string.Empty;
            Description = string.Empty;
        }
    }
}
