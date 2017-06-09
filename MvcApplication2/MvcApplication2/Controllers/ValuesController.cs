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
using Newtonsoft.JsonResult;
using Newtonsoft.Json;
using System.Web.Mvc;
namespace MvcApplication2.Controllers
{
    public class ValuesController : ApiController
    {
        // GET api/values


        //public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}
        public List<PHControllerBO> Get()
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

        public List<PHControllerBO> Get(string ProjectName)
        {
            List<PHControllerBO> objPHControllerBO = new List<PHControllerBO>();

            try
            {
                DatabaseContext objDBContext = new DatabaseContext();
                HybridDictionary objHybirdTemplate = new HybridDictionary(true);
                objHybirdTemplate.Add("@ProjectName", ProjectName);
                DataSet dsTemplate = objDBContext.DownloadDataFromDB(GlobalConstants.GETPHCabinetName, objHybirdTemplate);
                PHControllerBO objStaffingfirmInfo = new PHControllerBO();
                if (dsTemplate != null && dsTemplate.Tables != null && dsTemplate.Tables.Count > 0 && dsTemplate.Tables[0].Rows != null && dsTemplate.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in dsTemplate.Tables[0].Rows)
                    {
                        objPHControllerBO.Add(new PHControllerBO { CabinetId = Formatter.ConvertToGuid(dr["CabinetID"]), CabinetName = Formatter.ConvertToString(dr["CabinetName"]) });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPHControllerBO;
        }


        public List<PHControllerBO> Get(string ProjectName, string CabinetName)
        {
            List<PHControllerBO> objPHControllerBO = new List<PHControllerBO>();

            try
            {
                DatabaseContext objDBContext = new DatabaseContext();
                HybridDictionary objHybirdTemplate = new HybridDictionary(true);
                objHybirdTemplate.Add("@ProjectName", ProjectName);
                objHybirdTemplate.Add("@CabinetName", CabinetName);
                DataSet dsTemplate = objDBContext.DownloadDataFromDB(GlobalConstants.GETPHArea, objHybirdTemplate);
                PHControllerBO objStaffingfirmInfo = new PHControllerBO();
                if (dsTemplate != null && dsTemplate.Tables != null && dsTemplate.Tables.Count > 0 && dsTemplate.Tables[0].Rows != null && dsTemplate.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in dsTemplate.Tables[0].Rows)
                    {
                        objPHControllerBO.Add(new PHControllerBO { Area = Formatter.ConvertToString(dr["Area"])});
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPHControllerBO;
        }

        public List<PHControllerBO> Get(string ProjectName, string CabinetName, string Area)
        {
            List<PHControllerBO> objPHControllerBO = new List<PHControllerBO>();

            try
            {
                DatabaseContext objDBContext = new DatabaseContext();
                HybridDictionary objHybirdTemplate = new HybridDictionary(true);
                objHybirdTemplate.Add("@ProjectName", ProjectName);
                objHybirdTemplate.Add("@CabinetName", CabinetName);
                objHybirdTemplate.Add("@AreaName", Area);
                DataSet dsTemplate = objDBContext.DownloadDataFromDB(GlobalConstants.GETPHLocation, objHybirdTemplate);
                PHControllerBO objStaffingfirmInfo = new PHControllerBO();
                if (dsTemplate != null && dsTemplate.Tables != null && dsTemplate.Tables.Count > 0 && dsTemplate.Tables[0].Rows != null && dsTemplate.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in dsTemplate.Tables[0].Rows)
                    {
                        objPHControllerBO.Add(new PHControllerBO { Location = Formatter.ConvertToString(dr["Location"]) });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPHControllerBO;
        }

        public List<PHControllerBO> Get(string ProjectName, string CabinetName, string Area, string Location)
        {
            List<PHControllerBO> objPHControllerBO = new List<PHControllerBO>();

            try
            {
                DatabaseContext objDBContext = new DatabaseContext();
                HybridDictionary objHybirdTemplate = new HybridDictionary(true);
                objHybirdTemplate.Add("@ProjectName", ProjectName);
                objHybirdTemplate.Add("@CabinetName", CabinetName);
                objHybirdTemplate.Add("@AreaName", Area);
                objHybirdTemplate.Add("@LocationName", Location);
                DataSet dsTemplate = objDBContext.DownloadDataFromDB(GlobalConstants.GETPHCabinetTypeName, objHybirdTemplate);
                PHControllerBO objStaffingfirmInfo = new PHControllerBO();
                if (dsTemplate != null && dsTemplate.Tables != null && dsTemplate.Tables.Count > 0 && dsTemplate.Tables[0].Rows != null && dsTemplate.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in dsTemplate.Tables[0].Rows)
                    {
                        objPHControllerBO.Add(new PHControllerBO { CabinetTypeName = Formatter.ConvertToString(dr["CabinetTypeName"]) });
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objPHControllerBO;
        }
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