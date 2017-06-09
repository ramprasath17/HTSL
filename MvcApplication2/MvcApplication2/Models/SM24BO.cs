using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcApplication2.Models
{
    public class SM24BO
    {
        /// <summary>
        /// Gets or Sets ProjectName
        /// </summary>
        public string ProjectName { get; set; }
        /// <summary>
        /// Gets or Sets ModuleName
        /// </summary>
        public string ModuleName { get; set; }
        /// <summary>
        /// Gets or Sets CabinetName
        /// </summary>
        public string CabinetName { get; set; }
        /// <summary>
        /// Gets or Sets HeatDiss
        /// </summary>
        public decimal HeatDiss { get; set; }
        /// <summary>
        /// Gets or Sets IDC
        /// </summary>
        public decimal IDC { get; set; }

        /// <summary>
        /// Gets or Sets CurrentRating
        /// </summary>
        public decimal CurrentRating { get; set; }

        public string Date { get; set; }
        public List<GeneralClass> Categories { get; set; }
        public List<GeneralClass> LineCategory { get; set; }
    }
}