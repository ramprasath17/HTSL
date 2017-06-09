using System.Web.Mvc;

namespace BudgetManager.Web.Areas.Expenses
{
    public class ExpensesAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Expenses";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Expenses_default",
                "Expenses/{controller}/{action}/{id}",
                new { controller = "Expense", area = "Expenses", action = "AddMyExpense", id = UrlParameter.Optional }
            );
        }
    }
}
