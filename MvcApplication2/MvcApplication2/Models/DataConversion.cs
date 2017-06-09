using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace MvcApplication2.Models
{
    public class DataConversion
    {
        private const string PASSWORDKEY = "InTaase!";
        private const string PASSPHRASE = "@ssap&#811";
        private const string PASSSALT = "s@1et";
        private const string INTVECTOR = "@a79G078yZ26b4d8";

        public DataConversion()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #region Decrypt
        /// <summary>
        /// Decrypts the specified plain text.
        /// </summary>
        /// <param name="plainText">The plain text.</param>
        /// <returns>Decrypted Password</returns>
        public string Decrypt(string plainText)
        {
            plainText = plainText.Replace(" ", "+");
            return Decrypt(plainText, PASSWORDKEY);
        }
        #endregion
        #region Decrypt
        /// <summary>
        /// Decrypts the specified plain text.
        /// </summary>
        /// <param name="plainText">The plain text.</param>
        /// <param name="passPhrase">The pass phrase.</param>
        /// <returns>Decrypted Password</returns>
        private static string Decrypt(string plainText, string passPhrase)
        {
            plainText = plainText.Replace(" ", "+");
            return Decrypt(plainText, passPhrase + PASSPHRASE, passPhrase + PASSSALT, "SHA1", 2, INTVECTOR, 0x100);
        }
        #endregion
        #region Decrypt
        /// <summary>
        /// Decrypts the specified cipher text.
        /// </summary>
        /// <param name="cipherText">The cipher text.</param>
        /// <param name="passPhrase">The pass phrase.</param>
        /// <param name="saltValue">The salt value.</param>
        /// <param name="hashAlgorithm">The hash algorithm.</param>
        /// <param name="passwordIterations">The password iterations.</param>
        /// <param name="initVector">The init vector.</param>
        /// <param name="keySize">Size of the key.</param>
        /// <returns>Decrypted Password</returns>
        private static string Decrypt(string cipherText, string passPhrase, string saltValue, string hashAlgorithm, int passwordIterations, string initVector, int keySize)
        {
            byte[] bytes = Encoding.ASCII.GetBytes(initVector);
            byte[] rgbSalt = Encoding.ASCII.GetBytes(saltValue);
            byte[] buffer = Convert.FromBase64String(cipherText);
            byte[] rgbKey = new PasswordDeriveBytes(passPhrase, rgbSalt, hashAlgorithm, passwordIterations).GetBytes((int)Math.Round((double)(((double)keySize) / 8.0)));
            RijndaelManaged managed = new RijndaelManaged();
            managed.Mode = CipherMode.CBC;
            ICryptoTransform transform = managed.CreateDecryptor(rgbKey, bytes);
            MemoryStream stream2 = new MemoryStream(buffer);
            CryptoStream stream = new CryptoStream(stream2, transform, CryptoStreamMode.Read);
            byte[] buffer4 = new byte[buffer.Length + 1];
            int count = stream.Read(buffer4, 0, buffer4.Length);
            stream2.Close();
            stream.Close();
            return Encoding.UTF8.GetString(buffer4, 0, count);
        }
        #endregion


        #region Encrypt
        /// <summary>
        /// Encrypts the specified plain text.
        /// </summary>
        /// <param name="plainText">The plain text.</param>
        /// <returns>Encrypted Password</returns>
        public string Encrypt(string plainText)
        {
            return Encrypt(plainText, PASSWORDKEY);
        }
        #endregion

        #region Encrypt
        /// <summary>
        /// Encrypts the specified plain text.
        /// </summary>
        /// <param name="plainText">The plain text.</param>
        /// <param name="passPhrase">The pass phrase.</param>
        /// <returns>Encrypted Password</returns>
        private string Encrypt(string plainText, string passPhrase)
        {
            return Encrypt(plainText, passPhrase + PASSPHRASE, passPhrase + PASSSALT, "SHA1", 2, INTVECTOR, 0x100);
        }
        #endregion

        #region Encrypt
        /// <summary>
        /// Encrypts the specified plain text.
        /// </summary>
        /// <param name="plainText">The plain text.</param>
        /// <param name="passPhrase">The pass phrase.</param>
        /// <param name="saltValue">The salt value.</param>
        /// <param name="hashAlgorithm">The hash algorithm.</param>
        /// <param name="passwordIterations">The password iterations.</param>
        /// <param name="initVector">The init vector.</param>
        /// <param name="keySize">Size of the key.</param>
        /// <returns>
        /// Encrypted Password
        /// </returns>
        private string Encrypt(string plainText, string passPhrase, string saltValue, string hashAlgorithm, int passwordIterations, string initVector, int keySize)
        {
            byte[] bytes = Encoding.ASCII.GetBytes(initVector);
            byte[] rgbSalt = Encoding.ASCII.GetBytes(saltValue);
            byte[] buffer4 = Encoding.UTF8.GetBytes(plainText);
            byte[] rgbKey = new PasswordDeriveBytes(passPhrase, rgbSalt, hashAlgorithm, passwordIterations).GetBytes((int)Math.Round((double)(((double)keySize) / 8.0)));
            RijndaelManaged managed = new RijndaelManaged();
            managed.Mode = CipherMode.CBC;
            ICryptoTransform transform = managed.CreateEncryptor(rgbKey, bytes);
            MemoryStream stream2 = new MemoryStream();
            CryptoStream stream = new CryptoStream(stream2, transform, CryptoStreamMode.Write);
            stream.Write(buffer4, 0, buffer4.Length);
            stream.FlushFinalBlock();
            byte[] inArray = stream2.ToArray();
            stream2.Close();
            stream.Close();
            return Convert.ToBase64String(inArray);
        }
        #endregion
    }
}