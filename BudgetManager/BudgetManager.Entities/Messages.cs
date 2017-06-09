namespace BudgetManager.Entities
{
    #region NameSpace Declaration
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.Web.Mvc;
    #endregion

    public static class Messages
    {
        /// <summary>
        /// Welcome message
        /// </summary>
        public const string welcomeString = "Hi {0}, {1}! Welcome to Budget Manager. ";        

        #region Log In Messages
        /// <summary>
        /// Sets the Log in error message
        /// </summary>
        public const string LogInError = "Username / password is incorrect";

        /// <summary>
        /// Sets the forgot password message link
        /// </summary>
        public const string LogInErrorWithForgotPassword = "We think you've forgotten your password, then try reset {0} your password.";

        #endregion

        #region Validations Format
        /// <summary>
        /// E-mail validation regular expression
        /// </summary>
        public const string EmailValidationFormat = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}";
        #endregion
        
        #region Email validation messages

        /// <summary>
        /// invalid email error message.
        /// </summary>
        public const string InvalidEmailErrorMessage = "Doesn't seems to be a valid email id.";

        /// <summary>
        /// Registered email address error message.
        /// </summary>
        public const string RegisteredEmailAddressErrorMessage = "Seems already some one registered with this email Id.";

        #endregion
        #region Registration
        /// <summary>
        /// Sets the form error message
        /// </summary>
        public const string ProfileDataFormError = "Please correct the errors in the registration form.";

        /// <summary>
        /// Display the error in registration failure
        /// </summary>
        public const string RegistrationError = "Our sincere apologies, there was an error in registering. Please try again!";

        /// <summary>
        /// Registration email subject 
        /// </summary>
        public const string RegistrationSubject = "E-mail verification from Budget Manager Team";

        /// <summary>
        /// Registration email body
        /// </summary>
        public const string RegistrationMessageBody = "Hi {0}, <br/><br/>We are very much pleased to have you for registering in our portal. We will help you to provide a nice working environment. Please follow the below link to verify your account, <br/><br/> {1}{2} <br/><br/> Thanks,<br/><br/>Budget Manager Team.";

        /// <summary>
        /// Email verification error message
        /// </summary>
        public const string EmailVerficationError = "Either you have already verfied your account or came here with an invalid verification ID. Please contact your administrator if you find the verification id is a valid one.";

        /// <summary>
        /// Email Verfication success message
        /// </summary>
        public const string EmailVerificationSuccess = "Your email has been successfully verified and you please continue logging in and access the application with your priviledges.";

        /// <summary>
        /// Error sending email message
        /// </summary>
        public const string ErrorSendingEmail = "Oop's there was an error sending an email for account verification, please try to register you account again.";

        /// <summary>
        /// Registration success message
        /// </summary>
        public const string RegistrationSuccess = "Your account has been successfully created and please confirm your account by verifying the link sent to your mail box you registered with us before logging in to the application.";

        /// <summary>
        /// Accept Invitation success message
        /// </summary>
        public const string AcceptInvitationSuccess = "Your account has been successfully accepted invitation and now you can add transactions to the user by whom you are invited.";
        #endregion

        #region Forgot Password
	
        /// <summary>
        /// Forgot password reset message
        /// </summary>
        public const string PasswordResetSuccess = "Your password has been successfully reset and sent to your email. Please verify from your mail.";

        /// <summary>
        /// Forgotten Password Email Subject
        /// </summary>
        public const string ForgottenPasswordEmailSubject = "Password Recovery - Budget Manager";

        /// <summary>
        /// Forgottten Passsword Email Body
        /// </summary>
        public const string ForgottenPasswordEmailBody = "Hi {0},<br/><br/>Your requested password is {1}.<br/><br/> If you are receiving this with no cause then please ignore it.<br/><br/>Thanks,<br/>Budget Manager Team.";

        /// <summary>
        /// Forgotten password link text
        /// </summary>
        public const string ForgottenPasswordLinkText = "Recover the lost/forgotten password";
        
        /// <summary>
        /// Forgot password reset success message
        /// </summary>
        public const string ForgottenPasswordResetSucess = "Password sent to your e-mail address. Please check your inbox.";

        /// <summary>
        ///  Forgot password reset failure message
        /// </summary>
        public const string ForgottenPasswordResetFailure = "Error in sending mail please review the error below.";

        /// <summary>
        /// user email not exists 
        /// </summary>
        public const string UserEmailNotExists = "Seems like this email id is not registered with us.";

        /// <summary>
        /// Error in recovering password
        /// </summary>
        public const string ErrorRecoverPassword = "Seems like there is an error in recovering your password.Please contact your administrator.";

        public const string UserpermissionSaveNote = "The settings apart from permissions, will apply from your next new session.";

        /// <summary>
        /// Invite Friend To Company Email Body                                               
        /// </summary>
        public const string InviteFriendToCompanyEmailBody = "Hi {0},<br/><br/> Please follow the below link to accept the invitation. {1}{2}<br/><br/>Thanks,<br/>{3}";

        /// <summary>
        /// Update Success Information
        /// </summary>
        public const string UpdateSuccessInformation = "Record successfully updated!";
        #endregion
    }
}
