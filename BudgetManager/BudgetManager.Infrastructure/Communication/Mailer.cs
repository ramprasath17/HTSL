namespace BudgetManager.Infrastructure.Communication
{
    using System;
    using System.Diagnostics;
    using System.Net.Mail;
    using BudgetManager.Infrastructure.Contracts;
    using BudgetManager.Infrastructure.Helpers.ErrorMessage;
    using BudgetManager.Security.EncDec;

    public class Mailer : IMailer
    {
        private readonly IDataMorpher dataMorpher;
        public Mailer(IDataMorpher dataMorpher)
        {
            this.dataMorpher = dataMorpher;
        }

        #region Variable declaration
        public static string _toAddress = string.Empty;
        public static string _fromAddress = string.Empty;
        public static string _displayName = string.Empty;
        public static string _subject = string.Empty;
        public static string _message = string.Empty;
        public static bool _isBodyHtml = false;
        public static string _bcc = string.Empty;
        public static string _cc = string.Empty;
        public static string _body = string.Empty;
        #endregion

        #region Auto-Implemented properties
        public string ToAddress
        {
            get { return _toAddress; }
            set { _toAddress = value; }
        }
        public string FromAddress
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_fromAddress))
                {
                    return "\"Budget Manager\" <" + System.Configuration.ConfigurationManager.AppSettings["MaskFromAddress"].ToString() + ">";
                }
                return "\"Budget Manager\" <" + _fromAddress + ">";
            }
            set { _fromAddress = value; }
        }
        public string Subject
        {
            get { return _subject; }
            set { _subject = value; }
        }
        public string Message
        {
            get { return _message; }
            set { _message = value; }
        }
        public string DisplayName
        {
            get { return _displayName; }
            set { _displayName = value; }
        }
        public bool IsBodyHtml
        {
            get { return _isBodyHtml; }
            set { _isBodyHtml = value; }
        }
        public string Bcc
        {
            get { return _bcc; }
            set { _bcc = value; }
        }
        public string Cc
        {
            get { return _cc; }
            set { _cc = value; }
        }
        public string Body
        {
            get { return _body; }
            set { _body = value; }
        }

        /// <summary>
        /// To get the host port
        /// </summary>
        private static int HostPort
        {
            get
            {
                var _hostPort = System.Configuration.ConfigurationManager.AppSettings["HostPort"];
                try
                {
                    if (string.IsNullOrWhiteSpace(_hostPort))
                    {
                        return 0;
                    }
                    else
                    {
                        return Convert.ToInt16(System.Configuration.ConfigurationManager.AppSettings["HostPort"]);
                    }
                }
                catch
                {
                    return 0;
                }
            }
        }

        /// <summary>
        /// SMTP server name
        /// </summary>
        private static string SmtpServer
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["SmtpServer"].ToString();
            }
        }

        /// <summary>
        /// Smtp email id
        /// </summary>
        private static string SmtpLogInEmail
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["FromAddress"].ToString();
            }
        }

        /// <summary>
        /// Password for the default account
        /// </summary>
        private string Password
        {
            get
            {
                return dataMorpher.Decrypt(System.Configuration.ConfigurationManager.AppSettings["Password"].ToString());
            }
        }

        /// <summary>
        /// Is Mail has SSL Enabled
        /// </summary>
        private bool IsMailHasSSLEnabled
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["IsEnableSsl"].Equals("true") ? true : false;
            }
        }

        /// <summary>
        /// To check whether the mail sent from here are from admin related to keep the email id same for admin purpose
        /// </summary>
        private bool IsAdminMail { get; set; }
        #endregion

        #region Mailing Method
        /// <summary>
        /// To send a mail
        /// </summary>
        public bool SendMail()
        {
            try
            {
                MailMessage mailMessage = new MailMessage(FromAddress, ToAddress, Subject, Message);
                MailAddress mailToAddress = new MailAddress(ToAddress, DisplayName);
                //MailAddress mailFromAdress = new MailAddress(FromAddress, "");
                mailMessage.IsBodyHtml = IsBodyHtml;
                mailMessage.Subject = Subject;
                mailMessage.Body = Message;
                SmtpClient SmtpSettings = new SmtpClient(SmtpServer, HostPort);
                SmtpSettings.UseDefaultCredentials = false;
                SmtpSettings.EnableSsl = IsMailHasSSLEnabled;
                SmtpSettings.Credentials = new System.Net.NetworkCredential(SmtpLogInEmail, Password);
                SmtpSettings.Send(mailMessage);
                return true;
            }
            catch (Exception exception)
            {
                ErrorMessageHelper.SetExceptionMessage(exception);
                return false;
            }
        }

        /// <summary>
        /// To set the data required for mailing
        /// </summary>
        /// <param name="toAddress">To address</param>
        /// <param name="subject">Mail subject text</param>
        /// <param name="messageBody">Message Body</param>
        /// <param name="isHtmlMessage">Is the message is HTML formatted or not</param>
        public void SetMailData(string toAddress, string subject, string messageBody, bool isHtmlMessage, bool isAdminMail)
        {
            _toAddress = toAddress;
            _subject = subject;
            _message = messageBody;
            _isBodyHtml = isHtmlMessage;
            this.IsAdminMail = isAdminMail;
        }

        /// <summary>
        /// To set the data required for mailing
        /// </summary>
        /// <param name="fromAddress">From address</param>
        /// <param name="toAddress">To address</param>
        /// <param name="subject">Mail subject text</param>
        /// <param name="messageBody">Message Body</param>
        /// <param name="isHtmlMessage">Is the message is HTML formatted or not</param>
        public void SetMailData(string fromAddress, string toAddress, string subject, string messageBody, bool isHtmlMessage, bool isAdminMail)
        {
            _fromAddress = fromAddress;
            _toAddress = toAddress;
            _subject = subject;
            _message = messageBody;
            _isBodyHtml = isHtmlMessage;
            this.IsAdminMail = isAdminMail;
        }

        #endregion

        #region Mail Content Builder
        /// <summary>
        /// To set mail body contents
        /// </summary>
        /// <param name="userName">user name</param>
        /// <param name="hostName">host Name</param>
        /// <param name="urlAction">action url</param>
        /// <returns></returns>
        public string MailContentBuilder(string mailBody, params string[] mailPlaceHolderData)
        {
            return (string.Format(mailBody, mailPlaceHolderData));
        }
        #endregion

    }
}
