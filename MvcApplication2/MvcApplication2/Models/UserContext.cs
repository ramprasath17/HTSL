using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MvcApplication2.Models;
using System.Web.Security;
using System.Security.Principal;

namespace MvcApplication2.Models
{
    public class UserContext
    {
        #region Declarations
        private const String UserCookieKey = "IntaaseCookieInfo";
        #endregion

        #region Public Properties
       
        /// <summary>
        /// Gets the Return url from Query string
        /// </summary>
        public static String ReturnUrl
        {
            get
            {
                if (HttpContext.Current.Request.QueryString["ReturnUrl"] != null)
                {
                    return HttpContext.Current.Request.QueryString["ReturnUrl"].ToString();
                }
                else
                { return string.Empty; }
            }
        }
        /// <summary>
        /// Get User Cookie information
        /// </summary>
        public static HttpCookie UserCookieInfo
        {
            get { return HttpContext.Current.Request.Cookies["IntaaseCookieInfo"]; }
        }
        /// <summary>
        /// Redirect upon Login to the specified Return Url/Requested Url
        /// </summary>
        /// <param name="ReturnUrl"></param>
        public static void RedirectonLogin(string ReturnUrl)
        {
            if (String.IsNullOrEmpty(ReturnUrl))
                HttpContext.Current.Response.Redirect(HttpContext.Current.Request.Url.ToString());
            else
                HttpContext.Current.Response.Redirect(ReturnUrl);
        }
        /// <summary>
        /// Creating Persistent Cookie
        /// </summary>
        /// <param name="strUserEmail"></param>
        /// <param name="strUserPassword"></param>
        public static void CreatePersistentCookie(String strUserEmail, String strUserPassword)
        {
            //Creting a Cookie Object
            HttpCookie userInfoCookies = new HttpCookie(UserCookieKey);

            //Setting values inside it
            userInfoCookies["UserEmail"] = strUserEmail;
            userInfoCookies["UserPassword"] = strUserPassword;
            userInfoCookies["UserType"] = UserContext.CurrentUser.UserType.ToString();
            userInfoCookies["Role"] = UserContext.CurrentUser.UserRole.ToString();
            userInfoCookies["UserId"] = UserContext.CurrentUser.UserId.ToString();
            userInfoCookies["CompanyId"] = UserContext.CurrentUser.CompanyId.ToString();
            userInfoCookies["IsStaffingFirm"] = UserContext.CurrentUser.IsStaffingFirm.ToString();
            userInfoCookies["Termsandcondition"] = UserContext.CurrentUser.Termsandcondition.ToString();
            //userInfoCookies[]=UserContext.CurrentUser.


            //Adding Expire Time of cookies
            userInfoCookies.Expires = DateTime.Now.AddDays(5);

            //Adding cookies to current web response
            HttpContext.Current.Response.Cookies.Add(userInfoCookies);

            FormsAuthentication.SetAuthCookie(UserCookieKey, true);
        }
        /// <summary>
        /// Logout user session
        /// </summary>
        public static void LogoutSession()
        {
            HttpContext.Current.Response.Cookies.Clear();
            FormsAuthentication.SignOut();
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);
            if (UserContext.CurrentUser != null)
            {
                HttpContext.Current.Session.RemoveAll();

                HttpCookie userInfoCookies = new HttpCookie(UserCookieKey);
               

                //Adding Expire Time of cookies before existing cookies time
                userInfoCookies.Expires = DateTime.Now.AddDays(-1);
                //Adding cookies to current web response
                HttpContext.Current.Response.Cookies.Add(userInfoCookies);
            }
        }
        /// <summary>
        /// Gets the UserID from Querystring
        /// </summary>
        public static String QueryUserID
        {
            get
            {
                if (HttpContext.Current.Request.QueryString["userId"] != null)
                { return Convert.ToString(HttpContext.Current.Request.QueryString["userId"]); }
                else
                { return String.Empty; }
            }
        }
        #endregion

    }
}