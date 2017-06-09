namespace BudgetManager.Infrastructure.WebSecurity
{
    using BudgetManager.Repository.Interface;
    using BudgetManager.Repository.RepositoryClass;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Security;

    public class AppFittersRoleProvider : RoleProvider
    {
        //IUserRepository userRepository;
        //public AppFittersRoleProvider(IUserRepository userRepository)
        //{
        //    this.userRepository = userRepository;
        //}
        UserRepository userRepository = new UserRepository();
        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Will fetch the al available roles in the application
        /// </summary>
        /// <returns></returns>
        public override string[] GetAllRoles()
        {                       
            string[] objUserRoles = userRepository.GetAllAvailableRoles();
            string[] userRoles = (string[])objUserRoles;
            userRepository = null;
            return userRoles;
        }

        /// <summary>
        /// Get the current user role
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public override string[] GetRolesForUser(string username)
        {
            string userRole = userRepository.GetCurrentUserRole(username);
            string[] userRoles = new string[] { userRole};           
            return userRoles;
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }


        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            throw new NotImplementedException();
        }
    }
}