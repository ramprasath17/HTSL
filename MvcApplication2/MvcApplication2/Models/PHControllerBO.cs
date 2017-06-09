using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcApplication2.Models
{
    public class PHControllerBO
    {
        public Guid ProjectId { get; set; }
        public string ProjectName { get; set; }

        public Guid CabinetId { get; set; }
        public string CabinetName { get; set; }

        public string Area { get; set; }

        public string Location { get; set; }

        public string CabinetTypeName { get; set; }

    }
}
