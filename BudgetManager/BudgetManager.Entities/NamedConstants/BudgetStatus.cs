namespace BudgetManager.Entities.NamedConstants
{
    using BudgetManager.Entities.EntityAttributes;    
    using System.ComponentModel;

    public enum BudgetStatus
    {
        [DisplayIcon("icon-circle yellow")]
        [Description("Status unknown")]
        UnKnown = 0,

        [DisplayIcon("icon-circle green")]
        [Description("Currently active")]
        Active = 1,

        [DisplayIcon("icon-circle red")]
        [Description("Expired")]
        Expired = 2
    }
}
