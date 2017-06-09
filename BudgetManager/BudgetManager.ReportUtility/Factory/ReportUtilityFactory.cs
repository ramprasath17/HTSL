namespace BudgetManager.ReportUtility.Contracts
{
    using System;
    using System.Data;
    using System.Drawing;
    using Aspose.Cells;
    using BudgetManager.Entities.NamedConstants;
    using BudgetManager.Helpers;
    using BudgetManager.Infrastructure.Helpers;
    using BudgetManager.ReportUtility.Factory;
    using BudgetManager.ReportUtility.Factory.Contract;

    public abstract class ReportUtilityFactory : IReportFactory
    {
        public abstract string ReportName { get; }

        public abstract string ReportDescription { get; }

        public abstract void SetReportStyle(Workbook workbook);

        public abstract string[] ExcludedColumns { get; }

        public Workbook _workbook { get; set; }
        public  string startCell = string.Empty;
        public string startRow = string.Empty;
        

        private string LicensePath
        {
            get
            {
                return System.Web.HttpContext.Current.Server.MapPath("~/License/Aspose/Aspose.Cells.lic");
            }
        }

        public void GenerateReport(DataTable reportData, ReportFormat reportFormat, ReportType reportType)
        {
            Aspose.Cells.License license = new Aspose.Cells.License();
            license.SetLicense(LicensePath);
            string XLFileName = string.Concat(ReportName, DateTime.Now);
            _workbook = new Workbook();
            _workbook.Worksheets.Clear();
            _workbook.Worksheets.Add(this.ReportName);

            ReportDefinition reportDefinition = ReportDefinitionParser.ParseXmlToObject(this.ReportName, reportType);
            SetReportColumnHeader(reportData, reportDefinition);
           

            Cells cells = _workbook.Worksheets[0].Cells;
            SetStyleByType(cells, reportDefinition, StyleType.Header);
            if (reportDefinition.ReportData.ShowDescription)
            {
                SetStyleByType(cells, reportDefinition, StyleType.Description);

            }
           
            if (reportDefinition.ReportData.ShowHeader && reportDefinition.ReportData.ShowDescription)
            {
                startCell = string.Concat("A", reportDefinition.ReportStyle.Description.RowPosition.End + 2);
                startRow = Convert.ToString(reportDefinition.ReportStyle.Description.RowPosition.End + 1);                
                _workbook.Worksheets[0].Cells.ImportDataTable(reportData, true, startCell);
            }
            else
            {
                startCell = string.Concat("A", reportDefinition.ReportStyle.Header.RowPosition.End + 2);
                startRow = Convert.ToString(reportDefinition.ReportStyle.Header.RowPosition.End + 1);
                _workbook.Worksheets[0].Cells.ImportDataTable(reportData, true, startCell);
            }
         //   _workbook.Worksheets[0].Cells.ImportDataTable(reportData, true, "A5");
            _workbook.Worksheets[0].AutoFitColumns();


            SetworkBookReportStyle(_workbook);

            string fileExtension = Convert.ToString(reportFormat).GetEnumAttributeFromValue<ReportFormat>(EnumAttributeTypes.Description);
            XLFileName = string.Format("{0}.{1}", XLFileName, fileExtension);
            _workbook.Save(System.Web.HttpContext.Current.Response, XLFileName, ContentDisposition.Attachment, new OoxmlSaveOptions((SaveFormat)reportFormat));
        }

        private void SetworkBookReportStyle(Workbook _workbook)
        {
            try
            {
                int totalColumn = _workbook.Worksheets[0].Cells.MaxColumn + 1;
                Aspose.Cells.Range rng1 = _workbook.Worksheets[0].Cells.CreateRange(int.Parse(startRow), 0, 1, totalColumn);
                Style dataTableColumnStyleDefinition = new Style();
                dataTableColumnStyleDefinition.Font.IsBold = true;
                dataTableColumnStyleDefinition.Borders[BorderType.BottomBorder].LineStyle = CellBorderType.Thick;
                dataTableColumnStyleDefinition.Borders[BorderType.TopBorder].LineStyle = CellBorderType.Thick;
               // dataTableColumnStyleDefinition.Borders[BorderType.LeftBorder].LineStyle = CellBorderType.Thick;
               // dataTableColumnStyleDefinition.Borders[BorderType.RightBorder].LineStyle = CellBorderType.Thick;
                
                rng1.SetStyle(dataTableColumnStyleDefinition);
            }
            catch
            {
                throw new NotImplementedException();
            }
        }

        private void SetStyleByType(Cells cells, ReportDefinition reportDefinition, StyleType styleType)
        {
            dynamic reportObj = null;
            switch (styleType)
            {
                case StyleType.Header:
                    reportObj = reportDefinition.ReportStyle.Header;
                    break;
                case StyleType.Description:
                    reportObj = reportDefinition.ReportStyle.Description;
                    break;
            }

            SetStyle(cells, reportObj);
        }

        private void SetStyle(Cells cells, dynamic reportDefinition)
        {
            object startingRowPosition = reportDefinition.RowPosition.Start;
            object endingRowPosition = reportDefinition.RowPosition.End;
            string startingColumnPosition = reportDefinition.ColumnPosition.Start;
            string endingColumnPoisiton = reportDefinition.ColumnPosition.End;
            string headerStart = string.Concat(startingColumnPosition, startingRowPosition);
            string headerEnd = string.Concat(endingColumnPoisiton, endingRowPosition);
            string TextAlignment = reportDefinition.TextAlign;

            cells[headerStart].PutValue(reportDefinition.content);
            Style headerStyleDefinition = _workbook.Styles[_workbook.Styles.Add()];
            headerStyleDefinition.ForegroundColor = Color.Black;
            headerStyleDefinition.Font.Name = reportDefinition.Font.Name;
            headerStyleDefinition.Font.Size = reportDefinition.Font.Size;
            headerStyleDefinition.Font.Color = Color.FromName(reportDefinition.Font.Color);
            headerStyleDefinition.Font.IsBold = true;

            headerStyleDefinition.HorizontalAlignment = TextAlignmentType.Center;
            cells[headerStart].SetStyle(headerStyleDefinition);

            if (reportDefinition.MergeCells.ToLower() == "true")
            {
                Aspose.Cells.Range rng1 = _workbook.Worksheets[0].Cells.CreateRange(headerStart, headerEnd);
                rng1.Merge();
                //int rowNmber = int.Parse(startingRowPosition.ToString());
            }
        }

        /// <summary>
        /// Set report column header.
        /// </summary>
        /// <param name="reportData">The report data.</param>
        /// <param name="reportDefinition">The report definition.</param>
        internal void SetReportColumnHeader(DataTable reportData, ReportDefinition reportDefinition)
        {
            ExcludeColumns(reportData, reportDefinition);
            foreach (ReportDefinitionReportDataReportColumnsColumn reportDefinitionReportDataColumn in reportDefinition.ReportData.ReportColumns.Column)
            {
                reportData.ModifyColumn(reportDefinitionReportDataColumn.DataField, reportDefinitionReportDataColumn.TitleField, reportDefinitionReportDataColumn.Order);
            }
        }

        /// <summary>
        /// Get data table with unwanted columns
        /// </summary>
        /// <param name="reportData">The report data.</param>
        /// <param name="reportDefinition">The report definition.</param>
        internal void ExcludeColumns(DataTable reportData, ReportDefinition reportDefinition)
        {
            reportData.RemoveColumns(reportDefinition.ReportData.ReportColumns.Excluded);
        }

        enum StyleType
        {
            Header = 0,
            Description,
            Footer
        }
    }
}



