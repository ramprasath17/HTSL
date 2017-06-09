using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BudgetManager.Repository.Interface
{
    public interface ICommonRepository
    {
        /// <summary>
        /// Delete selected component record
        /// </summary>
        /// <param name="recordId">Record Unique ID</param>
        /// <param name="componentType">Component Type</param>
        void deleteSelectedComponentRecord(string recordId, char componentType);

        /// <summary>
        /// Update Selected Component Reccord 
        /// </summary>
        /// <param name="updateParameter">Update Parameter</param>
        /// <param name="componentType">Component Type</param>
        /// <param name="parameterCount">Parameter Count</param>
        /// <param name="procedureName">Procedure Name</param>
        void UpdateSelectedComponentRecord(Dictionary<string, object> updateParameter, int parameterCount, string procedureName);
    }
}
