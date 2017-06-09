namespace BudgetManager.Security.UserSessionHandler
{
    public interface IUserSession
    {
        /// <summary>
        /// Gets or sets company id.
        /// </summary>
        long CompanyId { get; }

        /// <summary>
        /// Gets or sets User id
        /// </summary>
        string UserId { get; }

        /// <summary>
        /// Set user session
        /// </summary>
        /// <param name="key">The key</param>
        /// <param name="value">The value</param>
        void SetSession(string key, object value);

        /// <summary>
        /// Get session data.
        /// </summary>
        /// <param name="key">The key</param>
        /// <returns>Session value</returns>
        object GetSessionData(string key);
    }
}
