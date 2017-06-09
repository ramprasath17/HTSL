namespace BudgetManager.Entities.EntityAttributes
{
    using System;

    [AttributeUsage(AttributeTargets.All, AllowMultiple = false)]
    public class ReportDefinitionAttribute : Attribute
    {
        public string Name
        {
            get
            {
                return _name;
            }
        }

        private string _name { get; set; }

        public ReportDefinitionAttribute(string name)
        {
            this._name = name;
        }
    }
}
