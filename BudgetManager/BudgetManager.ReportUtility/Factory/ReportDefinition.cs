
/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
[System.Xml.Serialization.XmlRootAttribute(Namespace = "", IsNullable = false)]
public partial class ReportDefinition
{

    private ReportDefinitionReportData reportDataField;

    private ReportDefinitionReportStyle reportStyleField;

    /// <remarks/>
    public ReportDefinitionReportData ReportData
    {
        get
        {
            return this.reportDataField;
        }
        set
        {
            this.reportDataField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportStyle ReportStyle
    {
        get
        {
            return this.reportStyleField;
        }
        set
        {
            this.reportStyleField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportData
{

    private string reportNameField;

    private string reportDescriptionField;

    private ReportDefinitionReportDataReportColumns reportColumnsField;

    private bool showHeaderField;

    private bool showDescriptionField;

    private byte idField;

    /// <remarks/>
    public string ReportName
    {
        get
        {
            return this.reportNameField;
        }
        set
        {
            this.reportNameField = value;
        }
    }

    /// <remarks/>
    public string ReportDescription
    {
        get
        {
            return this.reportDescriptionField;
        }
        set
        {
            this.reportDescriptionField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportDataReportColumns ReportColumns
    {
        get
        {
            return this.reportColumnsField;
        }
        set
        {
            this.reportColumnsField = value;
        }
    }

    /// <remarks/>
    public bool ShowHeader
    {
        get
        {
            return this.showHeaderField;
        }
        set
        {
            this.showHeaderField = value;
        }
    }

    /// <remarks/>
    public bool ShowDescription
    {
        get
        {
            return this.showDescriptionField;
        }
        set
        {
            this.showDescriptionField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public byte id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportDataReportColumns
{

    private ReportDefinitionReportDataReportColumnsColumn[] columnField;

    private string[] excludedField;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute("Column")]
    public ReportDefinitionReportDataReportColumnsColumn[] Column
    {
        get
        {
            return this.columnField;
        }
        set
        {
            this.columnField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlArrayItemAttribute("Field", IsNullable = false)]
    public string[] Excluded
    {
        get
        {
            return this.excludedField;
        }
        set
        {
            this.excludedField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportDataReportColumnsColumn
{

    private string dataFieldField;

    private string titleFieldField;

    private byte orderField;

    private byte idField;

    private bool idFieldSpecified;

    /// <remarks/>
    public string DataField
    {
        get
        {
            return this.dataFieldField;
        }
        set
        {
            this.dataFieldField = value;
        }
    }

    /// <remarks/>
    public string TitleField
    {
        get
        {
            return this.titleFieldField;
        }
        set
        {
            this.titleFieldField = value;
        }
    }

    /// <remarks/>
    public byte Order
    {
        get
        {
            return this.orderField;
        }
        set
        {
            this.orderField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlAttributeAttribute()]
    public byte id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyle
{

    private ReportDefinitionReportStyleHeader headerField;

    private ReportDefinitionReportStyleDescription descriptionField;

    /// <remarks/>
    public ReportDefinitionReportStyleHeader Header
    {
        get
        {
            return this.headerField;
        }
        set
        {
            this.headerField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportStyleDescription Description
    {
        get
        {
            return this.descriptionField;
        }
        set
        {
            this.descriptionField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyleHeader
{

    private string contentField;

    private ReportDefinitionReportStyleHeaderRowPosition rowPositionField;

    private ReportDefinitionReportStyleHeaderColumnPosition columnPositionField;

    private string mergeCellsField;

    private ReportDefinitionReportStyleHeaderFont fontField;

    private string textAlignField;

    private string foregroundColorField;

    /// <remarks/>
    public string content
    {
        get
        {
            return this.contentField;
        }
        set
        {
            this.contentField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportStyleHeaderRowPosition RowPosition
    {
        get
        {
            return this.rowPositionField;
        }
        set
        {
            this.rowPositionField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportStyleHeaderColumnPosition ColumnPosition
    {
        get
        {
            return this.columnPositionField;
        }
        set
        {
            this.columnPositionField = value;
        }
    }

    /// <remarks/>
    public string MergeCells
    {
        get
        {
            return this.mergeCellsField;
        }
        set
        {
            this.mergeCellsField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportStyleHeaderFont Font
    {
        get
        {
            return this.fontField;
        }
        set
        {
            this.fontField = value;
        }
    }

    /// <remarks/>
    public string TextAlign
    {
        get
        {
            return this.textAlignField;
        }
        set
        {
            this.textAlignField = value;
        }
    }

    /// <remarks/>
    public string ForegroundColor
    {
        get
        {
            return this.foregroundColorField;
        }
        set
        {
            this.foregroundColorField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyleHeaderRowPosition
{

    private byte startField;

    private byte endField;

    /// <remarks/>
    public byte Start
    {
        get
        {
            return this.startField;
        }
        set
        {
            this.startField = value;
        }
    }

    /// <remarks/>
    public byte End
    {
        get
        {
            return this.endField;
        }
        set
        {
            this.endField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyleHeaderColumnPosition
{

    private string startField;

    private string endField;

    /// <remarks/>
    public string Start
    {
        get
        {
            return this.startField;
        }
        set
        {
            this.startField = value;
        }
    }

    /// <remarks/>
    public string End
    {
        get
        {
            return this.endField;
        }
        set
        {
            this.endField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyleHeaderFont
{

    private byte sizeField;

    private string nameField;

    private string colorField;

    private bool isBoldField;

    /// <remarks/>
    public byte Size
    {
        get
        {
            return this.sizeField;
        }
        set
        {
            this.sizeField = value;
        }
    }

    /// <remarks/>
    public string Name
    {
        get
        {
            return this.nameField;
        }
        set
        {
            this.nameField = value;
        }
    }

    /// <remarks/>
    public string Color
    {
        get
        {
            return this.colorField;
        }
        set
        {
            this.colorField = value;
        }
    }

    /// <remarks/>
    public bool IsBold
    {
        get
        {
            return this.isBoldField;
        }
        set
        {
            this.isBoldField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyleDescription
{

    private string contentField;

    private ReportDefinitionReportStyleDescriptionRowPosition rowPositionField;

    private ReportDefinitionReportStyleDescriptionColumnPosition columnPositionField;

    private string mergeCellsField;

    private ReportDefinitionReportStyleDescriptionFont fontField;

    private bool wrapTextField;

    private string textAlignField;

    private string foregroundColorField;

    /// <remarks/>
    public string content
    {
        get
        {
            return this.contentField;
        }
        set
        {
            this.contentField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportStyleDescriptionRowPosition RowPosition
    {
        get
        {
            return this.rowPositionField;
        }
        set
        {
            this.rowPositionField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportStyleDescriptionColumnPosition ColumnPosition
    {
        get
        {
            return this.columnPositionField;
        }
        set
        {
            this.columnPositionField = value;
        }
    }

    /// <remarks/>
    public string MergeCells
    {
        get
        {
            return this.mergeCellsField;
        }
        set
        {
            this.mergeCellsField = value;
        }
    }

    /// <remarks/>
    public ReportDefinitionReportStyleDescriptionFont Font
    {
        get
        {
            return this.fontField;
        }
        set
        {
            this.fontField = value;
        }
    }

    /// <remarks/>
    public bool WrapText
    {
        get
        {
            return this.wrapTextField;
        }
        set
        {
            this.wrapTextField = value;
        }
    }

    /// <remarks/>
    public string TextAlign
    {
        get
        {
            return this.textAlignField;
        }
        set
        {
            this.textAlignField = value;
        }
    }

    /// <remarks/>
    public string ForegroundColor
    {
        get
        {
            return this.foregroundColorField;
        }
        set
        {
            this.foregroundColorField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyleDescriptionRowPosition
{

    private byte startField;

    private byte endField;

    /// <remarks/>
    public byte Start
    {
        get
        {
            return this.startField;
        }
        set
        {
            this.startField = value;
        }
    }

    /// <remarks/>
    public byte End
    {
        get
        {
            return this.endField;
        }
        set
        {
            this.endField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyleDescriptionColumnPosition
{

    private string startField;

    private string endField;

    /// <remarks/>
    public string Start
    {
        get
        {
            return this.startField;
        }
        set
        {
            this.startField = value;
        }
    }

    /// <remarks/>
    public string End
    {
        get
        {
            return this.endField;
        }
        set
        {
            this.endField = value;
        }
    }
}

/// <remarks/>
[System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
public partial class ReportDefinitionReportStyleDescriptionFont
{

    private byte sizeField;

    private string nameField;

    private string colorField;

    private bool isBoldField;

    /// <remarks/>
    public byte Size
    {
        get
        {
            return this.sizeField;
        }
        set
        {
            this.sizeField = value;
        }
    }

    /// <remarks/>
    public string Name
    {
        get
        {
            return this.nameField;
        }
        set
        {
            this.nameField = value;
        }
    }

    /// <remarks/>
    public string Color
    {
        get
        {
            return this.colorField;
        }
        set
        {
            this.colorField = value;
        }
    }

    /// <remarks/>
    public bool IsBold
    {
        get
        {
            return this.isBoldField;
        }
        set
        {
            this.isBoldField = value;
        }
    }
}

