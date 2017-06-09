using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BudgetManager.Web.Controllers
{
    public class AppFitterController : Controller
    {
        //
        // GET: /AppFitter/

        public ActionResult Index()
        {
            return View();
        }

        public JsonResult CheckUserName(string userName)
        {
            var isValid = false;
            return Json(isValid, JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public ActionResult RemoteCheck()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Sample()
        {
            return View();
        }
    }
}
