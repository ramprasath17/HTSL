using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BudgetManager.Infrastructure.Contracts
{
    public interface IMailer
    {
        string ToAddress {get; set;}
        string FromAddress { get; set; }
        string Subject { get; set; }
        string Message { get; set; }
        string DisplayName { get; set; }
        bool IsBodyHtml { get; set; }
        string Bcc { get; set; }
        string Cc { get; set; }
        string Body { get; set; }
        bool SendMail();

        void SetMailData(string toAddress, string subject, string messageBody, bool isHtmlMessage, bool isAdminMail = false);

        void SetMailData(string fromAddress, string toAddress, string subject, string messageBody, bool isHtmlMessage, bool isAdminMail = false);

        string MailContentBuilder(string mailBody, params string[] mailPlaceHolderData);
        
    }
}
