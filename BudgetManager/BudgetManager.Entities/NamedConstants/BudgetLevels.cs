namespace BudgetManager.Entities.NamedConstants
{
    using BudgetManager.Entities.EntityAttributes;
    using System.ComponentModel;

    public enum BudgetLevels
    {
        [DisplayIcon("icon-pause blue")]
        [Description("Spent amount is equaled with allocated amount")]
        Levelled = 0,

        [DisplayIcon("icon-arrow-down green")]
        [Description("Spent amount is under the allocated amount")]
        Under = 1,

        [DisplayIcon("icon-arrow-up red")]
        [Description("Spent amount is over the allocated amount")]
        Over = 2
    }
}
