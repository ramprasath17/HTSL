using MvcApplication2.Controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Xml.Serialization;

namespace MvcApplication2.Models
{
    public class Formatter
    {
        #region Private Members
        //Slachter
        private static String strKey = "123456789";
        //private static DESCryptoServiceProvider cryptDES3 = new DESCryptoServiceProvider();

        #endregion

        #region Type Conversion
        /// <summary>
        /// Get object value and returns converted string value
        /// </summary>
        /// <param name="objVal">Object</param>
        /// <returns>string value</returns>
        public static string ConvertToString(object objVal)
        {
            if (Convert.IsDBNull(objVal) == true && Convert.GetTypeCode(objVal) != TypeCode.String) { return string.Empty; }
            else { return Convert.ToString(objVal); }
        }
        /// <summary>
        /// Get object value and returns converted integer value
        /// </summary>
        /// <param name="objVal">Object</param>
        /// <returns>integer value</returns>
        public static int ConvertToInt(object objVal)
        {
            if (Convert.IsDBNull(objVal) == true && Convert.GetTypeCode(objVal) != TypeCode.Int32) { return 0; }
            else { if (ConvertToString(objVal) == string.Empty) { return 0; } else { return Convert.ToInt32(objVal); } }
        }
        /// <summary>
        /// Convert a given object into GUID
        /// </summary>
        /// <param name="value">object</param>
        /// <returns></returns>
        public static Guid ConvertToGuid(object objVal)
        {
            if (Convert.IsDBNull(objVal) == true || Convert.ToString(objVal) == string.Empty) { return Guid.Empty; }
            else { return new Guid(Convert.ToString(objVal)); }
        }


        /// <summary>
        /// Convert a given object into Bool
        /// </summary>
        /// <param name="value">object</param>
        /// <returns></returns>
        public static bool ConvertToBool(object objVal)
        {
            if ((string.IsNullOrEmpty(objVal.ToString()) == true) || (Convert.IsDBNull(objVal) == true && Convert.GetTypeCode(objVal) != TypeCode.Boolean)) { return false; }
            else { return Convert.ToBoolean(objVal); }
        }
        /// <summary>
        /// Returns Default DateTime
        /// </summary>
        /// <param name="dateTime">DateTime</param>
        /// <returns>DateTime</returns>
        public static DateTime ConvertToDateTime(object objVal)
        {
            DateTime dtNew;
            if (objVal != null && !Convert.IsDBNull(objVal) && ConvertToString(objVal) != "")
                dtNew = Convert.ToDateTime(objVal);
            else
                dtNew = Convert.ToDateTime(new DateTime(1900, 1, 1));

            return dtNew;
        }

        /// <summary>
        /// Method to Convert a Given object into Decimal
        /// </summary>
        /// <param name="value">object</param>
        /// <returns></returns>
        public static decimal ConvertToDecimal(object value)
        {
            if (Convert.IsDBNull(value) == true && Convert.GetTypeCode(value) != TypeCode.Decimal) { return Math.Round(0.0M); } else { if (value.ToString() == string.Empty) { return Math.Round(0.0M); } else { return Math.Round(Convert.ToDecimal(value), 2); } }
        }


        /// <summary>
        /// Method to Convert a Given object into double
        /// </summary>
        /// <param name="Val">object</param>
        /// <returns></returns>
        public static double ConvertToDouble(object Val)
        {
            if (Convert.IsDBNull(Val) == true && Convert.GetTypeCode(Val) != TypeCode.Double) { return 0.0D; } else { if (Val.ToString() == string.Empty) { return 0.0D; } else { return Convert.ToDouble(Val); } }
        }


        #endregion
    }

}