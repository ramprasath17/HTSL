namespace BudgetManager.Web.Models
{
    using System.Web.Mvc;

    public class SearchLookUpData
    {
        public SelectListItem Budgets { get; set; }

        public SelectListItem Expenses { get; set; }

        public string Startdate { get; set; }

        public string EndDate { get; set; }

        public string SpentOn { get; set; }

        public string SpentBy { get; set; }
    }
}