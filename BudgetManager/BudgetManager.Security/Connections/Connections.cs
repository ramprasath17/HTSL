
namespace BudgetManagerLibrary
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Configuration;
    using System.Data;
    using System.Data.SqlClient;

    class Connections
    {
       static string connString =Convert.ToString( ConfigurationSettings.AppSettings["ConnString"]);
      //static SqlConnection objSqlConn = null;
        public static bool OpenConnection(ref SqlConnection objSqlConn)
        {
            try
            {
                objSqlConn = new SqlConnection(connString);
                if(objSqlConn.State==ConnectionState.Closed)
                    objSqlConn.Open();
                return true;
            }
            catch (Exception ex)
            { }
            return false; 
        }
        public static void CloseConnection(ref SqlConnection objSqlConn)
        {
            try
            {
                if (objSqlConn.State == ConnectionState.Open)
                {
                    objSqlConn.Close();
                }
            }
            catch (Exception ex)
            { }
            
        }
    }
}
