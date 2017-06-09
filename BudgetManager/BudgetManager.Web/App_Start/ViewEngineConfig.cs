namespace BudgetManager.Web.App_Start
{
    using System.Web.Mvc;
    public static class ViewEngineConfig
    {
        public static void RegisterViewEngines()
        {
            ViewEngines.Engines.Clear();
            ViewEngines.Engines.Add(new RazorViewEngine());
        }
    }
}