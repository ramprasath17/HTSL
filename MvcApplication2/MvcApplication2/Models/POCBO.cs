using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcApplication2.Models
{
    public class POCBO
    {
        public List<DCSFront> lstDCSFrontBO { get; set; }
        public List<DCSRear> lstDCSRearBO { get; set; }
        public List<SM24BO> lstSM24BO { get; set; }
        public List<SM48BO> lstSM48BO { get; set; }
        public List<SM60BO> lstSM60BO { get; set; }
        public List<SM110BO> lstSM110BO { get; set; }
    }
}