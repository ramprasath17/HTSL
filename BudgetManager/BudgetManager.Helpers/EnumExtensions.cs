namespace BudgetManager.Infrastructure.Helpers
{
    using BudgetManager.Helpers;
    using System;
    using System.ComponentModel;
    using System.Reflection;

    public static class EnumExtensions
    {
        /// <summary>
        /// Get enum attribute value from enum string value.
        /// </summary>
        /// <typeparam name="TSource"></typeparam>
        /// <param name="enumValue"></param>
        /// <returns></returns>
        public static string GetEnumAttributeFromValue<TSource>(this string enumValue, EnumAttributeTypes attributeType = EnumAttributeTypes.Description) where TSource : struct
        {
            return GetAttributeValue<TSource>(enumValue, attributeType);
        }

        /// <summary>
        /// Get enum attribute value input object value.
        /// </summary>
        /// <typeparam name="TSource"></typeparam>
        /// <param name="enumValue"></param>
        /// <param name="attributeType"></param>
        /// <returns></returns>
        public static string GetEnumAttributeFromValue<TSource>(this object enumValue, EnumAttributeTypes attributeType = EnumAttributeTypes.Description) where TSource : struct
        {
            string stringEnum = enumValue.GetDefaultValueIfNull<string>();
            return GetAttributeValue<TSource>(stringEnum, attributeType);
        }

        /// <summary>
        /// Get enum attribute value from enum type.
        /// </summary>
        /// <typeparam name="TSource"></typeparam>
        /// <param name="enumValue"></param>
        /// <param name="attributeType"></param>
        /// <returns></returns>
        public static string GetEnumAttributeFromValue<TSource>(this TSource enumValue, EnumAttributeTypes attributeType = EnumAttributeTypes.Description) where TSource : struct
        {
            return GetAttributeValue<TSource>(Convert.ToString(enumValue), attributeType);
        }

        /// <summary>
        /// Get attribute value.
        /// </summary>
        /// <typeparam name="TSource"></typeparam>
        /// <param name="enumValue"></param>
        /// <param name="attributeType"></param>
        /// <returns></returns>
        internal static string GetAttributeValue<TSource>(string enumValue, EnumAttributeTypes attributeType) where TSource : struct
        {
            TSource tValue;
            if (Enum.TryParse<TSource>(enumValue, true, out tValue))
            {
                if (attributeType.Equals(EnumAttributeTypes.Description))
                {
                    return AttributeExtensions.GetDescriptionAttribute<TSource>(tValue);
                }
                else if (attributeType.Equals(EnumAttributeTypes.Category))
                {
                    return AttributeExtensions.GetCategoryAttribute<TSource>(tValue);
                }
                else if (attributeType.Equals(EnumAttributeTypes.DisplayIcon))
                {
                    return AttributeExtensions.GetDisplayIconAttribute<TSource>(tValue);
                }
                else if (attributeType.Equals(EnumAttributeTypes.ReportDefinition))
                {
                    return AttributeExtensions.GetReportDefinitionAttribute<TSource>(tValue);
                }

                return AttributeExtensions.GetDescriptionAttribute<TSource>(tValue);
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// Convert input string to repesctive enum value
        /// </summary>
        /// <typeparam name="TEnum">Enum type.</typeparam>
        /// <param name="inputString">Input string.</param>
        /// <returns>Out enum value</returns>
        public static TEnum ConvertToEnum<TEnum>(this string inputString, bool ignoreCase = true) where TEnum : struct
        {
            TEnum outputEnum;
            if (Enum.TryParse<TEnum>(inputString, out outputEnum))
            {
                return outputEnum;
            }

            return default(TEnum);
        }
    }
}
