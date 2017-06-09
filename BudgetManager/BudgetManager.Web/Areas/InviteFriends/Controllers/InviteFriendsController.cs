namespace BudgetManager.Web.Areas.InviteFriends.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Web.Mvc;
    using BudgetManager.Entities;
    using BudgetManager.Entities.NamedConstants;
    using BudgetManager.Infrastructure.Contracts;
    using BudgetManager.Infrastructure.Helpers;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Security.EncDec;
    using BudgetManager.Web.ActionFilters;
    using BudgetManager.Web.Areas.InviteFriends.Models;
    using BudgetManager.Security.UserSessionHandler;
    using BudgetManager.Web.Attributes;
    using BudgetManager.Helpers;

    [PermissionActionFilter]
    [GroupMenuTitle(Title = "Invitations")]
    public class InviteFriendsController : Controller
    {
        /// <summary>
        /// Friend Invitation Repository
        /// </summary>
        private readonly IFriendInvitationRepository iFriendInvitationRepository;

        /// <summary>
        /// Mailer
        /// </summary>
        public readonly IMailer mailer;

        /// <summary>
        /// Data Morph factory
        /// </summary>
        public readonly IDataMorpher encDecryption;

        /// <summary>
        /// User session
        /// </summary>
        private readonly IUserSession userSession;

        /// <summary>
        /// Initialises new instance of <see cref="InviteFriendsController"></see>
        /// </summary>
        /// <param name="iFriendInvitationRepository">Friend Repository</param>
        /// <param name="mailer">Mailer</param>
        /// <param name="encDecryption">Encrypt and Decryptor</param>
        public InviteFriendsController(IFriendInvitationRepository iFriendInvitationRepository, IMailer mailer, IDataMorpher encDecryption, IUserSession userSession)
        {
            this.iFriendInvitationRepository = iFriendInvitationRepository;
            this.mailer = mailer;
            this.encDecryption = encDecryption;
            this.userSession = userSession;
        }

        /// <summary>
        /// Gets or sets Session User Id
        /// </summary>
        private string SessionUserId
        {
            get
            {
                return Convert.ToString(Session["userId"]);
            }
        }

        /// <summary>
        /// Invite a friend to company
        /// </summary>
        /// <returns></returns>
        [LinkFilter(LinkText = "Invite a friend")]
        [HttpGet]
        public ActionResult InviteAFriend()
        {
            return View("InviteAFriend");
        }

        /// <summary>
        /// Invites a friend
        /// </summary>
        /// <param name="emailId"></param>
        /// <param name="username"></param>
        /// <param name="displayName"></param>
        /// <param name="companyId"></param>
        /// <returns>View</returns>        
        [HttpPost]
        public JsonResult InviteAFriend(string userId)
        {
            DataSet userDetailSet = iFriendInvitationRepository.GetUserDetails(userId);
            bool invitationStatus = false;
            if (userDetailSet.Tables.Count > 0)
            {
                UserDetailsViewModel userDetailsViewModel = userDetailSet.Tables[0].AsEnumerable().Select(result => new UserDetailsViewModel
                {
                    UserId = result.Field<string>("UserId"),
                    UserName = result.Field<string>("UserName"),
                    EmailId = result.Field<string>("EmailId"),
                    CompanyId = result.Field<int>("CompanyId"),
                    CompanyName = result.Field<string>("CompanyName")
                }).FirstOrDefault();
                var hostName = Resources.GetHostName(HttpContext.Request.Url.ToString());
                string mailContent = mailer.MailContentBuilder(Messages.InviteFriendToCompanyEmailBody,
                    new string[] { userDetailsViewModel.UserName, 
                hostName, Url.Action("AcceptInvitation", "InviteFriends", 
                new { area = "InviteFriends", userName = userDetailsViewModel.UserId, verfid = encDecryption.Encrypt(Convert.ToString(userSession.CompanyId))}), 
                User.Identity.Name });
                mailer.SetMailData(userDetailsViewModel.EmailId, string.Format("Invitation from {0}", User.Identity.Name), mailContent, true, true);
                invitationStatus = mailer.SendMail() ? iFriendInvitationRepository.LogInvitation(userId, SessionUserId, userDetailsViewModel.CompanyId.GetDefaultValueIfNull<string>()) : false ;
            }

            return Json(invitationStatus, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Accepts a friend invitation
        /// </summary>
        /// <param name="userName">User Name</param>
        /// <param name="companyId">CompanyID</param>
        /// <returns>View</returns>
        [PermissionActionFilter(false)]
        public ActionResult AcceptInvitation(string userName, string verfid)
        {
            iFriendInvitationRepository.AcceptInvitation(userName, TypeConversionHelper.GetDefaultValueIfNull<long>(encDecryption.Decrypt(verfid)), AttributeExtensions.GetCategoryAttribute(FriendInvitationType.JoinACompany));
            TempData["statusMessage"] = Messages.AcceptInvitationSuccess;
            return RedirectToRoute(new { area = string.Empty, controller = "Account", action = "Messager"});
        }

        /// <summary>
        /// Get Users by User Name
        /// </summary>
        /// <param name="userName">User Name</param>
        /// <returns></returns>
        [PermissionActionFilter(false)]
        public PartialViewResult GetUsers(string userName)
        {
            DataSet userList = iFriendInvitationRepository.GetUsers(userName, SessionUserId);
            List<UserSearchResultViewModel> userSearchResultViewModel = GetUserDetails(userList);
            return PartialView("_ShowUserListForFriendInvitation", userSearchResultViewModel);
        }

        /// <summary>
        /// Get User Details
        /// </summary>
        /// <param name="userDetailResultSet">User Details Result Set</param>
        /// <returns>List of Users with details</returns>
        internal static List<UserSearchResultViewModel> GetUserDetails(DataSet userDetailResultSet)
        {
            if (userDetailResultSet == null || userDetailResultSet.Tables.Count == 0 || userDetailResultSet.Tables[0].Rows.Count == 0)
            {
                return new List<UserSearchResultViewModel>();
            }

            return userDetailResultSet.Tables[0].AsEnumerable().Select(userResultList => new UserSearchResultViewModel
            {
                UserId = userResultList.Field<string>("userId"),
                UserName = userResultList.Field<string>("username"),
                CompanyName = userResultList.Field<string>("CompanyName"),
                IsActive = userResultList.Field<bool>("IsActive"),
                InvitationStatus = userResultList.Field<int?>("InviteStatus"),
                ShowToInvite = userResultList.Field<bool>("ShowToInvite"),
            }).ToList();
        }
    }
}
