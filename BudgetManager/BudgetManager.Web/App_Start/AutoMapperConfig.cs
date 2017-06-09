namespace BudgetManager.Web.App_Start
{
    using AutoMapper;
    using BudgetManager.SharedAssembly.Account;
    using BudgetManager.SharedAssembly.TransactionEntity;
    using BudgetManager.Web.Areas.Expenses.Models;
    using BudgetManager.Web.Models;

    public static class AutoMapperConfig
    {
        public static void Configure()
        {
            Mapper.CreateMap<AccountSettingsViewModel, UserInformation>();
            Mapper.CreateMap<TransactionAnalysisViewModel, AnalysisQuery>()
                .ForMember(dest=>dest.Action, m => m.MapFrom<int?>(field => field.SelectedActionType))
                .ForMember(dest=>dest.User1, m => m.MapFrom<string>(field => field.SelectedFirstUserId))
                .ForMember(dest=>dest.User2, m => m.MapFrom<string>(field => field.SelectedSecondUserId))
                .ForMember(dest=>dest.GroupId, m => m.MapFrom<int?>(field => field.SelectedGroupId))
                .ForMember(dest => dest.ExpenseId, m => m.MapFrom<int?>(field => field.SelectedExpenseId));
        }
    }
}