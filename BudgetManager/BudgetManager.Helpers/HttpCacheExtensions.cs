namespace BudgetManager.Helpers
{
    using BudgetManager.SharedAssembly;
    using System.Collections.Generic;
    using System.Web;
    public static class HttpCacheExtensions
    {
        /// <summary>
        /// Stores the currently logged in user navigation links in cache
        /// </summary>
        /// <param name="userId"></param>
        private void GetLoggedInUserScreens(string userId)
        {
            List<UserScreenLink> userScreenLink = userRepository.GetLoggedInUserScreens(userId);
            HttpRuntime.Cache.Insert("UserNavLinks_" + userId, userScreenLink);
        }        
    }
}
