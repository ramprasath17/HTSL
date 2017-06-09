namespace BudgetManager.Infrastructure.Helpers
{
    using System;

    /// <summary>
    /// Type Conversion Helper class 
    /// </summary>
    public static class TypeConversionHelper
    {
        /// <summary>
        /// Get the default value of the type specified if the input value is null
        /// </summary>
        /// <typeparam name="TResult">Return value type</typeparam>
        /// <param name="inputVar">input parameter</param>
        /// <returns>Returns TResult</returns>
        public static TResult GetDefaultValueIfNull<TResult>(this object inputVar) 
        {
            string convInput = Convert.ToString(inputVar);
            if (string.IsNullOrWhiteSpace(convInput))
            {
                return default(TResult);
            }

            try
            {
                System.Diagnostics.Debug.WriteLine("Type casted successfully.");
                TResult tResult = (TResult)Convert.ChangeType(convInput, typeof(TResult));
                return tResult;
            }
            catch (FormatException fe)
            {
                System.Diagnostics.Debug.WriteLine("There was an error in type casting, the error message is '{0}'", fe.Message);
                return default(TResult);
            }
        }

        /// <summary>
        /// Get the specified default value if the input value id null
        /// </summary>
        /// <typeparam name="TResult">Return value type</typeparam>
        /// <param name="inputVar">input parameter</param>
        /// <param name="resultVal">Specified default value</param>
        /// <returns>Returns TResult</returns>
        public static TResult GetDefaultValueIfNull<TResult>(this object inputVar, TResult resultVal)
        {
            string convInput = Convert.ToString(inputVar);
            if (string.IsNullOrWhiteSpace(convInput))
            {
                if (resultVal == null)
                {
                    return default(TResult);
                }
                return resultVal;
            }

            try
            {
                System.Diagnostics.Debug.WriteLine("Type casted successfully.");
                TResult tResult = (TResult)Convert.ChangeType(convInput, typeof(TResult));
                return tResult;
            }
            catch (FormatException fe)
            {
                System.Diagnostics.Debug.WriteLine("There was an error in type casting, the error message is '{0}'", fe.Message);
                return default(TResult);
            }
        }        

    }

}
