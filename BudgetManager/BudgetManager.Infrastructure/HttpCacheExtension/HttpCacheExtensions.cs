namespace BudgetManager.Infrastructure.HttpCacheExtensions
{
    using System.Collections.Generic;
    using System.Web;
    using BudgetManager.Repository.Interface;
    using BudgetManager.SharedAssembly;
    using System;
    using System.Web.Caching;

    public static class HttpCacheExtensions
    {
        /// <summary>
        /// Stores the currently logged in user navigation links in cache
        /// </summary>
        /// <param name="userId">User Id</param>
        /// <param name="userRepository">User Repository</param>
        public static void GetLoggedInUserScreens(string userId, IUserRepository userRepository)
        {
            IEnumerable<UserMenu> userScreenLink = userRepository.GetLoggedInUserScreens(userId);
            InsertObjectToCache<IEnumerable<UserMenu>>("UserNavLinks_" + userId, userScreenLink);            
        }

        /// <summary>
        /// Insert the specified key value combination to cache
        /// </summary>
        /// <typeparam name="T">Param type</typeparam>
        /// <param name="key">Key</param>
        /// <param name="value">Value</param>
        public static void InsertObjectToCache<T>(string key, T value) where T : class
        {
            HttpRuntime.Cache.Insert(key, value, null);//, null, Cache.NoSlidingExpiration, Cache.NoSlidingExpiration);
        }

        /// <summary>
        /// Remove the specified key value from cache
        /// </summary>
        /// <param name="key">Cache key</param>
        public static void DeleteObjectFromCache(string key)
        {
            HttpRuntime.Cache.Remove(key);
        }
    }
}
