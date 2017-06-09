
namespace BudgetManagerLibrary.DataConnectionProvider
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Configuration;
    using System.Data;
    using System.Data.SqlClient;
    using StackExchange.Profiling;
    using StackExchange.Profiling.Data;
    using System.Data.Common;

    internal class DataConnections
    {
        
        /// <summary>
        /// To set the connection string from the web.config file
        /// </summary>            
        public string connString = string.Empty;

        public DataConnections()
        {
            connString = Convert.ToString(ConfigurationManager.AppSettings["BMConnection"]);
        }

        /// <summary>
        /// To get the Sql Connection object.
        /// </summary>
        /// <returns>returns sql connection object</returns>
        public DbConnection GetSqlConnectionObject()
        {            
            return new ProfiledDbConnection(new SqlConnection(connString), MiniProfiler.Current);
        }

        /// <summary>
        /// Opens a new Sql Connection instance.
        /// </summary>
        public void OpenConnection()
        {            
            try
            {
                DbConnection objSqlConn = new ProfiledDbConnection(new SqlConnection(connString), MiniProfiler.Current);
                if (objSqlConn.State == ConnectionState.Closed)
                {
                    objSqlConn.Open();
                }
            }
            catch
            { }
        }

        /// <summary>
        /// To Open a new connection.
        /// </summary>
        /// <param name="objSqlConn">Sql connection object</param>
        /// <returns>if the connection establish successfully then return true else false</returns>
        public void OpenConnection(ref DbConnection objSqlConn)
        {            
            try
            {
                objSqlConn = new ProfiledDbConnection(new SqlConnection(connString), MiniProfiler.Current);
                if (objSqlConn.State == ConnectionState.Closed)
                {
                    objSqlConn.Open();
                }                
            }
            catch
            {  }            
        }

        /// <summary>
        /// Close the existing connection
        /// </summary>
        /// <param name="objSqlConn">Specific connection to close</param>
        public void CloseConnection(ref DbConnection objSqlConn)
        {            
            try
            {
                if (objSqlConn.State == ConnectionState.Open)
                {
                    objSqlConn.Close();
                }
            }
            catch
            { }
            
        }
    }
}
