namespace BudgetManager.Web.Areas.UserPermission.Models
{
    using BudgetManager.SharedAssembly;
    using Newtonsoft.Json;
    using System.Collections.Generic;

    public class DashboardViewModel
    {
        public int TotalBudgets { get; set; }

        public int TotalUsers { get; set; }

        public int TotalGroups { get; set; }

        public IEnumerable<ChartTemplate> BudgetChartData { get; set; }

        public string SerializedBudgetChartData
        {
            get
            {
                return JsonConvert.SerializeObject(this.BudgetChartData);
            }
        }
    }
}