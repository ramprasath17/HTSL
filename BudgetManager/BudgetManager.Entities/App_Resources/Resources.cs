using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BudgetManager.Entities
{
    public class Resources
    {
        public static bool isRememberMe = false;

        public static string DisplayName = string.Empty;

        public static string GetHostName(string requestUrl)       
        {
            return string.Format("{0}//{1}{2}", requestUrl.Split('/'));
        }

        public static int? CompanyName { get; set; }
    }
}