using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcApplication1.Models
{
    public class GlobalConstants
    {
        #region Enumerations
        public enum Status
        {
            Open = 1,
            ToBeScheduled = 2,
            Scheduled = 3,
            ReScheduled = 4,
            Unabletocontact = 5,
            Cancelled = 6,
            Completed = 7,
            FillFeedback = 8,
            SubmitFeedback = 9,
            CorrectionNeeded = 10,
            ReSubmitFeedback = 11,
            ReportSent = 12
        };

        public enum UserType
        {
            Administrator = 1,
            CoOrdinator = 2,
            StaffingFirm = 3,
            StaffingFirmUsers = 4,
            SubectMatterExpert = 5
        };
        #endregion

        #region Splash Screen Stored Procedures

        public const String RegisterStaffingFirm = "spRegisterStaffingFirm";
        //public const String GetTechSkillSet = "sp_GetTechSkillSet";
        public const String RegisterSME = "sp_RegisterSME";

        #endregion

        #region Stored Procedures
        public const string GET_COUNTRIES = "sp_GetCountries";
        public const string GET_STATES = "sp_GetState";
        public const string GET_CITIES = "sp_GetCity";
        public const string GET_INDUSTRIES = "sp_GetIndustries";
        public const string GET_NEWSKILLS = "sp_GetNewSkills";
        public const string POST_SFSTEP1 = "spRegisterStaffingFirmStep1";
        //public const string POST_SFSTEP2 = "spADDFirmSkillset";
        //public const string POST_SFSTEP2 = "spADDSFFirmSkillset";
        public const string POST_SFSTEP2 = "spADDSFSkillset";
        public const string UPDATE_SFSTEP3 = "sp_updatestaffingSocial";
        public const String GetTechSkillSet = "sp_GetTechSkillSet";
        public const String REGISTER_SME_STEP1 = "spRegisterSMEstep1";
        public const string REGISTER_SME_STEP2 = "spADDSMESkillset";
        public const String REGISTER_SME_FinalStep = "spSMEFInalStep";
        public const String ACTIVATE_STAFFING_FIRM = "spActivateStaffingFirm";
        public const String ACTIVATE_STAFFING_FIRMUSER = "spActivateSFUser";
        public const String ACTIVATE_SME = "spActivateSME";
        public const String UPDATE_AGR_STATUS = "spUpdateAgreementStatus";
        //public const String POST_JD = "spJD";
        public const String POST_JD = "spADDJDs";
        public const String GET_TEMPLATE_CONTENT = "sp_GetTemplateContents";
        public const String UPLOAD_RESUMES = "sp_UploadResumes";
        public const String GET_RESUMES = "sp_GetResumes";
        public const string GET_TEMPLATES = "sp_GroupTemplate";
        public const string SEARCH_TEMPLATES = "sp_Searchtemplates";
        public const string LOAD_CUSTDEPT = "sp_GetCustDept";
        public const string LOAD_SFSKILLS_LIST = "sp_SFProfile_Test";
        public const string LOAD_SMESKILLS_LIST = "sp_BindSMESkills";
        public const string LOAD_EDUCATION_LIST = "sp_LoadEducationList";
        public const string LOAD_SFPROFILE = "sp_SFProfile";
        public const string LOAD_SFUserPROFILE = "sp_SFUserProfileImage";
        public const string LOAD_SFNotify = "sp_SFNotify";
        public const string LOAD_SMENotify = "sp_SMENotify";
        public const string LOAD_AdminNotify = "sp_AdminNotify";
        public const string UpdateNotify_Status = "sp_UpdateNotify";
        public const string LOAD_CANDIDATEINFO = "sp_GetCandidateInfo";
        public const string LOAD_SMEPROFILE = "sp_SMEProfile";
        public const string LOAD_SFUSERS = "sp_Getreportingtousers";
        public const string UPDATE_SFSTEP1 = "sp_UpdateSFstep1";
        public const string UPDATE_SMESTEP1 = "sp_UpdateSMEstep1";
        public const string LOAD_JDANDPLAN = "sp_GetJDandPlan";
        public const string LOAD_SMEFinalStep = "sp_EditSMEFinalstep";
        public const string LOAD_SMEEducation = "sp_EditSMEEducation";
        public const string LOAD_SMEExperience = "sp_EditSMEExperience ";
        public const string LOAD_SMECertification = "sp_EditSMECertification";
        public const string LOAD_SMEAward = "sp_EditSMEAwards";
        public const string POST_AVAILABILTY = "sp_Addavailabilty";
        public const string POST_AVAILABILTY_WEEKLY = "sp_AddAvailabilityWeekly";
        public const string LOAD_SKILLS_CONTENT = "sp_Loadskillscontent";
        public const string POST_NEW_CUST_DEPT = "sp_ADDNewCust_Dept";
        public const string GROUP_TEMPLATES = "sp_GroupTemplateList";
        public const string GET_JDTEMPLATE_CONTENT = "sp_GetJDTemplateContents";
        public const string SEARCH_MANAGETEMPLATES = "sp_Search_ManageTemplate";
        public const string POST_FEEDBACK = "sp_PostFeedback";
        public const string LOAD_RESUMES = "sp_Load_Resumelist";
        public const string LOAD_RESUMESPATH = "sp_Load_ResumePathlist";
        public const string DELETE_RESUMES = "sp_DeleteResumes";
        public const string SUBMIT_RESUMES = "sp_SubmitResumes";
        public const string CHECK_SKILLS = "sp_CheckSkills";
        public const string CHECK_IF_SME_ACTIVATED_ALREADY = "sp_CheckSMEActivatedAlready";
        public const string UPDATEADMINNOTIFICATION_READ = "sp_Notifications_as_read";
        

        public const string SAVE_EMAIL_CONFIGURATION_DETAILS = "sp_SaveemailConfiguration";
        public const string SAVE_SUBSCRIPTION_CONFIGURATION_DETAILS = "sp_savesubscription";
        public const string SAVE_NOOFUSERS_CONFIGURATION_DETAILS = "sp_SaveNumberofUsers";
        public const string SAVE_TIMEZONE_CONFIGURATION_DETAILS = "sp_SaveTimeZoneDetails";
        public const string GET_CONFIGURATION_DETAILS = "sp_GetConfigurationDetails";
        public const string SAVE_Theme_COLOR = "sp_SaveThemeColor";
        public const string GET_Theme_COLOR = "sp_GetThemeColor";
        public const string SAVE_SFTIME_ZONE = "sp_SaveSFTimeZone";
        public const string SAVE_EMAIL_ALERT = "sp_SaveEmailAlert";
        public const string GET_SFCONFIGUARTION_DETAILS = "sp_GetSFConfigurationDetails";


        public const String GET_ADMINCOORDINATOR = "sp_GetAdminCoordinator";
        public const String GET_JOBPROFILE = "sp_SearchPageJobProfile";
        public const String GET_STAFFINRFIRMLIST = "sp_SearchPageStaffingFirmList";
        public const String GET_CANDIDATELIST = "sp_SearchPageCandidateList";
        public const String GET_SMELIST = "sp_SearchPageSMEList";
        public const String GET_StaffingFirm = "sp_GETStaffingFirm";
        public const String GET_UserRole = "sp_UserRole";
        public const String GET_STAFFINRFIRMCMPNAME = "sp_GETStaffingFirmcmpName";

        public const String GET_PHProject = "sp_GETPHProjectName";
        public const String GET_Chart_POC = "SP_PHT_POC_Project";
        public const String ADDSTAFFINGFIRMUSER = "sp_ADDStaffingFirmUser";
        public const String UPDATE_CANDIDATEINFO = "sp_UpdateCandidateInfo";
        public const String ADDSME = "sp_ADDSME";
        public const String UpdateSTAFFINGFIRM = "sp_UpdateStaffingFirm";
        public const String UpdateResumeStatus = "sp_UpdateResumeStatus";
        public const String UpdateRecruiterNotes = "sp_UpdateRecruiterNotes";
        public const String UpdateJOBPROFILESTATUS = "sp_UpdateJobProfileStatus";
        public const String UpdateSMEStatus = "sp_UpdateSMEStatus";
        public const String UpdateSMEPasswordmailstatus = "sp_UpdateSMEmailstatus";
        public const String UpdateSMERegStatus = "sp_UpdateSMERegStatus";
        public const String UpdateSFRegStatus = "sp_UpdateSFRegStatus";
        public const String UpdateResume = "sp_UpdateScheduleResume";
        public const String UpdateAssignedTo = "sp_UpdateAssignedTo";
        public const String UpdateMeetingLink = "sp_UpdateMeetingLink";
        public const String GETMeetingLink = "sp_GetTemplateHTML";
        public const String WEBEXEMAIL = "sp_WebexEmailList";
        public const String UpdateSTAFFINGFIRMUSERSTATUS = "sp_UpdateStaffingFirmUser";
        public const String UpdateSMEPassword = "sp_UpdateSMEPassword";
        public const String UpdateNewPassword = "sp_UpdateNewPassword";
        public const String UpdateSTAFFINGFIRMPASSWORD = "sp_UpdateStaffingFirmPassword";
        public const String UpdateSTAFFINGFIRMUSERPASSWORD = "sp_UpdateStaffingFirmUserPassword";
        public const String UpdateSTAFFINGFIRMEMAILALERT = "sp_UpdateStaffingfirmEmailalert";
        public const String UpdateSTAFFINGFIRMBYPASSCCPAYMENT = "sp_UpdateStaffingfirmByPassCCPayment";
        public const String UpdatePOST_JD = "spUPDATEJDs";
        public const String UpdateCompanyLogoImage = "sp_UpdateCompanyLogoImage";
        public const String UpdateSMEImage = "sp_UpdateSMEImage";
        public const string UpdateSMETraining_Status = "sp_UpdateTrainingStatus";
        public const string LOAD_MANAGEJOBPROFILEPROFILE = "sp_ManageJobProfile";
        public const string SAVE_SMETHEME_COLOR = "sp_SavesmeThemeColor";
        public const string GET_SMETheme_COLOR = "sp_GetSMEThemeColor";
        public const string SAVE_SMETIME_ZONE = "sp_SaveSMETimeZone";
        public const string GET_SMECONFIGUARTION_DETAILS = "sp_GetSMEConfigurationDetails";
        public const string SAVE_NEW_PLAN = "sp_SaveNewPlan";
        public const string SAVE_CUSTOMERS_FOR_CUSTOM_PLAN = "sp_SaveCustomersForCustomPlan";
        public const string GET_SUBSCRIPTIONPLAN_LIST = "sp_GetSubscriptionPlanList";
        public const string ForgotPswd = "sp_ForgotPswd";
        public const string UPDATESTATUS = "sp_UpdateStatus";
        
        public const string GET_PLAN_PRICING = "sp_GetPlanPricing";
        public const string GET_PLAN_NAMES = "sp_GetPlanNames";
        public const string GET_PLAN_DETAILS_BYID = "sp_GetPlanDetailsbyID";
        public const string SAVE_PRICING_TO_STAFFINGFIRM = "sp_SavePricingtoStaffingFirm";
        public const string GET_SF_TIMEZONE = "sp_GetSFTimeZone";
        public const string CHECK_IF_PLAN_NAME_EXISTS = "sp_CheckIfPlanNameExists";
        public const string GET_AVAILABLE_INTERVIEWS = "sp_GetAvailableInterviews";
        public const string SEARCH_SUBSCRIPTION_PLAN = "sp_SearchSubscriptionplan";
        public const string SEARCH_SUBSCRIBED_PLAN = "sp_SearchSubscribedplan";
        public const string SEARCH_ADMIN_NOTIFYLIST = "sp_SearchNotification";
        public const string SEARCH_SF_NOTIFYLIST = "sp_SearchSFNotification";
        public const string SEARCH_SME_NOTIFYLIST = "sp_SearchSMENotification";
        public const string UPDATE_ACTIVATE_OR_DEACTIVATE_PLAN = "sp_UpdateAmountReceived";
        public const string GET_INTERVIEWS_BOUGHT = "sp_GettotalInterviewsBought";
        public const string GET_UPCOMING_INTERVIEWS_LIST = "sp_Getupcominginterviews";
        public const string GET_SME_UPCOMING_INTERVIEWS_LIST = "sp_GetSMEupcominginterviews";
        public const string GET_CANDIDATESMELIST = "sp_CandidateSMEList";
        public const string GET_CALENDARSMELIST = "sp_CalendarSMEList";
        public const String UpdateManage_JD = "sp_Update_ManageJDs";
        public const string GET_JOB_PROFILE_DETAILS = "sp_GetJobprofileDetails";
        public const string GET_JOB_PROFILE_FEEDBACK = "sp_GetJobprofileDetails_Feedback";
        public const string GET_FEEDBACK_RATINGS = "sp_LoadFeedbackRatings";
        public const string GET_COMPLETED_INTERVIEWS_LIST = "sp_GetSFCompletedInterviews";
        public const string GET_SME_COMPLETED_INTERVIEWS_LIST = "sp_GetSMECompletedInterviews";
        public const string GET_FEEDBACK_LIST = "sp_GetFeedBack";
        public const string GET_LOGINSTATUS = "sp_checkloginstatus";
        public const string GET_ALL_SF_INTERVIEWS = "sp_GetSFAllInterviews";
        public const string GET_SFNotifyINTERVIEWS = "sp_SFNotifyInterviews_view";
        public const string GET_SMENotifyINTERVIEWS = "sp_SMENotifyInterviews_view";
        public const string GET_ALL_SME_INTERVIEWS = "sp_GetSMEAllInterviews";
        public const string CHECK_USER_LIMIT = "sp_CheckUserLimit";
        public const string GET_MAXIMUM_NO_OF_SF_USERS = "sp_GetMaximumNumberofUsers";
        public const string GET_SMEAVAILABILITY_LIST = "sp_Availabilitylist";
        public const string GET_SEARCHAVAILABILITY_LIST = "sp_Search_Availabilitylist";
        public const string GET_SMETASK_LIST = "sp_GetAvailabilityTask";
        public const string REMOVE_RECURRENCE = "sp_RemoveReccurence";
        public const string GET_RESUME_DETAILS = "sp_Get_ResumeDetails";
        public const string GET_AGR_DETAILS = "sp_Get_AgrDetails";
        public const String GET_CUSTOMTEXT = "sp_GetCustomText";
        public const String GET_VIDEO_DETAILS = "sp_GetVideoDetails";

        public const string GET_EARNINGS_LIST = "sp_GetSMEAllEarnings";
        //public const string GET_EARNINGS_LIST = "sp_GetSMEAllEarningsNew";
        public const string GET_SME_BY_ID = "sp_GetSMEInfoById";
        public const string RELEASE_PAYMENT = "sp_ReleasePayment";
        public const string PaymentHistoryPending = "sp_PaymentHistoryPending";
        public const string PaymentHistoryReleased = "sp_PaymentHistoryReleased";
 
        public const string UPDATE_SCORING_MODEL = "sp_UpdateScoringModel";
        public const string GET_RANKS = "sp_GetRankValues";
        public const string GET_SKILLS_WEIGHTAGE = "sp_GetSkillsWeightage";

        public const string GetSMEPaypalDetailsForResumes = "sp_GetSMEPaypalDetailsForResumes";

        public const string GET_IMAGE_PATH = "sp_GetImagePath";
        public const string INSERT_OR_UPDATE_VIDEO = "sp_InsertUpdateVideo";
        
        
        public const string UpdatePaymentStatus = "sp_UpdatePaymentStatus";
        public const string AddPaypalPaymentDetails = "sp_AddPaypalPaymentDetails";
        public const string GET_VIDEO_PATH = "sp_GetVideoPath";
        public const string SAVE_MEETING_LINK = "sp_savevideolink";
        public const string GET_JD_RANKS = "sp_GetJDRankValues";
 
        public const string NoProfileOrLogo = "sp_NoProfileOrLogo";
        public const string GET_ALL_CUSTOMERS = "sp_GetAllCustomers";
        public const string CHECK_BYPASSCCPAYMENT = "sp_CheckBypassCCPayment";
        
        #endregion

        #region Captcha Constants

        //public const String CAPTCHA_KEY = "6Le6iQcTAAAAAIlXh-uwiakVDbWxWDWBAIMWvhUz";
        //uat.intaase.com
        //public const String CAPTCHA_KEY = "6Le6iQcTAAAAAIlXh-uwiakVDbWxWDWBAIMWvhUz";
        //www.intaase.com
        public const String CAPTCHA_KEY = "6Lcbcx4TAAAAAKZxX7tpunbMh2x-0M1yKgVst_Af";
        
        public const String CAPTCHA_WARNING = "Please solve captcha";

        #endregion

        #region Message Constants

        //public const String SF_REGISTRATION_SUCCESS = "Your information is received and Intaase sales team will contact you shortly.";
        public const String SF_REGISTRATION_SUCCESS = "Your information is received and an activation link has been sent to your registered email.";
        public const String SF_REGISTRATION_SUCCESS_SF = "New Customer added successfully and an activation link has been sent to  ";
        public const String SF_REGISTRATION_SUCCESS_SME = "New SME added successfully and an activation link has been sent to  ";
        public const String SF_REGISTRATION_FORGOTPSWD = "Your Email and Password is send to your registered email.";
        public const String SF_ForgotPswd_Failure = "Email Id does not exist. Please try with registered email id.";
        public const String SF_REGISTRATION_Failure = "Email id already exists.Please try with a different email id.";
        public const String SF_REGISTRATION_CMPNameFailure = "Company Name already exist. Please try with different Company Name.";
        public const String PROBLEM_ENCOUNTERS = "Could not process the request now. Please try again later.";
        public const String LoginExpire = "Session Expired. Please try again later.";
        public const String FileChecking = "Sorry, file does not exists. Please contact administrator.";
        public const String AdminFileChecking = "Sorry, file does not exists.";
        public const String SUCCESS_MESSAGE = "Success";
        public const String SFUSER_SUCCESS_MESSAGE = "Status has been saved successfully";
        public const String SF_UPDATION_SUCCESS = "Company details has been updated successfully";
        public const String SF_UPDATION_SUCCESS_SME = "Personal information has been updated successfully";
        public const String SF_SAVE_SUCCESS = "Profile has been saved successfully";
        public const String USER_LIMIT_EXCEEDED = "Maximum user limit reached. Please Inactive some users and try again.";
        public const String UPDATION_FAILED_MISSING_PAYPAL_ID = "Please enter out the paypal Id";

        #endregion

        #region Email Constants

        public const String EmailWelcomeSubject = "Welcome to Intaase";
        public const String EmailSFRegisteredSubject = "Staffing Firm registered to Intaase";
        public const String EmailSMERegisteredSubject = "Technical Expert registered to Intaase";
        public const String EmailSMESubject = "";
        public const String EmailCandidateSubject = "Technical Interview for ";
        public const String ChangePasswordMail = "Intaase: Password has been changed";
        public const String EmailIntaaseSalesName = "Intaase Sales";
        public const String EmailForgotPswd = "Intaase: Your Password";
        public const String QueryMailSubject = "Query Mail";
        public const String EmailIntaaseSalesID = "sales@intaase.org";
        public const String HelpcenterPath = @"~\Content\MailTemplate\HelpCenter.html";
        public const String SFRegTemplatePath = @"~\Content\MailTemplate\SFRegTemplate.html";
        public const String DownloadTemplate = @"~\Content\MailTemplate\DownloadForm.html";
        public const String DownloadFeedback = @"~\Content\MailTemplate\DownloadFeedbackForm.html";
        public const String SMETemplatePath = @"~\Content\MailTemplate\WebexSMETemplate.html";
        public const String SMETemplateOutsideUSPath = @"~\Content\MailTemplate\WebexSMETemplateOutsideUS.html";
        public const String DownloadResumePath = @"~\Files\";
        public const String DownloadAgrPath = @"~\Content\Agreement\SME\";

        public const String CANDIDATETemplatePath = @"~\Content\MailTemplate\WebexCandidateTemplate.html";
        public const String CHANGEPSWDTemplatePath = @"~\Content\MailTemplate\ChangePasswordTemplate.html";
        public const String CANDIDATETemplateOutsideUSPath = @"~\Content\MailTemplate\WebexCandidateTemplateOutsideUS.html";
        public const String WebExHelpUSDocTemplatePath = @"~\Content\MailTemplate\WebExHelpUSDoc_V1.0.docx";
        public const String WebExHelpOutsideUSDocTemplatePath = @"~\Content\MailTemplate\WebExHelpOutsideUsDoc_V1.0.docx";
        public const String SFRegTemplateToIntaasePath = @"~\Content\MailTemplate\SFRegTemplateToIntaase.html";
        public const String SMERegTemplatePath = @"~\Content\MailTemplate\SMERegTemplate.html";
        public const String SMERegTemplateToIntaasePath = @"~\Content\MailTemplate\SMERegTemplateToIntaase.html";
        public const String ActivationMailTemplate = @"~\Content\MailTemplate\ActivationTemplate.html";
        public const String ActivationMailTemplateSME = @"~\Content\MailTemplate\ActivationTemplateSME.html";
        public const String ForgotPswdActivationMailTemplate = @"~\Content\MailTemplate\ForgotPswdActivationTemplate.html";
        public const String SFLogoImagePath = @"..\Content\ProfilePicture\SF\";
        public const String SMEImagePath = @"..\Content\ProfilePicture\SME\";
        public const String ResumeSummaryImagePath = @"..\Content\ResumePicture\ResumeSummary\";
        public const String SmeActivationAgreementTemplate = @"~\Content\Agreement\template.html";

        public const String CompletedInterviewSubject = "Intaase: Completed  Interview for ";
        public const String FeedbackSubmitSubject = "Intaase: Feedback submitted for ";
        public const String FeedbackCorrectionSubject = "Intaase: Correction needed in Feedback on ";
        public const String FeedbackReSubmitSubject = "Intaase: Feedback Re-submitted for ";
        public const String ReportSentSubject = "Intaase: Report sent for ";
        public const String RecruiterNotesSubject = "Intaase: Recruiter Notes for ";
        public const String InterviewReScheduleSubject = "Intaase: Interview Rescheduled for ";
        public const String InterviewScheduleSubject = "Intaase: Interview Scheduled for ";
        public const String UnabletocontactSubject = "Intaase: Unable to contact ";

        public const String CompletedInterviewTemplate = @"~\Content\MailTemplate\CompletedInterviewTemplate.html";
        public const String FeedbackSubmitTemplate = @"~\Content\MailTemplate\FeedbackSubmitTemplate.html";
        public const String FeedbackReSubmitTemplate = @"~\Content\MailTemplate\FeedbackReSubmitTemplate.html";
        public const String FeedbackCorrectionTemplate = @"~\Content\MailTemplate\FeedbackCorrectionTemplate.html";
        public const String ReportSentTemplate = @"~\Content\MailTemplate\ReportSentTemplate.html";
        public const String RecruiterNotesTemplate = @"~\Content\MailTemplate\RecruiterNotesTemplate.html";
        public const String UnabletocontactTemplate = @"~\Content\MailTemplate\UnabletocontactTemplate.html";

        public const String PaypalSuccessFailedToUpdateOreSide = "Paypal Tranaction Updation Failed";
        public const string PaypalUpdationTemplate = @"\MailTemplate\PaypalUpdatationFailedTemplate.html";
        public const String PlanPurchasedTemplate = @"~\Content\MailTemplate\PlanPurchasedTemplate.html";

        //public const String EmailWelcomeSubject = "Welcome to Intaase";
        //public const String EmailSFRegisteredSubject = "Staffing Firm registered to Intaase";
        //public const String EmailSMERegisteredSubject = "Technical Expert registered to Intaase";
        //public const String EmailSMESubject = "";
        //public const String EmailCandidateSubject = "Technical Interview for Job Position ";
        //public const String EmailIntaaseSalesName = "Intaase Sales";
        //public const String EmailForgotPswd = "Intaase: Your Password";
        //public const String EmailIntaaseSalesID = "sales@intaase.org";
        //public const String EmailSMESubject = "";
        //public const String EmailCandidateSubject = "Technical Interview for Job Position ";
        //public const String SMETemplatePath = @"~\Content\MailTemplate\WebexSMEemplate.html";
        //public const String CANDIDATETemplatePath = @"~\Content\MailTemplate\WebexSMEemplate.html";
        //public const String SFRegTemplatePath = @"~\Content\MailTemplate\WebexCandidateemplate.html";
        //public const String SFRegTemplateToIntaasePath = @"~\Content\MailTemplate\SFRegTemplateToIntaase.html";
        //public const String SMERegTemplatePath = @"~\Content\MailTemplate\SMERegTemplate.html";
        //public const String SMERegTemplateToIntaasePath = @"~\Content\MailTemplate\SMERegTemplateToIntaase.html";
        //public const String ActivationMailTemplate = @"~\Content\MailTemplate\ActivationTemplate.html";
        //public const String ForgotPswdActivationMailTemplate = @"~\Content\MailTemplate\ForgotPswdActivationTemplate.html";

        #endregion

    }
}