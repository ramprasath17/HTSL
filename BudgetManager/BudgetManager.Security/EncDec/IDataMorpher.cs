
namespace BudgetManager.Security.EncDec
{
    using System;

    public interface IDataMorpher : IDisposable
    {
        string Encrypt(string strToEncrypt);

        string Decrypt(string strEncrypted);        
    }
}
