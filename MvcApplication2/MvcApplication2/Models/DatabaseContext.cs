using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using MvcApplication2.Models;
using MvcApplication2.Models;

namespace MvcApplication2.Models
{
    public class DatabaseContext
    {
        #region Private Properties
        private SqlConnection objConnection;
        private SqlCommand objCommand = new SqlCommand();
        SqlCommand command = null;
        SqlDataAdapter sqlAdapter = null;
        DataSet dSet = new DataSet();
        DataTable dTable = new DataTable();
        #endregion

        #region Constructors
        /// <summary>
        /// Default Constructor which calls method to establish connection to the Tenant Database
        /// </summary>
        public DatabaseContext()
        {
            MakeConnection(ConfigurationManager.ConnectionStrings["IntaaseConnection"].ToString());
        }

        public DatabaseContext(String connectionString)
        {
            MakeConnection(connectionString);
        }
        #endregion

        #region Private Methods
        /// <summary>
        /// Establish Connection
        /// </summary>
        /// <param name="connString"></param>
        private void MakeConnection(String connString)
        {
            try
            {
                objConnection = new SqlConnection(connString);
                if (objConnection.State == ConnectionState.Closed) { objConnection.Open(); }
            }
            catch (Exception ex)
            {
                ex.HelpLink = "Database Connection Error.";
                throw ex;
            }
        }
        #endregion

        #region Public Methods
        /// <summary>
        /// Test Connection String
        /// </summary>
        /// <param name="connString"></param>
        public static Int32 TestConnectionString(String connString)
        {
            SqlConnection sqlconn = null;
            try
            {
                sqlconn = new System.Data.SqlClient.SqlConnection(connString);
                if (sqlconn.State == ConnectionState.Closed) { sqlconn.Open(); }
                return 1;
            }
            catch (SqlException)
            {
                return -8; /* Could not find Database or not having permission */
            }
            finally
            {
                if (sqlconn != null)
                {
                    sqlconn.Close();
                    sqlconn = null;
                }
            }
        }
        /// <summary>
        /// Uploads data to database with stored procedure and iterated parameter values and returns integer for the input output parameter(OutParam).
        /// </summary>
        /// <param name="strStoredProcedureName">Stored procedure name as string</param>
        /// <param name="hybdParamAndValue">Hash table</param>
        /// <param name="strOutParam">To get the return value with specific variable</param>
        /// <returns>Resulted type as integer</returns>
        public int UploadDataToDB(string strStoredProcedureName, HybridDictionary hybdParamAndValue, string strOutParam)
        {
            try
            {
                objCommand.CommandText = strStoredProcedureName;
                objCommand.Connection = objConnection;
                //objCommand.CommandTimeout = Formatter.ConvertToInt(ConfigurationManager.AppSettings["NormalTimeout"]);
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandTimeout = 90;
                foreach (string str in hybdParamAndValue.Keys)
                { objCommand.Parameters.AddWithValue(str, hybdParamAndValue[str]); }
                objCommand.Parameters.Add(strOutParam, SqlDbType.Int);
                objCommand.Parameters[strOutParam].Direction = ParameterDirection.Output;
                objCommand.ExecuteNonQuery();
                return Convert.ToInt32(objCommand.Parameters[strOutParam].Value);
            }
            catch (Exception ex)
            {
                ex.HelpLink = strStoredProcedureName;
                //return 0;
                throw ex;
            }
            finally
            {
                if (objConnection != null)
                {
                    objConnection.Close();
                    objCommand.Dispose();
                }
            }
        }
        /// <summary>
        /// Get data from database as dataset using stored procedure
        /// </summary>
        /// <param name="strStoredProcedureName">Stored procedure name as string</param>
        /// <returns>Dataset</returns>
        public DataSet DownloadDataFromDB(string strStoredProcedureName)
        {
            SqlDataAdapter objDAdapter = new SqlDataAdapter();
            DataSet objDSet = new DataSet();
            try
            {
                objCommand.CommandText = strStoredProcedureName;
                objCommand.Connection = objConnection;
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandTimeout = 90;
                objDAdapter.SelectCommand = objCommand;
                objDAdapter.Fill(objDSet);
            }
            catch (Exception ex)
            {
                ex.HelpLink = strStoredProcedureName;
                //return null;
                throw ex;
            }
            finally
            {
                if (objConnection != null)
                {
                    objConnection.Close();
                    objCommand.Dispose();
                    objDSet.Dispose();
                    objDAdapter.Dispose();
                }
            }
            return objDSet;
        }
        /// <summary>
        /// Gets data from database as dataset for the input stored procedure and iterated dictionary values
        /// </summary>
        /// <param name="strStoredProcedureName">Stored procedure name as string</param>
        /// <param name="hybdParamAndValue">Hash table</param>
        /// <returns>Dataset</returns>
        public DataSet DownloadDataFromDB(string strStoredProcedureName, HybridDictionary hybdParamAndValue)
        {
            SqlDataAdapter objDAdapter = new SqlDataAdapter();
            DataSet objDSet = new DataSet();
            try
            {
                objCommand.CommandText = strStoredProcedureName;
                objCommand.Connection = objConnection;
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandTimeout = 90;
                foreach (string str in hybdParamAndValue.Keys)
                { objCommand.Parameters.AddWithValue(str, hybdParamAndValue[str]); }
                objDAdapter.SelectCommand = objCommand;
                objDAdapter.Fill(objDSet);
                return objDSet;
            }

            catch (Exception ex)
            {
                ex.HelpLink = strStoredProcedureName;    
               
                throw ex;
            }
            finally
            {
                if (objConnection != null)
                {
                    objConnection.Close();
                    objCommand.Dispose();
                    objDSet.Dispose();
                    objDAdapter.Dispose();
                }
            }
        }


