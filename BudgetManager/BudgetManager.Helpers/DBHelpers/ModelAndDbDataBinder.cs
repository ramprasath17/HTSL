namespace BudgetManager.Helpers.DBHelpers
{
    using System.Linq;
    using System.Reflection;
    using BudgetManager.SharedAssembly.Attributes;

    public static class ModelAndDbDataBinder
    {
        /// <summary>
        /// Binds the Model object data to DB object.
        /// </summary>
        /// <typeparam name="TModel">Type of Model object.</typeparam>
        /// <param name="modelObject">Model object.</param>
        /// <returns>DB object as array.</returns>
        public static object[] BindModelToDBObject<TModel>(this TModel modelObject) where TModel : class
        {
            PropertyInfo[] propertyInfo = typeof(TModel).GetProperties().Where(x => x.GetCustomAttribute<BindAttribute>().Bind).OrderBy(x => x.GetCustomAttribute<BindAttribute>().Order).ToArray();
            int propertyCount = propertyInfo.Length;
            object[] dbObject = new object[propertyCount];
            int count = 0;
            foreach (PropertyInfo propInfo in propertyInfo)
            {
                dbObject[count] = propInfo.GetValue(modelObject);
                count++;
            }

            return dbObject;
        }
    }
}
