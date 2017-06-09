namespace BudgetManager.Repository.RepositoryClass
{
    using System.Data;
    using BudgetManager.Repository.Interface;
    using DataLibrary;
    using BudgetManager.Entities;
    using BudgetManager.SharedAssembly.ExpenseEntity;
    using System.Data.SqlClient;
    using System.Collections.Generic;
    using BudgetManager.Helpers;
    using BudgetManager.Security.UserSessionHandler;
    using BudgetManager.SharedAssembly.TransactionEntity;

    public class ExpenseRepository : IExpenseRepository
    {
        /// <summary>
        /// User session
        /// </summary>
        private readonly IUserSession userSession;

        public ExpenseRepository(IUserSession userSession)
        {
            this.userSession = userSession;
        }

        /// <summary>
        /// Get Expense Details
        /// </summary>
        /// <returns>Data set</returns>
        public DataSet GetExpenseLookUp()
        {
            object[] expenseDetails = new object[1];
            expenseDetails[0] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref expenseDetails, "bspGetExpenseDetailsLookUps");
        }

        /// <summary>
        /// Add Expense
        /// </summary>
        /// <param name="expenseSaveData">Expense Save Data</param>        
        public void AddExpense(ExpenseMembers expenseSaveData)
        {
            SqlCommand objSqlCmd = new SqlCommand();
            objSqlCmd.CommandType = CommandType.StoredProcedure;
            objSqlCmd.Parameters.Add("@Description", SqlDbType.NVarChar).Value = expenseSaveData.Description;
            objSqlCmd.Parameters.Add("@BudgetCategoryId", SqlDbType.Int).Value = expenseSaveData.BudgetCategory;
            objSqlCmd.Parameters.Add("@SpentOn", SqlDbType.DateTime).Value = expenseSaveData.SpentOn;
            objSqlCmd.Parameters.Add("@SpentBy", SqlDbType.Text).Value = expenseSaveData.SpentBy;
            objSqlCmd.Parameters.Add("@SpentAmount", SqlDbType.Money).Value = expenseSaveData.SpentAmount;
            objSqlCmd.Parameters.Add("@GroupIds", SqlDbType.Structured).Value = StructuredParameterHelper.ListToDataTableConverter<string>(expenseSaveData.SelectedGroupId, "Groups", "GroupID");
            objSqlCmd.Parameters.Add("@UserIds", SqlDbType.Structured).Value = StructuredParameterHelper.ListToDataTableConverter<string>(expenseSaveData.ExcludedUsers, "Users", "UserId");
            objSqlCmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = expenseSaveData.CreatedBy;
            objSqlCmd.Parameters.Add("@CompanyId", SqlDbType.Int).Value = userSession.CompanyId;
            DataLibrary.ExecuteProcedureWithDefinedParameters(objSqlCmd, "bspAddExpenses");
        }

        /// <summary>
        /// Get Expense Details
        /// </summary>
        /// <returns>Expense Details Result Set</returns>
        public DataSet GtExpenseDetails()
        {
            object[] expenseDetails = new object[1];
            expenseDetails[0] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref expenseDetails, "bspGetExpenses");
        }

        /// <summary>
        /// Get Overall Expenses
        /// </summary>
        /// <returns>Overall Expenses</returns>
        public DataSet GetOverallExpenses()
        {
            object[] expenseDetails = new object[1];
            expenseDetails[0] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref expenseDetails, "bspGetOverallExpenses");
        }

        /// <summary>
        /// Get transaction lookup data
        /// </summary>
        /// <param name="lookupType">Lookup type</param>
        /// <param name="lookupCondition">Look up condition</param>
        /// <returns></returns>
        public DataSet GetTransactionLookUpData(char lookupType, string lookupCondition)
        {
            object[] expenseDetails = new object[3];
            expenseDetails[0] = lookupType;
            expenseDetails[1] = lookupCondition;
            expenseDetails[2] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref expenseDetails, "bspGetTransactionLookUpData");
        }

        /// <summary>
        /// Get all my expenses.
        /// </summary>
        /// <returns>All the expenses associated to the company user belongs to.</returns>
        public DataSet GetAllMyExpenses()
        {
            object[] expenseDetails = new object[1];
            expenseDetails[0] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref expenseDetails, "bspGetAllMyExpenses");
        }

        /// <summary>
        /// Create new transaction for the expense.
        /// </summary>
        /// <param name="transactionData">transaction data</param>
        /// <returns>true if transaction saved successfully else false.</returns>
        public bool CreateTransaction(TransactionMembers transactionData)
        {
            object[] transactionInputData = new object[7];
            transactionInputData[0] = transactionData.ExpenseId;
            transactionInputData[1] = transactionData.AmountReturned;
            transactionInputData[2] = transactionData.AmountReturnedOn;
            transactionInputData[3] = transactionData.ReturnedBy;
            transactionInputData[4] = transactionData.ReceivedBy;
            transactionInputData[5] = transactionData.Description;
            transactionInputData[6] = userSession.CompanyId;
            return DataLibrary.ExecuteQuery(ref transactionInputData, "bspCreateTransaction").Equals(0);
        }

        /// <summary>
        /// Get all my transactions.
        /// </summary>
        /// <returns>Transaction result set.</returns>
        public DataSet GetAllMyTransactions()
        {
            object[] transactionInput = new object[1];
            transactionInput[0] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref transactionInput, "bspGetAllMyTransactions");
        }

        /// <summary>
        /// Check Amount Beyond Level
        /// </summary>
        /// <param name="AmountReturned">Amount returned</param>
        /// <param name="expenseId">Expense id.</param>
        /// <param name="amountReturnedBy">Amount returned by</param>
        /// <returns>true if the amount received is greater than the amount to be given then return true else false.</returns>
        public bool CheckAmountBeyondLevel(decimal AmountReturned, long expenseId, string amountReturnedBy,string amountReceivedBy)
        {
            object[] objReturnAmountCheck = new object[5];
            objReturnAmountCheck[0] = expenseId;
            objReturnAmountCheck[1] = AmountReturned;
            objReturnAmountCheck[2] = userSession.CompanyId;
            objReturnAmountCheck[3] = amountReturnedBy;
            objReturnAmountCheck[4] = amountReceivedBy;
            return DataLibrary.ExecuteReaderSql(ref objReturnAmountCheck, "bspCheckAmountBeyondLevel").HasRows;
        }

        /// <summary>
        /// Get look ups for transaction analysis.
        /// </summary>
        /// <returns></returns>
        public DataSet GetAnalysisLookUps()
        {
            object[] objAnalysisLookUpParams = new object[2];
            objAnalysisLookUpParams[0] = userSession.CompanyId;
            return DataLibrary.ExecuteDataSet(ref objAnalysisLookUpParams, "bspGetAnalysisLookUps");
        }

        /// <summary>
        /// Get result set from analysis.
        /// </summary>
        /// <param name="analysisQuery">Analysis query entity.</param>
        /// <returns>Analysis result set.</returns>
        public DataSet GetAnalysisData(AnalysisQuery analysisQuery)
        {
            object[] objAnalysisQueryParams = new object[8];

            objAnalysisQueryParams[0] = analysisQuery.User1;
            objAnalysisQueryParams[1] = analysisQuery.User2;
            objAnalysisQueryParams[2] = analysisQuery.GroupId;
            objAnalysisQueryParams[3] = analysisQuery.ExpenseId;
            objAnalysisQueryParams[4] = analysisQuery.From;
            objAnalysisQueryParams[5] = analysisQuery.To;
            objAnalysisQueryParams[6] = analysisQuery.Action;
            objAnalysisQueryParams[7] = userSession.CompanyId;

            return DataLibrary.ExecuteDataSet(ref objAnalysisQueryParams, "bspGetAnalysisData");
        }

        /// <summary>
        /// Dispose the current object
        /// </summary>
        public void Dispose()
        {
            System.GC.SuppressFinalize(this);
        }
    }
}
