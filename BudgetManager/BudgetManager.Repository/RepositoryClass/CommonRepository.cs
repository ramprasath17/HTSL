namespace BudgetManager.Repository.RepositoryClass
{
    using BudgetManager.DataLibrary;
    using BudgetManager.Repository.Interface;
    using BudgetManager.Security.UserSessionHandler;
    using System;
    using System.Collections.Generic;
    using System.Web;

    public class CommonRepository : ICommonRepository
    {
        /// <summary>
        /// User session
        /// </summary>
        private readonly IUserSession userSession;

        public CommonRepository(IUserSession userSession)
        {
            this.userSession = userSession;
        }

        /// <summary>
        /// Delete selected component record
        /// </summary>
        /// <param name="recordId">Record Unique ID</param>
        /// <param name="componentType">Component Type</param>
        public void deleteSelectedComponentRecord(string recordId, char componentType)
        {
            object[] objComponentParameters = new object[3];
            objComponentParameters[0] = recordId;
            objComponentParameters[1] = componentType;
            objComponentParameters[2] = userSession.CompanyId;
            DataLibrary.ExecuteQuery(ref objComponentParameters, "bspDeleteRecordOfSelectedComponent");
        }

        /// <summary>
        /// Update Selected Component Record 
        /// </summary>
        /// <param name="updateParameter">Update Parameter</param>
        /// <param name="componentType">Component Type</param>
        /// <param name="parameterCount">Parameter Count</param>
        public void UpdateSelectedComponentRecord(Dictionary<string, object> updateParameter, int parameterCount, string procedureName)
        {
            object[] objComponentParameters = new object[parameterCount];
            int loopCount = 0;
            foreach (var paramValue in updateParameter.Values)
            {
                objComponentParameters[loopCount] = GetEncodedValueOnString(paramValue);
                loopCount++;
            }

            DataLibrary.ExecuteQuery(ref objComponentParameters, procedureName);
        }

        /// <summary>
        /// Get encoded value of the input parameter if it is in string or char format
        /// </summary>
        /// <param name="paramValue">Input parameter</param>
        /// <returns>Html encoded value if its a string</returns>
        internal static object GetEncodedValueOnString(object paramValue)
        {
            return (paramValue is string || paramValue is char || paramValue is DateTime) ? HttpUtility.HtmlEncode(paramValue) : paramValue;
        }
    }
}
