namespace BudgetManager.Helpers
{   
    using System;
    using System.ComponentModel;
    using System.Reflection;
    using BudgetManager.Entities.EntityAttributes;

    public static class AttributeExtensions
    {
        /// <summary>
        /// Get custom attribute.
        /// </summary>
        /// <typeparam name="T">The attribute type</typeparam>
        /// <param name="methodInfo">The method info</param>
        /// <returns>The attribute object.</returns>
        public static T GetCustomAttribute<T>(this MethodInfo methodInfo) where T : Attribute
        {
            return (T)Attribute.GetCustomAttribute(methodInfo, typeof(T));
        }

        /// <summary>
        /// Get custom attribute.
        /// </summary>
        /// <typeparam name="T">The attribute type</typeparam>
        /// <param name="memberInfo">The memeber info</param>
        /// <returns>The attribute object.</returns>
        public static T GetCustomAttribute<T>(this MemberInfo memberInfo) where T : Attribute
        {
            return (T)Attribute.GetCustomAttribute(memberInfo, typeof(T));
        }

        /// <summary>
        /// Get the description of the enum value
        /// </summary>
        /// <typeparam name="TSource">Input type</typeparam>
        /// <param name="source">Input enum value</param>
        /// <returns>Description of enum value</returns>
        public static string GetDescriptionAttribute<TSource>(TSource source) where TSource : struct
        {
            FieldInfo fi = source.GetType().GetField(source.ToString());

            DescriptionAttribute[] attributes = (DescriptionAttribute[])fi.GetCustomAttributes(
                typeof(DescriptionAttribute), false);

            if (attributes != null && attributes.Length > 0) return attributes[0].Description;
            else return source.ToString();
        }

        /// <summary>
        /// Get the category of the enum value
        /// </summary>
        /// <typeparam name="TSource">Input type</typeparam>
        /// <param name="source">Input enum value</param>
        /// <returns>Category of enum value</returns>
        public static string GetCategoryAttribute<TSource>(TSource source) where TSource : struct
        {
            FieldInfo fi = source.GetType().GetField(source.ToString());

            CategoryAttribute[] attributes = (CategoryAttribute[])fi.GetCustomAttributes(
                typeof(CategoryAttribute), false);

            if (attributes != null && attributes.Length > 0) return attributes[0].Category;
            else return source.ToString();
        }

        /// <summary>
        /// Get the category of the enum value
        /// </summary>
        /// <typeparam name="TSource">Input type</typeparam>
        /// <param name="source">Input enum value</param>
        /// <returns>Icon attribute value of enum value</returns>
        public static string GetDisplayIconAttribute<TSource>(TSource source) where TSource : struct
        {
            FieldInfo fi = source.GetType().GetField(source.ToString());

            DisplayIconAttribute[] attributes = (DisplayIconAttribute[])fi.GetCustomAttributes(
                typeof(DisplayIconAttribute), false);

            if (attributes != null && attributes.Length > 0) return attributes[0].Icon;
            else return source.ToString();
        }

        /// <summary>
        /// Get the report definition file name .
        /// </summary>
        /// <typeparam name="TSource">Input type</typeparam>
        /// <param name="source">Input enum value</param>
        /// <returns>Report definition attribute value of enum.</returns>
        public static string GetReportDefinitionAttribute<TSource>(TSource source) where TSource : struct
        {
            FieldInfo fi = source.GetType().GetField(source.ToString());

            ReportDefinitionAttribute[] attributes = (ReportDefinitionAttribute[])fi.GetCustomAttributes(
                typeof(ReportDefinitionAttribute), false);

            if (attributes != null && attributes.Length > 0) return attributes[0].Name;
            else return source.ToString();
        }

        /// <summary>
        /// Get the category of the enum value
        /// </summary>
        /// <typeparam name="TSource">Input type</typeparam>
        /// <param name="source">Input enum value</param>
        /// <returns>Category of enum value</returns>
        public static TAttribute GetCustomAttribute<TAttribute, TSource>(this TSource source)
            where TAttribute : Attribute
            where TSource : struct
        {
            FieldInfo fi = source.GetType().GetField(source.ToString());

            TAttribute attributes = (TAttribute)fi.GetCustomAttribute(
                typeof(TAttribute), false);

            return attributes;
        }

        /// <summary>
        /// Get the property value of attribute.
        /// </summary>
        /// <typeparam name="TAttribute">Attribute type.</typeparam>
        /// <typeparam name="TSource">Source object type.</typeparam>
        /// <param name="source">Source object.</param>
        /// <param name="propertyName">Property name</param>
        /// <returns>Property value.</returns>
        public static object GetAttributePropertyValue<TSource, TAttribute>(this TSource source, string propertyName)            
            where TSource : struct
            where TAttribute : Attribute
        {
            FieldInfo fi = source.GetType().GetField(source.ToString());

            TAttribute attributes = (TAttribute)fi.GetCustomAttribute(
                typeof(TAttribute), false);

            TAttribute propertySource = default(TAttribute);
            PropertyInfo[] propertyInfo = attributes.GetType().GetProperties();
            return attributes.GetType().GetProperty(propertyName).GetValue(propertySource);         
        }
    }
}
