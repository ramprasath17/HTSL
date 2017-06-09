using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace BudgetManager.Web.ActionFilters
{
    public class ExceptionCatcherFilter : FilterAttribute, IExceptionFilter
    {
        public void OnException(ExceptionContext filterContext)
        {
            if (!filterContext.HttpContext.Request.IsAjaxRequest())
            {
                filterContext.ExceptionHandled = true;
                filterContext.Controller.TempData["ErrorMessage"] = filterContext.Exception.Message;
                filterContext.Controller.TempData["StackTrace"] = "Please contact concerned person for details.";                
                if (ConfigurationManager.AppSettings["showStackTrace"].Equals(ConfigurationManager.AppSettings["Password"]))
                {
                    filterContext.Controller.TempData["StackTrace"] = filterContext.Exception.StackTrace;
                }

                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { area = "", action = "Error", controller = "Information" }));
            }
        }
    }
}