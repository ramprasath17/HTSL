using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BudgetManager.SharedAssembly.BudgetEntity
{
    public class BudgetDetails
    {
        public int BudgetID { get; set; }

        public string BudgetName { get; set; }

        public string BudgetDescription { get; set; }

        public string MinimumAmount { get; set; }

        public string MaximumAmount { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public string CreatedBy { get; set; }

        public string Category { get; set; }
    }
}
