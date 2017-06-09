namespace BudgetManager.SharedAssembly.Attributes
{
    using System;

    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class BindAttribute : Attribute
    {
        public bool Bind
        {
            get
            {
                return _bind;
            }
        }

        public int Order { get; set; }

        private bool _bind { get; set; }

        public BindAttribute(bool bind)
        {
            this._bind = bind;
        }
    }
}
