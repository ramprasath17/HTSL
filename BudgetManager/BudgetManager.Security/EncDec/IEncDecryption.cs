namespace BudgetManager.Security.EncDec
{
    using System;

    public interface IEncDecryption : IDisposable
    {
        string EncryptData(string encrData);

        string DecrypText(string decrytText);
    }
}
