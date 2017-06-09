using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BudgetManager.Web.Attributes
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
    public class GroupMenuTitle : Attribute
    {
        /// <summary>
        /// Gets or sets title.
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// The <see cref="GroupMenuTitle"/>
        /// </summary>
        public GroupMenuTitle()
        {
        }

        /// <summary>
        /// The <see cref="GroupMenuTitle"/>
        /// </summary>
        /// <param name="title">The title.</param>
        public GroupMenuTitle(string title)
        {
            this.Title = title;
        }
    }
}