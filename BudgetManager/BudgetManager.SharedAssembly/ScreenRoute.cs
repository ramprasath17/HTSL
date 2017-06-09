namespace BudgetManager.SharedAssembly
{
    /// <summary>
    /// Screen route data
    /// </summary>
    public class ScreenRoute
    {
        /// <summary>
        /// Gets or sets Action name
        /// </summary>
        public string ActionName { get; set; }

        /// <summary>
        /// Gets or sets Area
        /// </summary>
        public string AreaName { get; set; }

        /// <summary>
        /// Gets or sets Controller
        /// </summary>
        public string ControllerName { get; set; }

        /// <summary>
        /// Gets or sets link text
        /// </summary>
        public string LinkText { get; set; }

        /// <summary>
        /// Gets or sets group menu title
        /// </summary>
        public string GroupMenuTitle { get; set; }

        /// <summary>
        /// Gets or sets read.
        /// </summary>
        public bool Read { get; set; }

        /// <summary>
        /// Gets or sets write.
        /// </summary>
        public bool Write { get; set; }

        /// <summary>
        /// Gets or sets delete.
        /// </summary>
        public bool Delete { get; set; }
    }
}
