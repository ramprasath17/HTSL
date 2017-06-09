namespace BudgetManager.Repository.RepositoryClass
{
    using System.Data;
    using BudgetManager.DataLibrary;
    using BudgetManager.Repository.Interface;
    using System;
    using BudgetManager.SharedAssembly.BudgetEntity;
    using BudgetManager.Entities;
    using System.Data.SqlClient;
    using BudgetManager.Security.UserSessionHandler;

    public class BudgetRepository : IBudgetRepository
    {
        /// <summary>
        /// User session
        /// </summary>
        private readonly IUserSession userSession;

        public BudgetRepository(IUserSession userSession)
        {
            this.userSession = userSession;
        }

        /// <summary>
        /// To add the Budget to the application
        /// </summary>
        /// <returns>True if success else false</returns>
        public bool AddBudget(BudgetDetails createBudgetData)
        {
            object[] objAddBudgetParameters = new object[9];
            objAddBudgetParameters[0] = createBudgetData.BudgetName;
            objAddBudgetParameters[1] = createBudgetData.BudgetDescription;
            objAddBudgetParameters[2] = createBudgetData.MinimumAmount;
            objAddBudgetParameters[3] = createBudgetData.MaximumAmount;
            objAddBudgetParameters[4] = createBudgetData.StartDate;
            objAddBudgetParameters[5] = createBudgetData.EndDate;
            objAddBudgetParameters[6] = createBudgetData.CreatedBy;
            objAddBudgetParameters[7] = createBudgetData.Category;
            objAddBudgetParameters[8] = userSession.CompanyId;
            return DataLibrary.ExecuteQuery(ref objAddBudgetParameters, "bspCreateBudget") == -1 ? true : false;
        }

        /// <summary>
        /// To add the Budget category to the application
        /// </summary>
        /// <returns>True if success else false</returns>
        public bool AddBudgetCategory(string categoryName, string createdBy)
        {
            object[] objAddBudgetCategoryParameters = new object[3];
            objAddBudgetCategoryParameters[0] = categoryName;
            objAddBudgetCategoryParameters[1] = createdBy;
            objAddBudgetCategoryParameters[2] = userSession.CompanyId;
            return DataLibrary.ExecuteQuery(ref objAddBudgetCategoryParameters, "bspCreateBudgetCategory") == -1 ? true : false;
        }

        /// <summary>
        /// Get all available budgets in the application
        /// </summary>
        /// <param name="userId">User ID</param>
        /// <returns>Set of available budgets </returns>
        public DataSet GetAvailableBudgets(string userId)
        {
            object[] objUserCredentials = new object[2];
            objUserCredentials[0] = userId;
            objUserCredentials[1] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref objUserCredentials, "bspViewBudget");
        }

        /// <summary>
        /// Get the available budget category
        /// </summary>
        /// <returns>Return busdget category result set</returns>
        public DataSet GetAvailableBudgetCategory()
        {
            object[] objBudgetCategory = new object[1];
            objBudgetCategory[0] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref objBudgetCategory, "bspGetAvailableBudgetCategory");
        }

        /// <summary>
        /// Check is budget already exists
        /// </summary>
        /// <param name="BudgetName"></param>
        /// <returns>true if exists else false</returns>
        public bool CheckBudgetExists(string budgetName)
        {
            object[] objBudgetCheck = new object[2];
            objBudgetCheck[0] = budgetName;
            objBudgetCheck[1] = userSession.CompanyId;
            return DataLibrary.ExecuteReaderSql(ref objBudgetCheck, "bspCheckBudgetAlreadyExists").HasRows;
        }

        /// <summary>
        /// Check budget category exists
        /// </summary>
        /// <returns>Boolean</returns>
        public bool CheckCategoryExists(string categoryName)
        {
            object[] objCategoryCheck = new object[2];
            objCategoryCheck[0] = categoryName;
            objCategoryCheck[1] = userSession.CompanyId;
            return DataLibrary.ExecuteReaderSql(ref objCategoryCheck, "bspCheckCategoryExists").HasRows;
        }

        /// <summary>
        /// Get budget summary.
        /// </summary>
        /// <returns></returns>
        public DataSet GetBudgetSummary()
        {
            object[] objBudgetSummary = new object[1];
            objBudgetSummary[0] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref objBudgetSummary, "bspGetBudgetSummary");
        }

        /// <summary>
        /// Dispose unused references from memory 
        /// </summary>
        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }
}
