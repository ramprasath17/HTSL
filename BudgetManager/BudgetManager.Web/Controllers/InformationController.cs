using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BudgetManager.Web.Controllers
{
    public class InformationController : Controller
    {
        public ActionResult Error()
        {
            ViewBag.ErrorMessage = TempData["ErrorMessage"];
            ViewBag.StackTrace = TempData["StackTrace"];
            TempData.Clear();
            return View("Error");
        }

    }
}
