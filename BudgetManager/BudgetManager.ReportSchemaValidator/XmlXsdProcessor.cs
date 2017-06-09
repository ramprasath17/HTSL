namespace BudgetManager.ReportSchemaValidator
{
    using System;
    using System.Configuration;
    using System.Xml;
    using System.Xml.Schema;

    public static class XmlXsdProcessor
    {
        static bool Valid = true;
        static XmlReaderSettings settings;
        public static Exception exception;

        /// <summary>
        /// Validate Xml -With XSD Schema and return the deserialized object
        /// </summary>
        /// <param name="XmlPath">path of the xml file</param>
        /// <returns>if file is ok</returns>
        public static bool GetXmlTransmission(string XmlPath)
        {
            return XmlValidateXsd(XmlPath);
        }

        static void XmlXsdProcess()
        {
            XmlSchema sch = null;
            using (XmlReader xsdReader = XmlReader.Create(ConfigurationManager.AppSettings["XSDFileName"].ToString()))
            {
                sch = XmlSchema.Read(xsdReader, new ValidationEventHandler(MyValidationEventHandler));
                if (!Valid)
                    sch = null;
            }

            settings = new XmlReaderSettings();
            settings.ValidationType = ValidationType.Schema;
            if(sch != null)
                settings.Schemas.Add(sch);
            settings.ValidationEventHandler += new ValidationEventHandler(MyValidationEventHandler);
        }

        /// <summary>
        /// Validate Xml -With Xml Schema
        /// </summary>
        /// <param name="XmlPath">path of the xml file</param>
        /// <returns>if file is ok</returns>
        static bool XmlValidateXsd(string XmlPath)
        {
            Valid = true;
            //XmlXsdProcess();
            using (XmlReader xmlrd = XmlReader.Create(XmlPath, settings ))
            {
                while (xmlrd.Read()) ;
            }

            return Valid;
        }

      
        //This event handler is called only when a validation error occurs
        static void MyValidationEventHandler(object sender, ValidationEventArgs args)
        {
            Valid = false;
            exception = args.Exception;
        }
    }
}
