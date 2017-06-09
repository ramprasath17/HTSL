namespace BudgetManager.Web
{
    using System.Collections.Generic;
    using System.Linq;
    using System.Reflection;
    using System.Web.Mvc;
    using BudgetManager.Helpers;
    using BudgetManager.Repository.Interface;
    using BudgetManager.SharedAssembly;
    using BudgetManager.Web.ActionFilters;
    using BudgetManager.Web.Attributes;

    public static class ApplicationScreens
    {
        public static IUserRepository userRepository;

        //Area namespace
        private const string AreaNamespace = "BudgetManager.Web.";

        /// <summary>
        /// Default Controller to replace
        /// </summary>
        private const string Controller = "Controllers";

        /// <summary>
        /// Areas
        /// </summary>
        private const string Areas = "Areas";

        /// <summary>
        /// Period
        /// </summary>
        private const string Period = ".";

        /// <summary>
        /// Application screen Initialisation <see cref="ApplicationScreens"/>
        /// </summary>
        /// <param name="userRepositoryObject"></param>
        static ApplicationScreens()
        {
            userRepository = DependencyResolver.Current.GetService<IUserRepository>();
        }

        /// <summary>
        /// Register the screens in the application database
        /// </summary>
        /// <param name="assembly">Current Assembly</param>
        /// <returns>Void</returns>
        public static void RegisterScreens(Assembly assembly)
        {
            List<ScreenRoute> existingScreenRoute = userRepository.GetAvailableScreens();

            List<ScreenRoute> controllerActions = assembly.GetTypes().Where(types => typeof(Controller).IsAssignableFrom(types))
                .SelectMany(type => type.GetMethods())
                    .Where(method => method.IsPublic && !method.IsDefined(typeof(NonActionAttribute)) && method.IsDefined(typeof(LinkFilter)) && !method.DeclaringType.Name.Equals("Controller") && method.DeclaringType.Name.EndsWith("Controller")).Select(
                    screenRoutes => new ScreenRoute
                    {
                        ActionName = screenRoutes.GetType().IsDefined(typeof(ActionNameAttribute)) ? AttributeExtensions.GetCustomAttribute<ActionNameAttribute>(screenRoutes).Name : screenRoutes.Name,
                        ControllerName = screenRoutes.DeclaringType.Name,
                        AreaName = GetAreaName(screenRoutes.DeclaringType.FullName, screenRoutes.DeclaringType.Name),
                        LinkText = AttributeExtensions.GetCustomAttribute<LinkFilter>(screenRoutes).LinkText,
                        Read = AttributeExtensions.GetCustomAttribute<LinkFilter>(screenRoutes).Read,
                        Delete = AttributeExtensions.GetCustomAttribute<LinkFilter>(screenRoutes).Delete,
                        Write = AttributeExtensions.GetCustomAttribute<LinkFilter>(screenRoutes).Write,
                        GroupMenuTitle = AttributeExtensions.GetCustomAttribute<GroupMenuTitle>(screenRoutes.DeclaringType).Title,
                    }).ToList();

            List<ScreenRoute> missingScreens = controllerActions.Except(existingScreenRoute).ToList();

            foreach (ScreenRoute screens in missingScreens)
            {
                userRepository.AddApplicationScreens(screens);
            }
        }

        /// <summary>
        /// Get Area Name
        /// </summary>
        /// <param name="areaName">Area Name</param>
        /// <param name="controllerName">Controller Name</param>
        /// <returns>Area Name</returns>
        public static string GetAreaName(string areaName, string controllerName)
        {
            areaName = areaName.Replace(AreaNamespace, string.Empty);
            areaName = areaName.Replace(Areas, string.Empty);
            areaName = areaName.Replace(Controller, string.Empty);
            areaName = areaName.Replace(Period, string.Empty);
            areaName = areaName.Replace(controllerName, string.Empty);
            return areaName;
        }
    }
}