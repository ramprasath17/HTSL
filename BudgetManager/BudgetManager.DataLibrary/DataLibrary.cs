namespace BudgetManager.DataLibrary
{
    using System;
    using System.Data;
    using System.Configuration;
    using System.Data.SqlClient;
    using BudgetManagerLibrary.DataConnectionProvider;

    public static class DataLibrary
    {
        static SqlConnection objSqlConn = null;
        public static SqlCommand objSqlCmd = null;
        static SqlDataAdapter objSqladpt = null;
        static SqlCommandBuilder objCmdBuilder = null;
        static DataSet objDs = null;
        static SqlDataReader objSqlRdr;

        /// <summary>
        /// Creates a parameter collection for the stored procedure.
        /// </summary>
        /// <param name="inputParm">Parameter Collection.</param>
        /// <param name="storedProcedureName">Name of the Stored Procedure.</param>
        /// <param name="objConn">Connection object.</param>
        /// <param name="objCmd">Sql Command Object</param>
        /// <param name="objAdptr">Sql Data Adapter object</param>
        /// <param name="objCmdBldr">SQl Command Builder object</param>
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
        static void AddParameters(object[] inputParm, string storedProcedureName, ref SqlConnection objConn, ref SqlCommand objCmd, ref SqlDataAdapter objAdptr, ref SqlCommandBuilder objCmdBldr)
        {
            objSqlConn = new SqlConnection(Convert.ToString(ConfigurationManager.AppSettings["BMConnection"]));
            objCmd = new SqlCommand(storedProcedureName, objSqlConn);
            objAdptr = new SqlDataAdapter(objCmd);
            objCmdBldr = new SqlCommandBuilder(objAdptr);
            objCmd.CommandType = CommandType.StoredProcedure;
            objSqlConn.Open();
            try
            {
                if (inputParm.Length != 0)
                {
                    SqlCommandBuilder.DeriveParameters(objCmd);
                    int cmdCount = objSqlCmd.Parameters.Count;
                    for (int index = 1; index < cmdCount; index++)
                    {
                        objSqlCmd.Parameters[index].Value = inputParm[index - 1];
                    }
                }
            }
            catch (Exception ex)
            {
            }

        }

        /// <summary>
        /// Kill Objects that are no longer in use.
        /// </summary>
        static void killObjects()
        {
            if (objSqlConn.State == ConnectionState.Open)
            {
                objSqlConn.Close();
                objSqlConn.Dispose();
            }
            objCmdBuilder = null;
            objSqladpt = null;
            objSqlCmd = null;
            objSqlConn = null;
        }

        /// <summary>
        /// Kill the reader objects.
        /// </summary>
        static void killReaderObject()
        {
            objCmdBuilder = null;
            objSqladpt = null;
            objSqlCmd = null;
            objSqlConn = null;
        }

        /// <summary>
        /// Execute the reader with stored procedure having input params.
        /// </summary>
        /// <param name="inputParm">Parameter collection</param>
        /// <param name="storedProcedureName">Name of the stored procedure.</param>
        /// <returns>Returns reader object.</returns>
        static public SqlDataReader ExecuteReaderSql(ref object[] inputParm, string storedProcedureName)
        {
            try
            {
                AddParameters(inputParm, storedProcedureName, ref objSqlConn, ref objSqlCmd, ref objSqladpt, ref objCmdBuilder);
                objSqlRdr = objSqlCmd.ExecuteReader(CommandBehavior.CloseConnection);
            }
            catch (Exception ex)
            {
                string strMsg = ex.Message;
                throw ex;
            }
            finally
            {
                killReaderObject();
            }
            return objSqlRdr;
        }

        /// <summary>
        /// Execute the reader with stored procedure with no input params.
        /// </summary>
        /// <param name="inputParm">Parameter collection</param>
        /// <param name="storedProcedureName">Name of the stored procedure.</param>
        /// <returns>Returns reader object.</returns>
        static public SqlDataReader ExecuteReaderSql(string storedProcedureName)
        {
            try
            {
                AddParameters(new object[0], storedProcedureName, ref objSqlConn, ref objSqlCmd, ref objSqladpt, ref objCmdBuilder);
                objSqlRdr = objSqlCmd.ExecuteReader(CommandBehavior.CloseConnection);
            }
            catch (Exception ex)
            {
                string strMsg = ex.Message;
                throw ex;
            }
            finally
            {
                killReaderObject();
            }
            return objSqlRdr;
        }

        /// <summary>
        /// Executes a stored procedure with input parameter and returns a data set
        /// </summary>
        /// <param name="inputParm">Parameter Collection.</param>
        /// <param name="storedProcedureName">Name of the stored procedure.</param>
        /// <returns>Return a dataset</returns>
        public static DataSet ExecuteDataSet(ref object[] inputParm, string storedProcedureName)
        {
            try
            {
                AddParameters(inputParm, storedProcedureName, ref objSqlConn, ref objSqlCmd, ref objSqladpt, ref objCmdBuilder);
                objDs = new DataSet();
                objSqladpt.Fill(objDs, storedProcedureName);
            }
            catch (Exception ex)
            {
                string s = string.Empty;
                throw ex;
            }
            finally
            {
                killObjects();
            }
            return objDs;
        }

        /// <summary>
        /// Executes a stored procedure with no input parameters
        /// </summary>
        /// <param name="storedProcedureName">Name of the Stored Procedure.</param>
        /// <returns>Returns a dataset.</returns>
        public static DataSet ExecuteDataSet(string storedProcedureName)
        {
            try
            {
                AddParameters(new object[0], storedProcedureName, ref objSqlConn, ref objSqlCmd, ref objSqladpt, ref objCmdBuilder);
                objDs = new DataSet();
                objSqladpt.Fill(objDs, storedProcedureName);
            }
            catch (Exception ex)
            {
                string s = string.Empty;
                throw ex;
            }
            finally
            {
                killObjects();
            }
            return objDs;

        }

        /// <summary>
        /// Executes the stored Procedure and returns no result set.
        /// </summary>
        /// <param name="inputParm">Parameter Collection.</param>
        /// <param name="storedProcedureName">Name of the Stored Procedure.</param>
        /// <returns>Returns the no. of rows affected which is integer type.</returns>
        public static int ExecuteQuery(ref object[] inputParm, string storedProcedureName)
        {
            int rowsAffected = -1;
            try
            {
                AddParameters(inputParm, storedProcedureName, ref objSqlConn, ref objSqlCmd, ref objSqladpt, ref objCmdBuilder);
                rowsAffected = objSqlCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                string s = string.Empty;
                throw ex;
            }
            finally
            {
                killObjects();
            }
            return rowsAffected;
        }

        public static SqlConnection OpenConnection()
        {
            return new SqlConnection(Convert.ToString(ConfigurationManager.AppSettings["BMConnection"]));
        }

        public static void CloseConnection()
        {
            if (objSqlConn.State == ConnectionState.Open)
            {
                objSqlConn.Close();
            }
        }

        /// <summary>
        /// Execute PRocedure With Defined Parameters
        /// </summary>
        /// <param name="objSqlCmd">SQL Command Object</param>
        /// <param name="storedProcedureName">Stored Procedure Name</param>
        public static void ExecuteProcedureWithDefinedParameters(SqlCommand objSqlCmd, string storedProcedureName)
        {
            try
            {
                objSqlConn = OpenConnection();
                objSqlConn.Open();
                objSqlCmd.CommandText = storedProcedureName;
                objSqlCmd.Connection = objSqlConn;
                objSqlCmd.ExecuteNonQuery();
                killObjects();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
