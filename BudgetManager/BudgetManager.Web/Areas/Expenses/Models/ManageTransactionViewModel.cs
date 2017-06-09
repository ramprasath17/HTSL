namespace BudgetManager.Web.Areas.Expenses.Models
{
    using System.Collections.Generic;
    using BudgetManager.SharedAssembly.ApplicationLookUps;
    using Newtonsoft.Json;
    using BudgetManager.Helpers.Permissions;    

    public class ManageTransactionViewModel : PermissionBase
    {
        /// <summary>
        /// Gets or sets transaction data
        /// </summary>
        public List<TransactionViewModel> TransactionData { get; set; }

        /// <summary>
        /// Gets or sets transaction lookup data
        /// </summary>
        public TransactionLookUp TransactionLookUpData { get; set; }

        /// <summary>
        /// Gets the serialized look up data for client side load
        /// </summary>
        public string SerializedLookUp
        {
            get
            {
                return JsonConvert.SerializeObject(TransactionLookUpData);
            }
        }
    }
}