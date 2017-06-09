namespace BudgetManager.ReportSchemaValidator
{
    using System;
    using System.Configuration;
    using System.Diagnostics;
    using System.IO;
    using System.Web;

    public static class ReportSchemaValidator
    {
        static string XmlFilePath = HttpContext.Current.Server.MapPath("~/ReportDefinitions//");

        public static void Validate()
        {
            if (HttpContext.Current.Request.IsLocal)
            {
                DirectoryInfo DirInfo = new DirectoryInfo(XmlFilePath);
                FileInfo[] _Files = DirInfo.GetFiles("*.xml");
                Debug.WriteLine("Report schema validation is in progress...");

                for (int i = 0; i < _Files.Length; i++)
                {
                    string XmlPath = XmlFilePath + _Files[i].Name;
                    if (!XmlXsdProcessor.GetXmlTransmission(XmlPath))
                    {
                        throw XmlXsdProcessor.exception;
                    }
                }

                Debug.WriteLine("Report schema validation is in completed.");
            }
            else
            {
                Debug.WriteLine("Report schema validation is skipped.");
            }
        }
    }
}
