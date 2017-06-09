namespace BudgetManager.Entities.NamedConstants
{
    using System.ComponentModel;

    public enum StoredProceduresForUpdate
    {
        [Description("bspUpdateSelectedBudgetRecord")]
        B,

        [Description("bspUpdateSelectedUserRecord")]
        U,

        [Description("bspUpdateSelectedGroupRecord")]
        G,

        [Description("bspUpdateSelectedBudgetCategoryRecord")]
        C,

        [Description("bspUpdateExpenditures")]
        E,

        [Description("bspUpdateTransactions")]
        T
    }
}
