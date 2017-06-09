using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;

namespace BudgetManager.Security.EncDec
{
	public class DataMorpher : IDataMorpher
	{
		public string Encrypt(string strToEncrypt)
		{
			try
			{
				string strKey = "8UGetM@n@Ge6";
				TripleDESCryptoServiceProvider objDESCrypto = new TripleDESCryptoServiceProvider();
				MD5CryptoServiceProvider objHashMD5 = new MD5CryptoServiceProvider();
				byte[] byteHash, byteBuff;
				string strTempKey = strKey;
				byteHash = objHashMD5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(strTempKey));
				objHashMD5 = null;
				objDESCrypto.Key = byteHash;
				objDESCrypto.Mode = CipherMode.ECB; //CBC, CFB
				byteBuff = ASCIIEncoding.ASCII.GetBytes(strToEncrypt);
				return Convert.ToBase64String(objDESCrypto.CreateEncryptor().
				TransformFinalBlock(byteBuff, 0, byteBuff.Length));
			}
			catch (Exception ex)
			{
				return "Wrong Input. " + ex.Message;
			}
		}

		/// <summary>
		/// Decrypt the given string using the specified key.
		/// </summary>
		/// <param name="strEncrypted">The string to be decrypted.</param>
		/// <param name="strKey">The decryption key.</param>
		/// <returns>The decrypted string.</returns>
		public string Decrypt(string strEncrypted)
		{
			try
			{
				string strKey = "8UGetM@n@Ge6";
				TripleDESCryptoServiceProvider objDESCrypto =
				new TripleDESCryptoServiceProvider();
				MD5CryptoServiceProvider objHashMD5 = new MD5CryptoServiceProvider();
				byte[] byteHash, byteBuff;
				string strTempKey = strKey;
				byteHash = objHashMD5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(strTempKey));
				objHashMD5 = null;
				objDESCrypto.Key = byteHash;
				objDESCrypto.Mode = CipherMode.ECB; //CBC, CFB
				byteBuff = Convert.FromBase64String(strEncrypted);
				string strDecrypted = ASCIIEncoding.ASCII.GetString(objDESCrypto.CreateDecryptor().TransformFinalBlock
				(byteBuff, 0, byteBuff.Length));
				objDESCrypto = null;
				return strDecrypted;
			}
			catch (Exception ex)
			{
				return "Wrong Input. " + ex.Message;
			}
		}

        public void Dispose()
        {            
            GC.SuppressFinalize(this);
        }
    }
}
