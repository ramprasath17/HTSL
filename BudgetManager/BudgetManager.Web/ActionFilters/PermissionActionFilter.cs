namespace BudgetManager.Web.ActionFilters
{
    using System;
    using System.Web;
    using System.Web.Mvc;
    using System.Web.Routing;
    using BudgetManager.Helpers.Permissions.Contract;
    using BudgetManager.Repository.Interface;

    public class PermissionActionFilter : ActionFilterAttribute, IActionFilter
    {
        /// <summary>
        /// User Repository
        /// </summary>
        private readonly IUserRepository userRepository;

        private readonly IPermissionHelper permissionHelper;

        private bool isApply = true;

        /// <summary>
        /// Initialises new instance of <see cref="PermissionActionFilter"/>
        /// </summary>
        public PermissionActionFilter()
            : this(DependencyResolver.Current.GetService<IUserRepository>(),
                   DependencyResolver.Current.GetService<IPermissionHelper>())
        {

        }

        /// <summary>
        /// Initialises new instance of <see cref="PermissionActionFilter"/>
        ///<param name="isApply">Is Apply</param>
        /// </summary>
        public PermissionActionFilter(bool isApply)
            : this(DependencyResolver.Current.GetService<IUserRepository>(),
               DependencyResolver.Current.GetService<IPermissionHelper>())
        {
            this.isApply = isApply;
        }

        /// <summary>
        /// Initialises new instance of <see cref="PermissionActionFilter"/>
        /// </summary>
        /// <param name="userRepository">User Repository</param>
        public PermissionActionFilter(IUserRepository userRepository, IPermissionHelper permissionHelper)
        {
            this.userRepository = userRepository;
            this.permissionHelper = permissionHelper;
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Request.IsAuthenticated && isApply)
            {
                HttpRequest request = new HttpRequest("", filterContext.HttpContext.Request.Url.AbsoluteUri, "");
                HttpResponse response = new HttpResponse(new System.IO.StringWriter());
                var httpContext = new HttpContext(request, response);
                var routeData = RouteTable.Routes.GetRouteData(new HttpContextWrapper(httpContext));

                string actionName = Convert.ToString(routeData.Values["action"]);
                string controllerName = Convert.ToString(routeData.Values["controller"]) + "Controller";
                string areaName = Convert.ToString(routeData.Values["area"]);

                SharedAssembly.ScreenRoute screenParameter = new SharedAssembly.ScreenRoute
                {
                    AreaName = areaName,
                    ActionName = actionName,
                    ControllerName = controllerName
                };

                string userName = Convert.ToString(filterContext.HttpContext.Session["UserId"]);
                permissionHelper.ResetPermission();
                if (!string.IsNullOrWhiteSpace(actionName))
                {
                    if (!string.IsNullOrWhiteSpace(userName))
                    {
                        if (!userRepository.CheckIsUserHasAccessOnScreen(userName, screenParameter))
                        {
                            filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { action = "UnAuthorizedAccess", controller = "Account", area = "" }));
                        }
                    }
                    else
                    {
                        filterContext.Controller.TempData["statusMessage"] = "Session Expired";
                        filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { action = "Messager", controller = "Account", area = "" }));
                    }
                }
                else
                {
                    filterContext.Controller.TempData["statusMessage"] = "Error in serving the requested page.Please try again.";
                    filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { action = "Messager", controller = "Account", area = "" }));
                }
            }
        }

        /// <summary>
        /// On action executed.
        /// </summary>
        /// <param name="filterContext">The filter context.</param>
        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (!filterContext.HttpContext.Request.IsAjaxRequest())
            {
                Uri referrerUrl = filterContext.HttpContext.Request.UrlReferrer ?? filterContext.HttpContext.Request.Url;
                HttpRequest httpRequest = new HttpRequest(string.Empty, Convert.ToString(referrerUrl), string.Empty);
                HttpResponse httpResponse = new HttpResponse(new System.IO.StringWriter());
                HttpContext httpContext = new HttpContext(httpRequest, httpResponse);
                object referralAction = RouteTable.Routes.GetRouteData(new HttpContextWrapper(httpContext)).Values["action"];
                object currentAction = filterContext.HttpContext.Request.RequestContext.RouteData.Values["action"];
                if (referralAction.Equals(currentAction))
                {
                    string statusAlert = filterContext.HttpContext.Request.Headers.Get("Status-Alert");
                    filterContext.Controller.ViewBag.CreateStatusAlert = statusAlert;
                }
            }
        }
    }
}