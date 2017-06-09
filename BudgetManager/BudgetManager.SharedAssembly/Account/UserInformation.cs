namespace BudgetManager.SharedAssembly.Account
{
    using BudgetManager.SharedAssembly.Attributes;

    public class UserInformation
    {
        [Bind(false, Order = 1)]
        public string UserId { get; set; }

        [Bind(true, Order = 1)]
        public string UserName { get; set; }

        [Bind(true, Order = 2)]
        public string FirstName { get; set; }

        [Bind(true, Order = 4)]
        public string LastName { get; set; }

        [Bind(true, Order = 3)]
        public string MiddleName { get; set; }

        [Bind(true, Order = 5)]
        public string PetName { get; set; }        

        [Bind(true, Order = 9)]
        public string DateOfBirth { get; set; }

        [Bind(true, Order = 14)]
        public string Gender { get; set; }

        [Bind(false, Order = 1)]
        public string Email { get; set; }

        [Bind(true, Order = 12)]
        public string Phone { get; set; }

        [Bind(true, Order = 17)]
        public string CurrentPassword { get; set; }

        [Bind(true, Order = 18)]
        public string NewPassword { get; set; }

        [Bind(false, Order = 0)]
        public string ConfirmPassword { get; set; }

        [Bind(false, Order = 1)]
        public bool AllowInvites { get; set; }

        [Bind(false, Order = 1)]
        public string CompanyName { get; set; }

        [Bind(true, Order = 6)]
        public string AddressLine1 { get; set; }

        [Bind(true, Order = 7)]
        public string AddressLine2 { get; set; }

        [Bind(true, Order = 8)]
        public string City { get; set; }

        [Bind(true, Order = 10)]
        public string PinCode { get; set; }

        [Bind(true, Order = 11)]
        public string Country { get; set; }

        [Bind(true, Order = 13)]
        public string Mobile { get; set; }

        [Bind(true, Order = 20)]
        public int CompanyId { get; set; }

        [Bind(true, Order = 15)]
        public string SecretQuestion { get; set; }

        [Bind(true, Order = 16)]
        public string SecretAnswer { get; set; }

        [Bind(true, Order = 19)]
        public string ShowPetName { get; set; }
    }
}
