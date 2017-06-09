namespace BudgetManager.SharedAssembly
{
    using System.Collections.Generic;

    public class LookUps
    {
        /// <summary>
        /// Gets or sets user look up
        /// </summary>
        public Dictionary<string, string> Users { get; set; }

        /// <summary>
        /// Gets or sets Budget type look up
        /// </summary>
        public Dictionary<string, string> BudgetCategory { get; set; }

        /// <summary>
        /// Gets or sets User Group Look up
        /// </summary>
        public Dictionary<string, string> UserGroups { get; set; }
    }
}
