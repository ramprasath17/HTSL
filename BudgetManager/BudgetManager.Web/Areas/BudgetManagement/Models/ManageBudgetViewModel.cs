namespace BudgetManager.Web.Areas.BudgetManagement.Models
{
    using BudgetManager.SharedAssembly.ApplicationLookUps;
    using System.Collections.Generic;
    using Newtonsoft.Json;

    public class ManageBudgetViewModel
    {
        /// <summary>
        /// Gets or sets Budget Details
        /// </summary>
        public List<BudgetDetails> BudgetDetails { get; set; }

        /// <summary>
        /// Gets or sets Look up for Budget 
        /// </summary>
        public BudgetLookUp BudgetLookUpData { get; set; }

        /// <summary>
        /// Gets the serialized look up data for client side load
        /// </summary>
        public string SerializedLookUp
        {
            get
            {
               return JsonConvert.SerializeObject(BudgetLookUpData);
            }
        }
    }
}