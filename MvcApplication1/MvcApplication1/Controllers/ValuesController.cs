using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Configuration;
using System.Data.SqlClient;
using MvcApplication1.Models;
using System.Data;

using System.Collections.Specialized;
using System.Web;
using System.Web.SessionState;
namespace MvcApplication1.Controllers
{
    public class ValuesController : ApiController
    {
        // GET api/values
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        
        public List<PHControllerBO> LoadtblPHProjectName()
        {
            List<PHControllerBO> objPHControllerBO = new List<PHControllerBO>();

            try
            {
                DatabaseContext objDBContext = new DatabaseContext();
                HybridDictionary objHybirdTemplate = new HybridDictionary(true);

                DataSet dsTemplate = objDBContext.DownloadDataFromDB(GlobalConstants.GET_PHProject, objHybirdTemplate);
                PHControllerBO objStaffingfirmInfo = new PHControllerBO();
                if (dsTemplate != null && dsTemplate.Tables != null && dsTemplate.Tables.Count > 0 && dsTemplate.Tables[0].Rows != null && dsTemplate.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in dsTemplate.Tables[0].Rows)
                    {
                        objPHControllerBO.Add(new PHControllerBO { ProjectId = Formatter.ConvertToGuid(dr["ProjectId"]), ProjectName = Formatter.ConvertToString(dr["ProjectName"]) });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPHControllerBO;
        }


//            public List<PHControllerBO> LoadtblPHProjectName1()
//        {
//            List<PHControllerBO> objPHControllerBO = new List<PHControllerBO>();
//var connectionString=ConfigurationManager.ConnectionStrings["IntaaseConnection"].ConnectionString;

//            try
//            { using (SqlConnection connection = new SqlConnection(connectionString))
//    {
//        connection.Open();
//              string  str = "select * from employee";
//               SqlCommand com = new SqlCommand(str, connection);
//                SqlDataAdapter sqlda = new SqlDataAdapter(com);
//                DataTable dsTemplate = new DataTable();
//                sqlda.Fill(dsTemplate);
               
//                PHControllerBO objStaffingfirmInfo = new PHControllerBO();
//                if (dsTemplate != null && dsTemplate.Rows.Count > 0)
//                {
//                    foreach (DataRow dr in dsTemplate.Rows)
//                    {
//                        objPHControllerBO.Add(new PHControllerBO { ProjectId = Formatter.ConvertToGuid(dr["ProjectId"]), ProjectName = Formatter.ConvertToString(dr["ProjectName"]) });
//                    }

//                }
//                connection.Close();
//            }
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//            return objPHControllerBO;
//        }


//        }


        // GET api/values/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        public void Post([FromBody]string value)
        {
        }

        // PUT api/values/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }
    }
}