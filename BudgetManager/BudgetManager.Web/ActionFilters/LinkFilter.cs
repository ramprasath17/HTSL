namespace BudgetManager.Web.ActionFilters
{
    using System;    
   
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
    public class LinkFilter : Attribute
    {                
        /// <summary>
        ///  Gets or sets link text.
        /// </summary>
        public string LinkText { get; set; }

        /// <summary>
        /// Gets or sets read.
        /// </summary>
        public bool Read { get; set; }

        /// <summary>
        /// Gets or sets write.
        /// </summary>
        public bool Write { get; set; }

        /// <summary>
        /// Gets or sets delete.
        /// </summary>
        public bool Delete { get; set; }
    }
}