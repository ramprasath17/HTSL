using BudgetManager.Entities;
using BudgetManager.Entities.NamedConstants;
using BudgetManager.Infrastructure.Helpers;
using BudgetManager.Repository.Interface;
using BudgetManager.Security.UserSessionHandler;
using BudgetManager.Web.ActionFilters;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace BudgetManager.Web.Controllers
{
    public class ComponentActionController : Controller
    {
        /// <summary>
        /// Common action Repository
        /// </summary>
        ICommonRepository commonRepository;

        /// <summary>
        /// User session
        /// </summary>
        private readonly IUserSession userSession;

        /// <summary>
        /// Initialises new instance of <see cref="ComponentActionController"/>
        /// </summary>
        /// <param name="commonRepository"></param>
        public ComponentActionController(ICommonRepository commonRepository, IUserSession userSession)
        {
            this.commonRepository = commonRepository;
            this.userSession = userSession;
        }
        /// <summary>
        /// Delete the selected record 
        /// </summary>
        /// <param name="recordId">Record Id</param>
        /// <returns></returns>
        [PermissionActionFilter(false)]
        public JsonResult DeleteSelectedItem(string recordId, char componentType)
        {
            commonRepository.deleteSelectedComponentRecord(recordId, componentType);
            return Json(string.Empty, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Save Edited Data
        /// </summary>
        /// <param name="saveData">Data to Save</param>
        /// <returns>Json</returns>        
        [PermissionActionFilter(false)]
        public JsonResult UpdateSelectedComponentRecord(string saveData, char componentType)
        {
            var jsSerializer = new JavaScriptSerializer();
            Dictionary<string, object> updateData = jsSerializer.Deserialize<Dictionary<string, object>>(saveData.Replace("[", "").Replace("]", ""));
            updateData["CompanyId"] = userSession.CompanyId;
            string procedureName = EnumExtensions.GetEnumAttributeFromValue<StoredProceduresForUpdate>(Convert.ToString(componentType));            
            commonRepository.UpdateSelectedComponentRecord(updateData, updateData.Count, procedureName);            
            return Json(string.Empty, JsonRequestBehavior.AllowGet);
        }
    }
}
