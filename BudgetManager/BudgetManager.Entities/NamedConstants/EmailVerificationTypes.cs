namespace BudgetManager.Entities.NamedConstants
{
    using System.ComponentModel;

    public enum EmailVerificationTypes
    {
        [Description("I")]
        InviteFriend = 1,

        [Description("S")]
        SignUp = 2,

        [Description("P")]
        PasswordReset = 3,
    }
}
