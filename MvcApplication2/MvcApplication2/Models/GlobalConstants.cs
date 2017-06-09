using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcApplication2.Models
{
    public class GlobalConstants
    {
        #region SPConstant

        public const String GET_PHProject = "sp_GETPHProjectName";
        public const String GET_Chart_POC = "SP_PHT_POC_Project";
        public const String GETPHCabinetName = "sp_GETPHCabinetName";
        public const String GETPHArea = "sp_GETPHArea";
        public const String GETPHLocation = "sp_GETPHLocation";
        public const String GETPHCabinetTypeName = "sp_GETPHCabinetTypeName";
        //DCS
        public const String GETPHFRONTps = "sp_GETPHFRONTps";
        public const String GETPHREARps = "sp_GETPHREARps";
        //SM
        public const String GETPHSM24VDCps = "sp_GETPH24VDCps";
        public const String GETPHSM48VDCps = "sp_GETPH48VDCps";
        public const String GETPHSM60VDCps = "sp_GETPH60VDCps";
        public const String GETPHSM110VDCps = "sp_GETPH110VDCps";
        #endregion



    }
}