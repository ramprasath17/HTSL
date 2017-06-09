namespace BudgetManager.Repository.Interface
{    
    using System;
    using System.Data;
    using BudgetManager.SharedAssembly.BudgetEntity;

    public interface IBudgetRepository  : IDisposable
    {
        /// <summary>
        /// To add the user to the application
        /// </summary>
        /// <returns>True if success else false</returns>
        bool AddBudget(BudgetDetails createBudgetData);

        /// <summary>
        /// Get all available budgets in the application
        /// </summary>
        /// <param name="userId">User ID</param>
        /// <returns>Set of available budgets </returns>
        DataSet GetAvailableBudgets(string userId);

        /// <summary>
        /// To add the user to the application
        /// </summary>
        /// <returns>True if success else false</returns>
        bool AddBudgetCategory(string categoryName, string createdBy);

        /// <summary>
        /// Get the available budget category
        /// </summary>
        /// <returns>Return busdget category result set</returns>
        DataSet GetAvailableBudgetCategory();

        /// <summary>
        /// Check is budget already exists
        /// </summary>
        /// <param name="BudgetName"></param>
        /// <returns>true if exists else false</returns>
        bool CheckBudgetExists(string budgetName);

        /// <summary>
        /// Check budget category exists
        /// </summary>
        /// <returns>Boolean</returns>
        bool CheckCategoryExists(string categoryName);

        /// <summary>
        /// Get budget summary.
        /// </summary>
        /// <returns></returns>
        DataSet GetBudgetSummary();
    }
}
