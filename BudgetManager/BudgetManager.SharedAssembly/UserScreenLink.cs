namespace BudgetManager.SharedAssembly
{
    public class UserScreenLink : ScreenRoute
    {
        /// <summary>
        /// Gets or sets Action link text
        /// </summary>
        public string ActionLinkText { get; set; }

        /// <summary>
        /// Gets or sets the link order id
        /// </summary>
        public int? LinkOrderId { get; set; }

        /// <summary>
        /// Gets or sets the link icon
        /// </summary>
        public string LinkIcon { get; set; }

        /// <summary>
        /// Gets or sets screen id
        /// </summary>
        public int ScreenID { get; set; }

        /// <summary>
        /// Gets or sets group menu title
        /// </summary>
        public string GroupMenuTitle { get; set; }
    }
}
