namespace BudgetManager.Entities.NamedConstants
{
    using System.ComponentModel;

    public enum ReportFormat
    {
        [Description("xlsx")]
        Auto = 0,
        [Description("csv")]
        CSV = 1,
        [Description("xls")]
        Excel97To2003 = 5,
        [Description("xlsx")]
        Xlsx = 6,
        Xlsm = 7,
        Xltx = 8,
        Xltm = 9,
        [Description("csv")]
        TabDelimited = 11,
        [Description("html")]
        Html = 12,
        [Description("pdf")]
        Pdf = 13,
        ODS = 14,
        SpreadsheetML = 15,
        Xlsb = 16,
        XPS = 20,
        TIFF = 21,
        SVG = 22,
        Dif = 30,
        Unknown = 255,
    }
}
