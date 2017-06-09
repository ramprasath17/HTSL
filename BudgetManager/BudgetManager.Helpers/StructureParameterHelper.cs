namespace BudgetManager.Helpers
{
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;

    public static class StructuredParameterHelper
    {
        /// <summary>
        /// List To Data Table Converter
        /// </summary>
        /// <typeparam name="TInput">Input type</typeparam>
        /// <param name="inputList">Input List</param>
        /// <param name="tableName">Data table name</param>
        /// <param name="columnName">Column name</param>
        /// <returns>Data Table</returns>
        public static DataTable ListToDataTableConverter<TInput>(List<TInput> inputList, string tableName, string columnName)
        {
            DataTable dt = new DataTable("tableName");
            dt.Columns.Add(columnName);
            if (inputList != null)
            {
                foreach (var inputValue in inputList)
                {
                    dt.Rows.Add(inputValue);
                }
            }

            return dt;
        }

        /// <summary>
        /// IEnumerable Collection To Data Table Converter
        /// </summary>
        /// <typeparam name="TInput">Input type</typeparam>
        /// <param name="inputList">Input List</param>
        /// <param name="tableName">Data table name</param>
        /// <param name="columnName">Column name</param>
        /// <returns>Data Table</returns>
        public static DataTable EnumerableToDataTableConverter<TInput>(IEnumerable<TInput> inputList, string tableName, string columnName)
        {
            return ListToDataTableConverter<TInput>(inputList.ToList(), tableName, columnName);
        }
    }
}