        /// <summary>
        /// This method is gets the DML query, executes and returns the result
        /// </summary>
        /// <param name="sQuery">DML Query</param>
        /// <exception cref="SqlException">Problem in executing the query</exception>
        public int ExecuteCommand(SqlCommand objCmd)
        {
            command = objCmd;
            command.Connection = objConnection;
            try
            {
                command.CommandType = CommandType.StoredProcedure;

                return command.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// This method is gets the DML query, executes and returns the result
        /// </summary>
        /// <param name="sQuery">DML Query</param>
        /// <exception cref="SqlException">Problem in executing the query</exception>
        public int ExecuteCommand(string sQuery)
        {
            command = new SqlCommand(sQuery, objConnection);
            try
            {
                command.CommandType = CommandType.StoredProcedure;

                return command.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }

        }
        /// <summary>
        /// This method helps in getting the single value for the query pased
        /// </summary>
        /// <param name="sQuery">string - Query that has to be executed</param>
        /// <returns>object</returns>
        /// <exception cref="SqlException">Problem in retreiving value from database</exception>
        public object ExecuteScalar(SqlCommand objCmd)
        {
            command = objCmd;
            object objRet;
            try
            {
                command.Connection = objConnection;
                command.CommandType = CommandType.StoredProcedure;
                objRet = command.ExecuteScalar();

            }
            catch (SqlException ex)
            {
                throw ex;
            }

            return objRet;
        }

        /// <summary>
        /// This method is gets the SELECT query, executes and returns the result
        /// </summary>
        /// <param name="sQuery">string - Query tot be executed</param>
        /// <returns>Dataset - returning the fetched dataset</returns>
        public DataSet FetchData(SqlCommand objCmd)
        {
            command = objCmd;
            try
            {
                command.Connection = objConnection;
                command.CommandType = CommandType.StoredProcedure;
                sqlAdapter = new SqlDataAdapter(command);
                sqlAdapter.Fill(dSet);

                return dSet;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// This method is gets the SELECT query, executes and returns the result
        /// </summary>
        /// <param name="sQuery">string - Query tot be executed</param>
        /// <returns>Dataset - returning the fetched dataset</returns>
        public DataSet FetchData(string sQuery)
        {
            try
            {
                command = new SqlCommand();
                command.CommandText = sQuery;
                command.Connection = objConnection;
                command.CommandType = CommandType.StoredProcedure;
                sqlAdapter = new SqlDataAdapter(command);
                sqlAdapter.Fill(dSet);

                return dSet;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }


        /// <summary>
        /// This method is gets the Sqlcommand with parametsrs executes it and returns the result
        /// </summary>
        /// <param name="sQuery">SqlCommand - command which has to be executed</param>
        /// <returns>DataTable</returns>
        /// <exception cref="SqlException">Problem in fetching data from database</exception>
        public DataTable FetchDataTable(SqlCommand objCmd)
        {
            command = objCmd;
            try
            {
                command.Connection = objConnection;
                command.CommandType = CommandType.StoredProcedure;
                sqlAdapter = new SqlDataAdapter(command);
                dTable = new DataTable();
                sqlAdapter.Fill(dTable);
            }
            catch (SqlException ex)
            {
                throw ex;
            }

            return dTable;
        }



        /// <summary>
        /// This method is gets the SELECT query, executes and returns the result
        /// </summary>
        /// <param name="sQuery">string - Query to be executed</param>
        /// <returns>DataTable</returns>
        /// <exception cref="SqlException">Problem in fetching data from database</exception>
        public DataSet FetchDataSet(SqlCommand objCmd)
        {
            try
            {
                command = objCmd;
                command.Connection = objConnection;
                command.CommandType = CommandType.StoredProcedure;
                sqlAdapter = new SqlDataAdapter(command);
                sqlAdapter.Fill(dSet);
                objConnection.Close();
                return dSet;
            }
            catch (SqlException ex)
            {
                String msg = "";
                if (command.Parameters.Count > 0)
                {
                    msg += command.Parameters[0].ParameterName;
                    msg += Convert.ToString(command.Parameters[0].Value);
                    throw new Exception(msg);
                }
                else
                    throw new Exception("No Parameters passed.");
            }
        }

        /// <summary>
        /// Gets data from database as dataset for the input stored procedure and iterated dictionary values
        /// </summary>
        /// <param name="strCommandText">Command Text as string</param>
        /// <param name="hybdParamAndValue">Hashtable</param>
        /// <param name="objCommandType">Command Type</param>
        /// <returns>Dataset</returns>
        public DataSet DownloadDataFromDB(string strCommandText, HybridDictionary hybdParamAndValue, CommandType objCommandType)
        {
            SqlDataAdapter objDAdapter = new SqlDataAdapter();
            DataSet objDSet = new DataSet();
            try
            {
                objCommand.CommandText = strCommandText;
                objCommand.Connection = objConnection;
                objCommand.CommandType = objCommandType;
                objCommand.CommandTimeout = 90;
                foreach (string str in hybdParamAndValue.Keys)
                { objCommand.Parameters.AddWithValue(str, hybdParamAndValue[str]); }
                objDAdapter.SelectCommand = objCommand;
                objDAdapter.Fill(objDSet);
                return objDSet;
            }

            catch (Exception ex)
            {
                ex.HelpLink = strCommandText;
                //return null;
                throw ex;
            }
            finally
            {
                if (objConnection != null)
                {
                    objConnection.Close();
                    objCommand.Dispose();
                    objDSet.Dispose();
                    objDAdapter.Dispose();
                }
            }
        }

        /// <summary>
        /// Uploads data to database with stored procedure and iterated parameter values and returns integer for the input output parameter(OutParam).
        /// </summary>
        /// <param name="strCommandText">Command Text as string</param>
        /// <param name="hybdParamAndValue">Hash table</param>
        /// <param name="strOutParam">To get the return value with specific variable</param>
        /// <returns>Resulted type as integer</returns>
        public int UploadDataToDB(string strCommandText, HybridDictionary hybdParamAndValue)
        {
            try
            {
                objCommand.CommandText = strCommandText;
                objCommand.Connection = objConnection;
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandTimeout = 90;
                foreach (string str in hybdParamAndValue.Keys)
                { objCommand.Parameters.AddWithValue(str, hybdParamAndValue[str]); }
                if (objCommand.Connection.State == ConnectionState.Closed) { objCommand.Connection.Open(); }
                objCommand.ExecuteNonQuery();
                return 1;
            }
            catch (Exception ex)
            {
                ex.HelpLink = strCommandText;
                //return 0;
                throw ex;
            }
            finally
            {
                if (objConnection != null)
                {
                    objConnection.Close();
                    objCommand.Dispose();
                }
            }
        }
        #endregion
    }
}