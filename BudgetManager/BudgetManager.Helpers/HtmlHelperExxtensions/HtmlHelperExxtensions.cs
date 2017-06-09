namespace BudgetManager.Helpers.HtmlHelperExxtensions
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Linq.Expressions;
    using System.Text;
    using System.Web;
    using System.Web.Mvc;
    using System.Web.Mvc.Html;
    using BudgetManager.Infrastructure.Helpers;

    public static class HtmlHelperExtensions
    {
        /// <summary>
        /// Gets the Text Box with action permissions
        /// </summary>
        /// <typeparam name="TModel">Model type</typeparam>
        /// <typeparam name="TProperty">Property type</typeparam>
        /// <param name="htmlHelper">Html helper</param>
        /// <param name="expression">Expression</param>
        /// <param name="htmlAttributes">Html attributes</param>
        /// <returns>Html string</returns>
        public static MvcHtmlString TextBoxWithPermissionFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty>> expression, object htmlAttributes)
        {
            var isWritableSession = HttpContext.Current.Session["IsWritable"];
            bool isWritable = isWritableSession != null ? TypeConversionHelper.GetDefaultValueIfNull<bool>(isWritableSession) : false;
            if (isWritable)
            {
                return System.Web.Mvc.Html.InputExtensions.TextBoxFor<TModel, TProperty>(htmlHelper, expression,
                    htmlAttributes: htmlAttributes);
            }

            ModelMetadata fieldmetadata = ModelMetadata.FromLambdaExpression(expression, htmlHelper.ViewData);
            return new MvcHtmlString(Convert.ToString(fieldmetadata.Model));
        }

        /// <summary>
        /// Gets the dropdown list with action permission
        /// </summary>
        /// <typeparam name="TModel">Model type.</typeparam>
        /// <typeparam name="TProperty">Property type.</typeparam>
        /// <param name="htmlHelper">Html helper</param>
        /// <param name="optionLabel">Option label</param>
        /// <param name="expression">Expression to evaluate.</param>
        /// <param name="selectList">Select list</param>
        /// <param name="selectedItem">Selected item.</param>
        /// <param name="iconClass">Icon class</param>
        /// <param name="htmlAttributes">Html attributes.</param>
        /// <returns>Dropdown list</returns>
        public static MvcHtmlString DropDownListWithPermission<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, string optionLabel, Expression<Func<TModel, TProperty>> expression, IEnumerable<SelectListItem> selectList, string selectedItem, string iconClass, object htmlAttributes)
        {
            var isWritableSession = HttpContext.Current.Session["IsWritable"];
            bool isWritable = isWritableSession != null ? TypeConversionHelper.GetDefaultValueIfNull<bool>(isWritableSession) : false;
            if (isWritable)
            {
                return SelectExtensions.DropDownListFor(htmlHelper, expression, selectList, optionLabel, htmlAttributes);
            }
            StringBuilder outputHtmlString = new StringBuilder();

            if (!string.IsNullOrWhiteSpace(iconClass))
            {
                outputHtmlString.AppendLine("<i class='" + HttpUtility.HtmlEncode(iconClass) + "'></i>");
            }

            outputHtmlString.AppendLine(selectedItem);
            return new MvcHtmlString(outputHtmlString.ToString());
        }

        /// <summary>
        /// Enum dropdown list
        /// </summary>
        /// <typeparam name="TModel">Model type</typeparam>
        /// <typeparam name="TProperty">Property type.</typeparam>
        /// <typeparam name="TEnum">Enum type.</typeparam>
        /// <param name="htmlHelper">Html helper</param>
        /// <param name="expression">Expression to evaluate.</param>
        /// <param name="selectedValue">Selected value.</param>
        /// <param name="optionLabel">Option label.</param>
        /// <param name="htmlAttributes">html attributes.</param>
        /// <returns></returns>
        public static MvcHtmlString EnumDropDownListFor<TModel, TProperty, TEnum>(
                    this HtmlHelper<TModel> htmlHelper,
                    Expression<Func<TModel, TProperty>> expression,
                    TEnum selectedValue,
            string optionLabel,
            object htmlAttributes)
        {
            IEnumerable<SelectListItem> items = Enum.GetValues(typeof(TEnum)).Cast<TEnum>().Select(enumvalues => new SelectListItem
            {
                Text = enumvalues.ToString(),
                Value = ((int)Enum.Parse(typeof(TEnum), enumvalues.ToString())).ToString()
            });
            return SelectExtensions.DropDownListFor(htmlHelper, expression, items, optionLabel, htmlAttributes: htmlAttributes);
        }

        /// <summary>
        /// Is Writable
        /// </summary>
        /// <param name="htmlhelper">Html helper</param>
        /// <returns>Is writable or not</returns>
        public static bool IsWritable(this HtmlHelper htmlhelper)
        {
            var isWritableSession = HttpContext.Current.Session["IsWritable"];
            return isWritableSession != null ? TypeConversionHelper.GetDefaultValueIfNull<bool>(isWritableSession) : false;
        }

        /// <summary>
        /// Is Readable
        /// </summary>
        /// <param name="htmlhelper">Html helper</param>
        /// <returns>Is Readable or not</returns>
        public static bool IsReadable(this HtmlHelper htmlhelper)
        {
            var isReadableSession = HttpContext.Current.Session["IsReadable"];
            return isReadableSession != null ? TypeConversionHelper.GetDefaultValueIfNull<bool>(isReadableSession) : false;
        }

        /// <summary>
        /// Is Readable
        /// </summary>
        /// <param name="htmlhelper">Html helper</param>
        /// <returns>Is Readable or not</returns>
        public static bool IsDeletable(this HtmlHelper htmlhelper)
        {
            var isDeletableSession = HttpContext.Current.Session["IsDeletable"];
            return isDeletableSession != null ? TypeConversionHelper.GetDefaultValueIfNull<bool>(isDeletableSession) : false;
        }
    }
}
