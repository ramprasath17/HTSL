namespace BudgetManager.Repository.Interface
{
    using System;
    using System.Data;
    using BudgetManager.SharedAssembly.ExpenseEntity;
    using BudgetManager.SharedAssembly.TransactionEntity;

    public interface IExpenseRepository : IDisposable
    {
        /// <summary>
        /// Get Expense Details
        /// </summary>
        /// <returns>Data set</returns>
        DataSet GetExpenseLookUp();

        /// <summary>
        /// Add Expense
        /// </summary>
        /// <param name="expenseSaveData">Expense Save Data</param>        
        void AddExpense(ExpenseMembers expenseSaveData);

        /// <summary>
        /// Get Expense Details
        /// </summary>
        /// <returns>Expense Details Result Set</returns>
        DataSet GtExpenseDetails();

        /// <summary>
        /// Get Overall Expenses
        /// </summary>
        /// <returns>Overall Expenses</returns>
        DataSet GetOverallExpenses();

        /// <summary>
        /// Get transaction lookup data
        /// </summary>
        /// <param name="lookupType">Lookup type</param>
        /// <param name="lookupCondition">Look up condition</param>
        /// <returns>Lookup data</returns>
        DataSet GetTransactionLookUpData(char lookupType, string lookupCondition);

        /// <summary>
        /// Get all my expenses.
        /// </summary>
        /// <returns>All the expenses associated to the company user belongs to.</returns>
        DataSet GetAllMyExpenses();

        /// <summary>
        /// Create new transaction for the expense.
        /// </summary>
        /// <param name="transactionData">transaction data</param>
        /// <returns>true if transaction saved successfully else false.</returns>
        bool CreateTransaction(TransactionMembers transactionData);

        /// <summary>
        /// Get all my transactions.
        /// </summary>
        /// <returns>Transaction result set.</returns>
        DataSet GetAllMyTransactions();

        /// <summary>
        /// Check Amount Beyond Level
        /// </summary>
        /// <param name="AmountReturned">Amount returned</param>
        /// <param name="expenseId">Expense id.</param>
        /// <param name="amountReturnedBy">Amount returned by</param>
        /// <returns>true if the amount received is greater than the amount to be given then return true else false.</returns>
        bool CheckAmountBeyondLevel(decimal AmountReturned, long expenseId, string amountReturnedBy,string amountReceivedBy);

        /// <summary>
        /// Get look ups for transaction analysis.
        /// </summary>
        /// <returns></returns>
        DataSet GetAnalysisLookUps();

        /// <summary>
        /// Get result set from analysis.
        /// </summary>
        /// <param name="analysisQuery">Analysis query entity.</param>
        /// <returns>Analysis result set.</returns>
        DataSet GetAnalysisData(AnalysisQuery analysisQuery);
    }
}
