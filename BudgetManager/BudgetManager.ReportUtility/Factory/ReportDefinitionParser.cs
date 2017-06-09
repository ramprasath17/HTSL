namespace BudgetManager.ReportUtility.Factory
{
    using BudgetManager.Entities.NamedConstants;
    using System.IO;
    using System.Xml;
    using System.Xml.Serialization;
    using BudgetManager.Helpers;
    using BudgetManager.Infrastructure.Helpers;
    using BudgetManager.Entities.EntityAttributes;
    using System;

    public static class ReportDefinitionParser
    {
        private readonly static string reportDefinitionPath = System.Web.HttpContext.Current.Server.MapPath("~/ReportDefinitions/");
        
        /// <summary>
        /// Parse the report definition and get the settings.
        /// </summary>
        /// <param name="reportType"><see cref="ReportType"/></param>
        public static void Parse(ReportType reportType)
        {
            string path = System.IO.Path.Combine(reportDefinitionPath, reportType.ToString(), ".xml");
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(path);
            XmlNodeList xmlNodes = xmlDoc.SelectNodes("/Report");
            var nodes = xmlDoc.ChildNodes;

            GetNodes(nodes);
        }

        /// <summary>
        /// Get the list of nodes in the report definition.
        /// </summary>
        /// <param name="nodes"><see cref="XmlNodeList"/></param>
        internal static void GetNodes(XmlNodeList nodes)
        {            
            foreach (XmlNode node in nodes)
            {
                if (node.NodeType.Equals(XmlNodeType.Element))
                {                    
                    if (node.HasChildNodes)
                    {
                        GetNodes(node.ChildNodes);
                    }
                }
            }
        }

        /// <summary>
        /// Parse the report definition and get the setting.
        /// </summary>
        /// <param name="reportName">Report name.</param>
        /// <param name="reportType">Report type.</param>
        /// <returns><see cref="ReportDefinition"/></returns>
        public static ReportDefinition ParseXmlToObject(string reportName, ReportType reportType)
        {
            string reportDefinitionFile = reportType.GetEnumAttributeFromValue<ReportType>(EnumAttributeTypes.ReportDefinition);
            // object rpd = reportType.GetAttributePropertyValue<ReportType, ReportDefinitionAttribute>("Name");
            string path = System.IO.Path.Combine(reportDefinitionPath, string.Concat(reportDefinitionFile, ".xml"));
            XmlSerializer serializer = new XmlSerializer(typeof(ReportDefinition));
            StreamReader reader;
            ReportDefinition reportDefinition;
            try
            {
                 reader = new StreamReader(path);
                 reportDefinition = (ReportDefinition)serializer.Deserialize(reader);
            }
            catch (FileNotFoundException fnfExc)
            {
                throw new Exception(string.Format("Could not load report definition file {0}.", fnfExc.FileName));
            }
            catch
            {
                throw new Exception("Error reading the report definition. Review the report definition or contact administration.");
            }

            reader.Close();

            return reportDefinition;
        }
    }
}
