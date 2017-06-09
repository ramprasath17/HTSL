namespace BudgetManager.Security.EncDec
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Security.Cryptography;
    using System.IO;
    using BudgetManager.Security.EncDec;

   public class EncDecryption : IEncDecryption
    {
        private const string initVector = "21lS21jpsqj03w2r";
        private const int keysize = 256;       
        private const string phraseKey = "8udg3+M@nag36";

        public string EncryptData(string encrData )
        {
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
            byte[] encrDataBytes = Encoding.ASCII.GetBytes(encrData);

            PasswordDeriveBytes passwordBytes = new PasswordDeriveBytes(phraseKey, null);
            byte[] keyBytes = passwordBytes.GetBytes(keysize / 8);
            RijndaelManaged symmetricKey = new RijndaelManaged();
            //set cypher mode
            symmetricKey.Mode = CipherMode.CBC;
            //Crypto transform
            ICryptoTransform ICryptkeyBytes = symmetricKey.CreateEncryptor(keyBytes, initVectorBytes);
            MemoryStream memoryStream = new MemoryStream();
            CryptoStream cryptStream = new CryptoStream(memoryStream, ICryptkeyBytes , CryptoStreamMode.Write);
            cryptStream.Write(encrDataBytes, 0, encrDataBytes.Length);
            //Flush cryptostream
            cryptStream.FlushFinalBlock();
            byte[] cipherTextBytes = memoryStream.ToArray();
            //Flushing and closing memory stream
            memoryStream.Flush();
            memoryStream.Close();
            //Close crypto stream
            cryptStream.Close();
            return Convert.ToBase64String(cipherTextBytes);
        }

        public string DecrypText(string decrytText)
        {
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
            byte[] decryptDataBytes = Convert.FromBase64String(decrytText);
            byte[] plainTextBytes = null;
            int decrytByteCount  = 0;
            try
            {

                PasswordDeriveBytes passwordBytes = new PasswordDeriveBytes(phraseKey, null);
                byte[] keyBytes = passwordBytes.GetBytes(keysize / 8);
                RijndaelManaged symmetricKey = new RijndaelManaged();
                //set cypher mode
                symmetricKey.Mode = CipherMode.CBC;
                //Crypto transform
                ICryptoTransform ICryptkeyBytes = symmetricKey.CreateDecryptor(keyBytes, initVectorBytes);
                MemoryStream memoryStream = new MemoryStream(decryptDataBytes);
                CryptoStream cryptStream = new CryptoStream(memoryStream, ICryptkeyBytes, CryptoStreamMode.Read);
                plainTextBytes = new byte[decryptDataBytes.Length];
                decrytByteCount = cryptStream.Read(decryptDataBytes, 0, plainTextBytes.Length);
                //Closing memory stream                
                memoryStream.Close();
                //Close crypto stream
                cryptStream.Close();

            }
            catch (Exception ex)
            {
                string strEXcMes = ex.Message;
            }
            finally
            {
                
            }
            return Encoding.UTF8.GetString(plainTextBytes, 0, decrytByteCount);

        }

        public void Dispose()
        {
            GC.SuppressFinalize(true);
        }
    }
}
