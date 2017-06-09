namespace BudgetManager.Web.Areas.Expenses.Models
{
    public class UsersInExpense
    {
        public string UserId { get; set; }

        public string UserDisplayName { get; set; }

        public int ExpenseID { get; set; }

        public int GroupId { get; set; }
    }
}