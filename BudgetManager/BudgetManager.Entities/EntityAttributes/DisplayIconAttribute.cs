namespace BudgetManager.Entities.EntityAttributes
{
    using BudgetManager.Entities.NamedConstants;
    using System;

    public class DisplayIconAttribute : Attribute
    {
        /// <summary>
        /// Gets or sets icon
        /// </summary>
        public string Icon { get; set; }

        /// <summary>
        /// Initialises a new instance of <see cref="DisplayIconAttribute"/>
        /// </summary>
        /// <param name="icon"></param>
        public DisplayIconAttribute(string icon)
        {
            this.Icon = icon;
        }

        /// <summary>
        /// Initialises a new instance of <see cref="DisplayIconAttribute"/>
        /// </summary>
        /// <param name="faviconIcon"></param>
        public DisplayIconAttribute(FontIcons faviconIcon)
        {
            this.Icon = faviconIcon.ToString();
        }
    }
}
