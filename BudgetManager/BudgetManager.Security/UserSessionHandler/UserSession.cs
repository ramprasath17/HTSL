namespace BudgetManager.Security.UserSessionHandler
{
    using System;
    using System.Web;

    public class UserSession : IUserSession
    {
        /// <summary>
        /// Gets company id from session
        /// </summary>
        public string SessionCompanyId
        {
            get
            {
                return Convert.ToString(HttpContext.Current.Session["CompanyId"]);
            }
        }

        /// <summary>
        /// Gets company id
        /// </summary>
        public long CompanyId
        {
            get
            {
                return string.IsNullOrWhiteSpace(SessionCompanyId) ? 0 : Convert.ToInt64(SessionCompanyId);
            }
        }

        /// <summary>
        /// Gets user id
        /// </summary>
        public string UserId
        {
            get
            {
                return Convert.ToString(HttpContext.Current.Session["UserId"]);
            }
        }

        /// <summary>
        /// Set user session
        /// </summary>
        /// <param name="key">The key</param>
        /// <param name="value">The value</param>
        public void SetSession(string key, object value)
        {
            HttpContext.Current.Session[key] = value;
        }

        /// <summary>
        /// Get session data.
        /// </summary>
        /// <param name="key">The key</param>
        /// <returns>Session value</returns>
        public object GetSessionData(string key)
        {
            return HttpContext.Current.Session[key];
        }
    }
}
