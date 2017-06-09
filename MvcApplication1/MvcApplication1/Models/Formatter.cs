using MvcApplication1.Controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Xml.Serialization;

namespace MvcApplication1.Models
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
            if (objVal != null && !Convert.IsDBNull(objVal) && ConvertToString(objVal) != )
                dtNew = Convert.ToDateTime(objVal);
            else
                dtNew = Convert.ToDateTime(new DateTime(1900, 1, 1));

            return dtNew;
        }

        public static DateTime ConvertToUTCDateTime(object objValdata)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                if (UserContext.CurrentUser.Configuration != null && !String.IsNullOrEmpty(UserContext.CurrentUser.Configuration.TimeZone))
                { return Convert.ToDateTime(objValdata).FromTimeZoneTime(UserContext.CurrentUser.Configuration.TimeZone); }
                else { return Convert.ToDateTime(objValdata).FromTimeZoneTime("Eastern Standard Time"); }
            }
            else
            {
                return ConvertToDateTime();
            }
        }

        public static DateTime ConvertToUTCSMEDateTime(object objValdata,string tzone)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                if (tzone != null && !String.IsNullOrEmpty(tzone))
                { return Convert.ToDateTime(objValdata).FromTimeZoneTime(tzone); }
                else { return Convert.ToDateTime(objValdata).FromTimeZoneTime("Eastern Standard Time"); }
            }
            else
            {
                return ConvertToDateTime();
            }
        }

        public static DateTime ConvertToUTCSMEDateTime1(object objValdata, string tzone,string fzone=)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                DateTime dttime = Convert.ToDateTime(objValdata);
                //TimeZoneInfo objtime = TimeZoneInfo.FindSystemTimeZoneById(fzone);
                //TimeZoneInfo obtotime = TimeZoneInfo.FindSystemTimeZoneById(tzone);
                //dttime = TimeZoneInfo.ConvertTime(dttime, obtotime,objtime );
                //return dttime;
                dttime = Convert.ToDateTime(objValdata).FromTimeZoneTime(fzone);
                TimeZoneInfo easternZone = TimeZoneInfo.FindSystemTimeZoneById(fzone);
                //dttime = dttime.ToUniversalTime();
                dttime = Utility.ToTimeZoneTime(dttime, tzone);
                if (tzone != null && !String.IsNullOrEmpty(tzone))
                { return dttime; }
                else { return Convert.ToDateTime(objValdata).FromTimeZoneTime("Eastern Standard Time"); }
             
            }
            else
            {
                return ConvertToDateTime();
            }
        }

        public static string ConvertToDate(object objValdata)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                if (UserContext.CurrentUser.Configuration != null && !String.IsNullOrEmpty(UserContext.CurrentUser.Configuration.TimeZone))
                { return Convert.ToDateTime(objValdata).ToTimeZoneTime(UserContext.CurrentUser.Configuration.TimeZone).ToString("MMM dd, yyyy"); }
                else { return Convert.ToDateTime(objValdata).ToTimeZoneTime("Eastern Standard Time").ToString("MMM dd, yyyy"); }

            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

        }

          public static string ConvertToDate_withoutConfiguration(object objValdata)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                 return Convert.ToDateTime(objValdata).ToString("MMM dd, yyyy"); 
                

            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

        }

        public static string ConvertToConfigurationDatetime(string objValdata)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                if (UserContext.CurrentUser.Configuration != null && !String.IsNullOrEmpty(UserContext.CurrentUser.Configuration.TimeZone))
                { return Convert.ToDateTime(objValdata).ToTimeZoneTime(UserContext.CurrentUser.Configuration.TimeZone).ToString("MMM dd, yyyy hh:mm tt"); }
                else { return Convert.ToDateTime(objValdata).ToTimeZoneTime("Eastern Standard Time").ToString("MMM dd, yyyy hh:mm tt"); }

            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

        }

        public static string ConvertToConfigurationDate(string objValdata)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                string objConfigDatetime = ;
                if (UserContext.CurrentUser.Configuration != null && !String.IsNullOrEmpty(UserContext.CurrentUser.Configuration.TimeZone))
                {
                    objConfigDatetime=Convert.ToDateTime(objValdata).ToTimeZoneTime(UserContext.CurrentUser.Configuration.TimeZone).ToString("MMM dd, yyyy hh:mm tt");
                    return Convert.ToDateTime(objConfigDatetime).ToString("MMM dd, yyyy"); }
                else { return Convert.ToDateTime(objValdata).ToTimeZoneTime("Eastern Standard Time").ToString("MMM dd, yyyy hh:mm tt"); }

            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

        }

        public static string ConvertToConfigurationTime(string objValdata)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                string objConfigDatetime = ;
                if (UserContext.CurrentUser.Configuration != null && !String.IsNullOrEmpty(UserContext.CurrentUser.Configuration.TimeZone))
                { objConfigDatetime = Convert.ToDateTime(objValdata).ToTimeZoneTime(UserContext.CurrentUser.Configuration.TimeZone).ToString("MMM dd, yyyy hh:mm tt"); return Convert.ToDateTime(objConfigDatetime).ToString("hh:mm tt"); }
                else { return Convert.ToDateTime(objValdata).ToTimeZoneTime("Eastern Standard Time").ToString("hh:mm tt"); }

            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

        }

        //public static string ConvertToCustomDate(string objValdata)
        //{
        //    //DateTime dtNew=new DateTime();

        //    if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
        //    {
        //        DateTime objVal = Convert.ToDateTime(objValdata);
        //        //if (DateTime.TryParseExact(objVal, "MMM dd", null, System.Globalization.DateTimeStyles.None, out dtNew))
        //        //{
        //        string dttime = ;
        //        dttime = objVal.ToString("MMM dd");
        //        //return ;
        //        //}
        //        return dttime;
        //    }
        //    else
        //    {
        //        //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
        //        return ;
        //    }

        //}

        public static string ConvertToDate_FormatChange(object objValdata)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                if (UserContext.CurrentUser.Configuration != null && !String.IsNullOrEmpty(UserContext.CurrentUser.Configuration.TimeZone))
                { return Convert.ToDateTime(objValdata).ToTimeZoneTime(UserContext.CurrentUser.Configuration.TimeZone).ToString("MM/dd/yyyy"); }
                else { return Convert.ToDateTime(objValdata).ToTimeZoneTime("Eastern Standard Time").ToString("MM/dd/yyyy"); }

            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

        }


        public static string ConvertToCustomDate(object objValdata)
        {
            //DateTime dtNew=new DateTime();

            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                if (UserContext.CurrentUser.Configuration != null && !String.IsNullOrEmpty(UserContext.CurrentUser.Configuration.TimeZone))
                { return Convert.ToDateTime(objValdata).ToTimeZoneTime(UserContext.CurrentUser.Configuration.TimeZone).ToString("MMM dd"); }
                else { return Convert.ToDateTime(objValdata).ToTimeZoneTime("Eastern Standard Time").ToString("MMM dd"); }


            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

        }

        public static string ConvertToDateTime(string objValdata, string timezoneInfo)
        {
            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                DateTime objVal = Convert.ToDateTime(objValdata);
                string dttime = ;
                dttime = objVal.ToString("MMM dd h:mm tt");
                return dttime;
            }
            else
            {
                return ;
            }
        }

        public static string ConvertToTime(object objValdata)
        {
            //DateTime dtNew=new DateTime();

            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                if (UserContext.CurrentUser.Configuration != null && !String.IsNullOrEmpty(UserContext.CurrentUser.Configuration.TimeZone))
                { return Convert.ToDateTime(objValdata).ToTimeZoneTime(UserContext.CurrentUser.Configuration.TimeZone).ToString("hh:mm tt"); }
                else { return Convert.ToDateTime(objValdata).ToTimeZoneTime("Eastern Standard Time").ToString("hh:mm tt"); }

            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

        }
        public static string ConvertToTime_withoutConfiguration(object objValdata)
        {
            //DateTime dtNew=new DateTime();

            if (objValdata != null && !Convert.IsDBNull(objValdata) && ConvertToString(objValdata) != )
            {
                 return Convert.ToDateTime(objValdata).ToString("hh:mm tt"); 
            }
            else
            {
                //dttime = Convert.ToDateTime(new DateTime(1900, 1, 1));
                return ;
            }

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
        /// Method to Convert a Given object into Decimal
        /// </summary>
        /// <param name="value">object</param>
        /// <returns></returns>
        public static decimal ConvertToDecimalWithoutRoundOff(object value)
        {
            if (Convert.IsDBNull(value) == true && Convert.GetTypeCode(value) != TypeCode.Decimal) { return Math.Round(0.0M); } else { if (value.ToString() == string.Empty) { return Math.Round(0.0M); } else { return Convert.ToDecimal(value); } }
        }


        /// <summary>
        /// Returns Default Time span
        /// </summary>
        /// <param name="objVal">Time String</param>
        /// <returns>TimeSpan</returns>
        public static TimeSpan ConvertToTimeSpan(object objVal)
        {
            if (objVal != null && !Convert.IsDBNull(objVal) && ConvertToString(objVal) != )
                return Convert.ToDateTime(DateTime.Now.Date.ToShortDateString() + " " + objVal).TimeOfDay;
            else
                return new TimeSpan();
        }
        #endregion

        #region crypto functions
        ///// <summary>
        ///// function to decrypt a phrase
        ///// </summary>
        //public static string Decrypt(string strPhrase)
        //{
        //    if (String.IsNullOrEmpty(strPhrase)) { return strPhrase.Trim(); }
        //    else
        //    {
        //        string decodedPhrase;
        //        byte[] arrByte;

        //        arrByte = ASCIIEncoding.ASCII.GetBytes(strPwdKey);
        //        ICryptoTransform desdecrypt = cryptDES3.CreateDecryptor(arrByte, arrByte);
        //        arrByte = Convert.FromBase64String(strPhrase);
        //        decodedPhrase = ASCIIEncoding.ASCII.GetString(desdecrypt.TransformFinalBlock(arrByte, 0, arrByte.Length));

        //        return decodedPhrase;
        //    }
        //}
        ///// <summary>
        ///// function to encrypt a phrase
        ///// </summary>
        //public static string Encrypt(string strPhrase)
        //{
        //    if (String.IsNullOrEmpty(strPhrase)) { return strPhrase.Trim(); }
        //    else
        //    {
        //        string encodedPhrase;
        //        byte[] arrByte;

        //        arrByte = ASCIIEncoding.ASCII.GetBytes(strPwdKey);
        //        ICryptoTransform desencrypt = cryptDES3.CreateEncryptor(arrByte, arrByte);
        //        arrByte = ASCIIEncoding.ASCII.GetBytes(strPhrase);
        //        encodedPhrase = Convert.ToBase64String(desencrypt.TransformFinalBlock(arrByte, 0, arrByte.Length));

        //        return encodedPhrase;
        //    }
        //}

        /// <summary>
        /// function to encrypt a phrase
        /// </summary>
        public static string Encrypt(string textToEncrypt)
        {
            RijndaelManaged rijndaelCipher = new RijndaelManaged();
            rijndaelCipher.Mode = CipherMode.CBC;
            rijndaelCipher.Padding = PaddingMode.PKCS7;

            rijndaelCipher.KeySize = 0x80;
            rijndaelCipher.BlockSize = 0x80;
            byte[] pwdBytes = Encoding.UTF8.GetBytes(strKey);
            byte[] keyBytes = new byte[0x10];
            int len = pwdBytes.Length;
            if (len > keyBytes.Length)
            {
                len = keyBytes.Length;
            }
            Array.Copy(pwdBytes, keyBytes, len);
            rijndaelCipher.Key = keyBytes;
            rijndaelCipher.IV = keyBytes;
            ICryptoTransform transform = rijndaelCipher.CreateEncryptor();
            byte[] plainText = Encoding.UTF8.GetBytes(textToEncrypt);
            return Convert.ToBase64String(transform.TransformFinalBlock(plainText, 0, plainText.Length));
        }

        /// <summary>
        /// function to Decrypt a phrase
        /// </summary>
        public static string Decrypt(string textToDecrypt)
        {
            RijndaelManaged rijndaelCipher = new RijndaelManaged();
            rijndaelCipher.Mode = CipherMode.CBC;
            rijndaelCipher.Padding = PaddingMode.PKCS7;

            rijndaelCipher.KeySize = 0x80;
            rijndaelCipher.BlockSize = 0x80;
            byte[] encryptedData = Convert.FromBase64String(textToDecrypt);
            byte[] pwdBytes = Encoding.UTF8.GetBytes(strKey);
            byte[] keyBytes = new byte[0x10];
            int len = pwdBytes.Length;
            if (len > keyBytes.Length)
            {
                len = keyBytes.Length;
            }
            Array.Copy(pwdBytes, keyBytes, len);
            rijndaelCipher.Key = keyBytes;
            rijndaelCipher.IV = keyBytes;
            byte[] plainText = rijndaelCipher.CreateDecryptor().TransformFinalBlock(encryptedData, 0, encryptedData.Length);
            return Encoding.UTF8.GetString(plainText);
        }
        #endregion

        #region XML Conversion
        /// <summary>
        /// Gets type object and returns converted Xml string
        /// </summary>
        /// <param name="value">Object type</param>
        /// <returns>XML String</returns>
        public static string GetObjectAsXmlString(Object value)
        {
            try
            {
                if (value != null)
                {
                    XmlSerializer objxmldata = new XmlSerializer(value.GetType());
                    using (MemoryStream objStream = new MemoryStream())
                    {
                        objxmldata.Serialize(objStream, value);
                        string result = Encoding.UTF8.GetString(objStream.ToArray(), 0, objStream.ToArray().Length);
                        return result;
                    }
                }
                else
                { return ; }
            }
            catch (Exception ex)
            { return ; }
        }
        #endregion

        #region Others
        /// <summary>
        /// Concatenate First Name, Middle Name, and Last Name as Full Name
        /// </summary>
        /// <param name="objFirstName"></param>
        /// <param name="objMiddleName"></param>
        /// <param name="objLastName"></param>
        /// <returns></returns>
        public static String GetFullName(Object objFirstName, Object objMiddleName, Object objLastName)
        {
            String fname = Formatter.ConvertToString(objFirstName);
            String mname = Formatter.ConvertToString(objMiddleName);
            String lname = Formatter.ConvertToString(objLastName);

            String fullname = String.Empty;
            fullname += String.IsNullOrEmpty(lname) ? String.Empty : lname;
            fullname += String.IsNullOrEmpty(fname) ? String.Empty : " " + fname;
            fullname += String.IsNullOrEmpty(mname) ? String.Empty : " " + mname;

            return fullname;
        }
        /// <summary>
        /// Convert hex string to byte array
        /// </summary>
        /// <param name="strHexInput">
        public static Byte[] ConvertToByteArray(String strHexInput)
        {
            // i variable used to hold position in string
            int i = 0;
            // x variable used to hold byte array element position
            int x = 0;
            // allocate byte array based on half of string length
            byte[] bytes = new byte[(strHexInput.Length) / 2];
            // loop through the string - 2 bytes at a time converting
            //  it to decimal equivalent and store in byte array
            while (strHexInput.Length > i + 1)
            {
                bytes[x] = Convert.ToByte(Convert.ToInt32(strHexInput.Substring(i, 2), 16));
                i = i + 2;
                ++x;
            }
            // return the finished byte array of decimal values
            return bytes;
        }
        ///// <summary>
        ///// Convert Ascii string to byte array
        ///// </summary>
        ///// <param name="strHexInput">
        //public static Byte[] ConvertAsciiToByteArray(String strASCIIInput)
        //{
        //    return Encoding.ASCII.GetBytes(strASCIIInput);
        //}
        ///// <summary>
        ///// Convert base64 string to byte array
        ///// </summary>
        ///// <param name="strBase64String"></param>
        ///// <returns></returns>
        //public static Byte[] Base64ToByteArray(string strBase64String)
        //{
        //    Byte[] bytimage = new Byte[strBase64String.Length];
        //    for (int i = 0; i < strBase64String.Length; i++)
        //    {
        //        bytimage[i] = Convert.ToByte(strBase64String[i]);
        //    }
        //    return bytimage;

        //    //// Convert Base64 String to byte array
        //    //return Convert.FromBase64String(strBase64String);
        //}

        #region Convert UTC to Other Format Date

        public static DateTime ConvertUTCtoOtherFormat(DateTime UTCDate, DateTime OtherFormatDate)
        {
            TimeZoneInfo OtherFormatDateTime = TimeZoneInfo.FindSystemTimeZoneById(OtherFormatDate.ToString());
            DateTime ConvertedDate = TimeZoneInfo.ConvertTimeFromUtc(UTCDate, OtherFormatDateTime);
            return ConvertedDate;
        }
        #endregion


        public static string SFTimeZone
        {
            get
            {
                if (HttpContext.Current.Session["SFTimeZoneFormat"] != null)
                {
                    return (string)HttpContext.Current.Session["SFTimeZoneFormat"];
                }
                else
                {
                    StaffingfirmRepository objStaffingfirmRepository = new StaffingfirmRepository();
                    string strtimezoneval = objStaffingfirmRepository.GetSFTimeZone();
                    return strtimezoneval;
                }
            }
            set
            {
                HttpContext.Current.Session["SFTimeZoneFormat"] = value;
            }
        }









        #endregion
    }

}