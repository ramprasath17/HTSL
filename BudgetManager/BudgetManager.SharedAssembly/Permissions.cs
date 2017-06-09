namespace BudgetManager.SharedAssembly
{
    public static class Permissions
    {
        /// <summary>
        /// Gets or sets a value indicating whether Is IsReadable
        /// </summary>
        public static bool IsReadable { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether Is Writeable
        /// </summary>
        public static bool IsWritable { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether Is IsDeletable
        /// </summary>
        public static bool IsDeletable { get; set; }

        /// <summary>
        /// Gets a readable attribute
        /// </summary>
        public static string ReadableAttribute
        {
            get
            {
                return IsReadable ? string.Empty : "disabled = disabled";                
            }
        }

        /// <summary>
        /// Gets a writable attribute
        /// </summary>
        public static string WritableAttribute
        {
            get
            {
                return IsWritable ? string.Empty : "disabled = disabled";
            }
        }

        /// <summary>
        /// Gets a deletable attribute
        /// </summary>
        public static string DeletableAttribute
        {
            get
            {
                return IsDeletable ? string.Empty : "disabled = disabled";
            }
        }
    }
}
