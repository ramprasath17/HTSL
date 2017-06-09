namespace BudgetManager.Helpers
{
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Web.Mvc;
    using BudgetManager.Infrastructure.Helpers;

    public static class AppDataTableExtensions
    {
        /// <summary>
        /// Load Lookup data
        /// </summary>
        /// <typeparam name="TInput1">Input Type 1</typeparam>
        /// <typeparam name="TInput2">Input Type 2</typeparam>
        /// <param name="dropDownLookUpTable">Input Table</param>
        /// <param name="field1">Table Column 1</param>
        /// <param name="field2">Table Column 2</param>
        /// <param name="selectedItem">Selected Item</param>        
        /// <returns>Selected List Item</returns>     
        public static IEnumerable<SelectListItem> LoadLookUps<TInput1, TInput2>(this DataTable dropDownLookUpTable, string field1 = "Text", string field2 = "Value", string selectedItem = "")
        {
            if (dropDownLookUpTable == null)
            {
                return new List<SelectListItem>().AsEnumerable();
            }

            return dropDownLookUpTable.AsEnumerable().Select(results => new SelectListItem
            {
                Text = TypeConversionHelper.GetDefaultValueIfNull<string>(results.Field<TInput1>(field1)),
                Value = TypeConversionHelper.GetDefaultValueIfNull<string>(results.Field<TInput2>(field2)),
                Selected = TypeConversionHelper.GetDefaultValueIfNull<string>(results.Field<TInput2>(field2)).Equals(selectedItem),
            });
        }

        /// <summary>
        /// Load Lookup data
        /// </summary>
        /// <typeparam name="TInput1">Input Type 1</typeparam>
        /// <typeparam name="TInput2">Input Type 2</typeparam>
        /// <param name="dropDownLookUpTable">Input Table</param>
        /// <param name="selectedItem">Selected Item</param>        
        /// <returns>Selected List Item</returns>     
        public static IEnumerable<SelectListItem> LoadLookUps<TInput1, TInput2>(this DataTable dropDownLookUpTable, string selectedItem)
        {
            string field1 = "Text";
            string field2 = "Value";
            if (dropDownLookUpTable == null)
            {
                return new List<SelectListItem>().AsEnumerable();
            }

            return dropDownLookUpTable.AsEnumerable().Select(results => new SelectListItem
            {
                Text = TypeConversionHelper.GetDefaultValueIfNull<string>(results.Field<TInput1>(field1)),
                Value = TypeConversionHelper.GetDefaultValueIfNull<string>(results.Field<TInput2>(field2)),
                Selected = TypeConversionHelper.GetDefaultValueIfNull<string>(results.Field<TInput2>(field2)).Equals(selectedItem, System.StringComparison.InvariantCultureIgnoreCase),
            });
        }

        /// <summary>
        /// Load Look ups to dictionary
        /// </summary>
        /// <typeparam name="TInput1">Input Type 1</typeparam>
        /// <typeparam name="TInput2">Input Type 2</typeparam>
        /// <param name="dropDownLookUpTable">Input Table</param>
        /// <param name="field1">Table Column 1</param>
        /// <param name="field2">Table Column 2</param>
        /// <param name="selectedItem">Selected Item</param> 
        /// <returns>Look up data as dictionary object</returns>
        public static Dictionary<TInput1, TInput2> LoadLookUpsDictionary<TInput1, TInput2>(this DataTable dropDownLookUpTable, string field1 = "Text", string field2 = "Value", string selectedItem = "")
        {
            if (dropDownLookUpTable == null)
            {
                return new Dictionary<TInput1, TInput2>();
            }

            DataTableReader lookUpDictionaryReader = dropDownLookUpTable.CreateDataReader();
            Dictionary<TInput1, TInput2> lookUpDictionary = new Dictionary<TInput1, TInput2>();
            while (lookUpDictionaryReader.Read())
            {
                lookUpDictionary.Add(TypeConversionHelper.GetDefaultValueIfNull<TInput1>(lookUpDictionaryReader[field1]), TypeConversionHelper.GetDefaultValueIfNull<TInput2>(lookUpDictionaryReader[field2]));
            }

            // return dropDownLookUpTable.AsEnumerable().ToDictionary<DataRow, TInput1, TInput2>(row => row.Field<TInput1>(field1),
            //                    row => row.Field<TInput2>(field2));
								
            return lookUpDictionary;
        }

        /// <summary>
        /// Remove list of columns from data table
        /// </summary>
        /// <param name="dataTableObj">The data table object.</param>
        /// <param name="excludedColumns">Excluded columns.</param>
        /// <returns><see cref="DataTable"/></returns>
        public static DataTable RemoveColumns(this DataTable dataTableObj, params string[] excludedColumns)
        {
            foreach (string columnName in excludedColumns)
            {
                dataTableObj.Columns.Remove(columnName);
            }

            return dataTableObj;
        }

        /// <summary>
        /// Rename the specified column name.
        /// </summary>
        /// <param name="dataTableObj">Data table object.</param>
        /// <param name="actualColumnName">Actual Column name.</param>
        /// <param name="newColumnName">New column name.</param>
        /// <returns><see cref="DataTable"/></returns>
        public static DataTable ModifyColumn(this DataTable dataTableObj, string actualColumnName, string newColumnName)
        {
            dataTableObj.Columns[actualColumnName].ColumnName = newColumnName;
            return dataTableObj;
        }

        /// <summary>
        /// Rename the specified column name and change position.
        /// </summary>
        /// <param name="dataTableObj">Data table object.</param>
        /// <param name="actualColumnName">Actual Column name.</param>
        /// <param name="newColumnName">New column name.</param>
        /// <param name="order">The order.</param>
        /// <returns><see cref="DataTable"/></returns>
        public static DataTable ModifyColumn(this DataTable dataTableObj, string actualColumnName, string newColumnName, int order)
        {
            order = order > dataTableObj.Columns.Count ? dataTableObj.Columns.Count - 1 : order - 1;
            order = order < 0 ? 0 : order;
            if (dataTableObj.Columns[actualColumnName] != null && order >= 0)
            {
                dataTableObj.Columns[actualColumnName].SetOrdinal(order);
                dataTableObj.Columns[actualColumnName].ColumnName = newColumnName;
            }

            return dataTableObj;
        }
    }
}
