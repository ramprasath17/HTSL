using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Configuration;
using System.Data.SqlClient;
using MvcApplication2.Models;
using System.Data;
using System.Web.Http.Description;
using System.Web.Http;
using System.Collections.Specialized;
using System.Web;
using System.Web.SessionState;

namespace MvcApplication2.Controllers
{
    public class SM48Controller : ApiController
    {
        // GET api/sm48
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/sm48/5
        public List<SM48BO> Get(string ProjectName, string CabinetName, string AreaName, string LocationName, string CabinetTypeName, int ModelView)
        {
            List<SM48BO> objPHSM48BO = new List<SM48BO>();
            List<GeneralClass> objIDCBO = new List<GeneralClass>();
            List<GeneralClass> objHeatDissBO = new List<GeneralClass>();
            try
            {
                DatabaseContext objDBContext = new DatabaseContext();
                HybridDictionary objHybirdTemplate = new HybridDictionary(true);
                objHybirdTemplate.Add("@ProjectName", ProjectName);
                objHybirdTemplate.Add("@CabinetName", CabinetName);
                objHybirdTemplate.Add("@AreaName", AreaName);
                objHybirdTemplate.Add("@LocationName", LocationName);
                objHybirdTemplate.Add("@CabinetTypeName", CabinetTypeName);
                objHybirdTemplate.Add("@ModelView", ModelView);
                DataSet dsTemplate = objDBContext.DownloadDataFromDB(GlobalConstants.GETPHSM48VDCps, objHybirdTemplate);
                PHControllerBO objStaffingfirmInfo = new PHControllerBO();
                string Name = "";
                if (dsTemplate != null && dsTemplate.Tables != null && dsTemplate.Tables.Count > 0 && dsTemplate.Tables[0].Rows != null && dsTemplate.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in dsTemplate.Tables[0].Rows)
                    {
                        objIDCBO = new List<GeneralClass>();
                        objHeatDissBO = new List<GeneralClass>();
                        
                        if (ModelView ==0)
                        {
                            objIDCBO.Add(new GeneralClass { Name = "CurrentRating", Value = Formatter.ConvertToDecimal(dr["CurrentRating"]) });
                            objIDCBO.Add(new GeneralClass { Name = "IDC", Value = Formatter.ConvertToDecimal(dr["IDC"]) });
                            objHeatDissBO.Add(new GeneralClass { Name = "HeatDiss", Value = Formatter.ConvertToDecimal(dr["HeatDiss"]) });
                            Name = Formatter.ConvertToString(dr["CabinetName"]);
                        }
                        else
                        {
                            //objIDCBO.Add(new GeneralClass { Name = "CurrentRating", Value = Formatter.ConvertToDecimal(dr["CurrentRating"]) });
                            objIDCBO.Add(new GeneralClass { Name = "IDC", Value = Formatter.ConvertToDecimal(dr["IDC"]) });
                            objHeatDissBO.Add(new GeneralClass { Name = "HeatDiss", Value = Formatter.ConvertToDecimal(dr["HeatDiss"]) });
                            if (CabinetName == null || CabinetName == "")
                                Name = Formatter.ConvertToString(dr["CabinetName"]) + "/" + Formatter.ConvertToString(dr["ModuleName"]);
                            else
                                Name = Formatter.ConvertToString(dr["ModuleName"]);
                        }
                        objPHSM48BO.Add(new SM48BO { ProjectName = Formatter.ConvertToString(dr["ProjectName"]), ModuleName = Formatter.ConvertToString(dr["ModuleName"]), Date = Name, Categories = objIDCBO, LineCategory = objHeatDissBO, IDC = Formatter.ConvertToDecimal(dr["IDC"]), CurrentRating = Formatter.ConvertToDecimal(dr["CurrentRating"]), HeatDiss = Formatter.ConvertToDecimal(dr["HeatDiss"]) });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPHSM48BO;
        }
        // POST api/sm48
        public void Post([FromBody]string value)
        {
        }

        // PUT api/sm48/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/sm48/5
        public void Delete(int id)
        {
        }
    }
}
