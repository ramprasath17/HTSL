USE [PowerHeatCalc]
GO
/****** Object:  Table [dbo].[tbl_PHT_Group_Type]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_PHT_Group_Type](
	[GroupType_ID] [int] IDENTITY(1,1) NOT NULL,
	[GroupType_Name] [varchar](50) NOT NULL,
	[Description] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_PHT_Group_Type] PRIMARY KEY CLUSTERED 
(
	[GroupType_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_Formula_Table]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Formula_Table](
	[FunctionID] [int] NOT NULL,
	[Alais] [nvarchar](50) NULL,
	[FormulaName] [nvarchar](250) NULL,
	[Formula] [nvarchar](255) NULL,
 CONSTRAINT [PK_FormulaTable] PRIMARY KEY CLUSTERED 
(
	[FunctionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_PHT_Cabinet_Type]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Cabinet_Type](
	[CabinetTypeID] [int] NOT NULL,
	[CabinetTypeName] [varchar](200) NOT NULL,
 CONSTRAINT [PK_mst_CabinetType] PRIMARY KEY CLUSTERED 
(
	[CabinetTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_Cabinet_Temp]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Cabinet_Temp](
	[CabTempID] [uniqueidentifier] NOT NULL,
	[CabinetID] [uniqueidentifier] NOT NULL,
	[FanQuantity] [int] NULL,
	[Tambient] [decimal](16, 2) NULL,
	[dT] [int] NULL,
	[CabTemp] [decimal](16, 2) NULL,
	[Fan_AirFlow] [decimal](16, 2) NULL,
 CONSTRAINT [PK_Tbl_PHT_Cabinet_Temp] PRIMARY KEY CLUSTERED 
(
	[CabTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_PHT_Project]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Project](
	[ProjectID] [uniqueidentifier] NOT NULL,
	[ProjectName] [nvarchar](256) NOT NULL,
	[CustomerName] [nvarchar](256) NULL,
	[PONbr] [nvarchar](500) NULL,
	[ProjectNbr] [nvarchar](256) NULL,
	[HonDocumentNbr] [nvarchar](256) NULL,
	[CustomerDocumentNbr] [nvarchar](256) NULL,
	[ProjNameReportHeader] [bit] NULL,
	[ProjNbrReportCover] [bit] NULL,
	[ProjNbrReportHeader] [bit] NULL,
	[HonDocNbrReportCover] [bit] NULL,
	[HonDocNbrReportHeader] [bit] NULL,
	[CustomerDocNbrReportCover] [bit] NULL,
	[CustomerDocNbrReportHeader] [bit] NULL,
	[InputVoltage] [int] NULL,
	[InputFrequency] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_PHT_PowerSupply_ModuleDef]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_PHT_PowerSupply_ModuleDef](
	[ModelID] [int] NOT NULL,
	[Category] [nvarchar](100) NULL,
	[Manufacturer] [nvarchar](100) NULL,
	[HoneywellModel] [nvarchar](50) NULL,
	[Description] [nvarchar](256) NULL,
	[Weight] [decimal](10, 2) NULL,
	[Heatdissipation] [decimal](10, 3) NULL,
	[SupplyVoltage] [nvarchar](50) NULL,
	[IS_AC_COMPONENT] [bit] NULL,
	[Module_Group] [varchar](100) NULL,
	[code] [nvarchar](10) NULL,
	[IsCustom] [bit] NULL,
	[OutputVoltage] [nvarchar](100) NULL,
	[CurrentRating] [decimal](16, 3) NULL,
 CONSTRAINT [PK_PowerSupply_ModuleDef] PRIMARY KEY CLUSTERED 
(
	[ModelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_Power_Draw_Type]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Power_Draw_Type](
	[PowerDrawTypeID] [uniqueidentifier] NOT NULL,
	[PowerDrawType] [varchar](150) NOT NULL,
 CONSTRAINT [PK_mst_PowerDrawType] PRIMARY KEY CLUSTERED 
(
	[PowerDrawTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_ModuleDef]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_PHT_ModuleDef](
	[ModelID] [int] NOT NULL,
	[Category] [nvarchar](100) NULL,
	[Manufacturer] [nvarchar](100) NULL,
	[HoneywellModel] [nvarchar](50) NULL,
	[NonHWManufacturerPartNbr] [nvarchar](50) NULL,
	[Description] [nvarchar](256) NULL,
	[Weight] [decimal](10, 2) NULL,
	[Heatdissipation] [decimal](10, 3) NULL,
	[SupplyVoltage] [nvarchar](50) NULL,
	[PHCompChannelWise] [bit] NULL,
	[FanCapacity] [nvarchar](100) NULL,
	[AO_Heatdissipation] [decimal](10, 2) NULL,
	[AI_Heatdissipation] [decimal](10, 2) NULL,
	[DI_Heatdissipation] [decimal](10, 2) NULL,
	[DO_Heatdissipation] [decimal](10, 2) NULL,
	[IOTA_Heatdissipation] [decimal](10, 2) NULL,
	[General_Field1] [nvarchar](100) NULL,
	[General_Field2] [nvarchar](100) NULL,
	[General_Field3] [nvarchar](100) NULL,
	[General_Field4] [nvarchar](100) NULL,
	[General_Field5] [nvarchar](100) NULL,
	[IS_AC_COMPONENT] [bit] NULL,
	[Module_Group] [varchar](100) NULL,
	[code] [nvarchar](10) NULL,
	[nChan] [int] NULL,
	[cSignalType] [nvarchar](50) NULL,
	[nWDG] [int] NOT NULL,
	[nInputLoad] [decimal](10, 2) NULL,
	[24V_IO] [bit] NULL,
	[48V_IO] [bit] NULL,
	[60V_IO] [bit] NULL,
	[110V_IO] [bit] NULL,
	[220V_IO] [bit] NULL,
	[nL_5V] [decimal](10, 2) NULL,
	[nL_24i] [decimal](10, 2) NULL,
	[nL_24e] [decimal](10, 2) NULL,
	[nL_48i] [decimal](10, 2) NULL,
	[nL_48e] [decimal](10, 2) NULL,
	[nL_60i] [decimal](10, 2) NULL,
	[nL_60e] [decimal](10, 2) NULL,
	[nL_110i] [decimal](10, 2) NULL,
	[nL_110e] [decimal](10, 2) NULL,
	[nL_220i] [decimal](10, 2) NULL,
	[nL_220e] [decimal](10, 2) NULL,
	[nV_drop] [decimal](10, 2) NULL,
	[nOutputLoad] [decimal](10, 2) NULL,
	[def_OutputLoad] [decimal](10, 2) NULL,
	[IsCustom] [bit] NULL,
	[OutputVoltage] [nvarchar](100) NULL,
	[Power_Dissipation_Barrier] [decimal](10, 3) NULL,
	[Devices_OnBoard] [int] NULL,
	[Is_Misc_Comp] [bit] NULL,
 CONSTRAINT [PK_ModuleDef] PRIMARY KEY CLUSTERED 
(
	[ModelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_Miscelleneous_Type]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Miscelleneous_Type](
	[MiscTypeID] [int] NOT NULL,
	[MiscTypeName] [varchar](200) NOT NULL,
	[DisplayText] [varchar](200) NULL,
 CONSTRAINT [PK_mst_MiscType] PRIMARY KEY CLUSTERED 
(
	[MiscTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_Miscelleneous_Module]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Miscelleneous_Module](
	[CabinetModuleID] [uniqueidentifier] NOT NULL,
	[CompID] [uniqueidentifier] NULL,
	[ModelID] [int] NOT NULL,
	[ModelDescription] [nvarchar](256) NULL,
	[Quantity] [int] NOT NULL,
	[IsUIO] [bit] NULL,
	[AI_UIO_ChannelCount] [int] NULL,
	[AO_UIO_ChannelCount] [int] NULL,
	[DI_UIO_ChannelCount] [int] NULL,
	[DO_UIO_ChannelCount] [int] NULL,
	[IOTA_UIO_ChannelCount] [int] NULL,
	[FeederType] [int] NULL,
	[OPCalc_A] [decimal](16, 2) NULL,
	[OPCalc_B] [decimal](16, 2) NULL,
	[OPCalc_C] [decimal](16, 2) NULL,
	[OPCalc_D] [decimal](16, 2) NULL,
	[OPCalc_E] [decimal](16, 2) NULL,
	[OPCalc_F] [decimal](16, 2) NULL,
	[OPCalc_G] [decimal](16, 2) NULL,
	[OPCalc_H] [decimal](16, 2) NULL,
	[OPCalc_I] [decimal](16, 2) NULL,
	[OPCalc_N] [decimal](16, 2) NULL,
	[RowNum] [int] NULL,
 CONSTRAINT [PK_Tbl_PHT_Miscelleneous_Module] PRIMARY KEY CLUSTERED 
(
	[CabinetModuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_CustomModuleInfo]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  Visweswaran Varadarajan        
-- Create date: 25-Jun-2013        
-- Description: To retrive module list with calculation for given cabinet        
-- =============================================        
--SP_PHT_RPT_Fetch_CustomModuleInfo 'F4224D05-78B8-413B-AC91-19CFCD94AE16','''24cc5e2f-3923-4167-99dd-b94a13991086''','Group1'          
--exec SP_PHT_RPT_Fetch_CustomModuleInfo @PROJECTID='e7150c3b-e5a4-4def-9b0b-8379081aa298',@Group='''84d37349-7606-4995-9ae6-db3c9ea157bb''',@Groups = 'Group1'        
        
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_CustomModuleInfo] --'b0a2f870-0342-425a-8dc9-360240f17285','''d99b546c-bb85-4ff3-874d-011cddc8e8b1''',''        
 -- Add the parameters for the stored procedure here        
 @ProjectId varchar(75),        
 @Group varchar(5000),         
 @Groups nvarchar(256)        
AS        
BEGIN        
 -- SET NOCOUNT ON added to prevent extra result sets from        
 -- interfering with SELECT statements.        
 SET NOCOUNT ON;        
        
        
--================================================GET PROJECT SETTINGS================================================        
DECLARE @MainQRY VARCHAR(max)    
DECLARE @SUBQRY VARCHAR(MAX)  
DECLARE @PowersupplySUBQRY VARCHAR(MAX)  
DECLARE @ENCLOSURESURFACEQRY VARCHAR(MAX)  
DECLARE @QRYGROUP VARCHAR(MAX)    
SET @SUBQRY = 'DECLARE @ISBTU_HR BIT        
          SELECT          
                @ISBTU_HR=TBL_RPT_SET.AdvPowerHeatUnit        
        FROM    TBL_PHT_PROJECT TBL_PRJ ,        
                Tbl_PHT_Report_Setting TBL_RPT_SET                        
        WHERE   TBL_PRJ.ProjectID = TBL_RPT_SET.ProjectID                        
                AND TBL_PRJ.ProjectID = '''+@ProjectId+'''        
  --================================================GET LIST OF MODULES================================================        
INSERT INTO #MODULE_INFO        
(ROWNUM,CABINETNAME,CABINETTYPE,CABDESC,PowerDrawType,Area,Location,GeneralNotes,Is_Secondary,ModelID,HWModel,Module_Group,Mod_Desc,Qty,Heat,IsAC,A,B,C,D,E,F,G,H,I,IsBtu_hr,Groups,Vdrop,PF,EnclosureWATTS,EnclosureConversion)        
(SELECT ROW_NUMBER() OVER(ORDER BY TBL_CAB.CabinetName,TBL_MOD.PowerDrawTypeID,TBL_MOD.ModelID),        
TBL_CAB.CabinetName,        
(SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=TBL_CAB.CabinetTypeID)        
,TBL_CAB.CabinetDesc        
,(SELECT PowerDrawType FROM Tbl_PHT_Power_Draw_Type WHERE PowerDrawTypeID=TBL_MOD.PowerDrawTypeID)        
      ,TBL_CAB.Area        
      ,TBL_CAB.Location        
      ,TBL_CAB.GeneralNotes        
      ,(CASE               
      WHEN TBL_MOD.PowerDrawTypeID=''8B70E2DD-2DA1-46A4-A7FF-4632742F07A1'' THEN TBL_MOD.FeederType              
      ELSE              
       (CASE               
       WHEN TBL_MOD.PowerDrawTypeID IN (''CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5'',''8224F746-CFB1-4C67-82EA-FE6B0E420127'',''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'')               
       THEN (CASE WHEN TBL_CAB.PSUPSFeeder=0 THEN 3              
       ELSE 1 END) ELSE 1  END) END)        
      ,TBL_MOD.ModelID              
      ,TBL_MOD_DEF.HoneywellModel        
      ,TBL_MOD_DEF.Module_Group        
      ,TBL_MOD.ModelDescription        
      ,TBL_MOD.Quantity        
      ,(CASE WHEN TBL_MOD.IsUIO=1 THEN       
((TBL_MOD.AI_UIO_ChannelCount*TBL_MOD_DEF.AI_Heatdissipation)+(TBL_MOD.AO_UIO_ChannelCount*TBL_MOD_DEF.AO_Heatdissipation)+      
(TBL_MOD.DI_UIO_ChannelCount*TBL_MOD_DEF.DI_Heatdissipation)+(TBL_MOD.DO_UIO_ChannelCount*TBL_MOD_DEF.DO_Heatdissipation)+      
(TBL_MOD.IOTA_UIO_ChannelCount*TBL_MOD_DEF.IOTA_Heatdissipation)) ELSE TBL_MOD_DEF.Heatdissipation END)        
      , TBL_MOD_DEF.IS_AC_COMPONENT          
      ,TBL_MOD.OPCalc_A        
      ,TBL_MOD.OPCalc_B        
      ,TBL_MOD.OPCalc_C        
      ,TBL_MOD.OPCalc_D        
      ,TBL_MOD.OPCalc_E        
      ,TBL_MOD.OPCalc_F        
      ,TBL_MOD.OPCalc_G        
      ,TBL_MOD.OPCalc_H        
      ,TBL_MOD.OPCalc_I        
      ,@ISBTU_HR        
      ,'''+@Groups+''',0,0     
      , 0 as EnclosureWATTS      
      , 0 as EnclosureConversion        
      FROM Tbl_PHT_Cabinet_Module TBL_MOD,(select ModelID,HoneywellModel,Module_Group,AI_Heatdissipation,AO_Heatdissipation,DI_Heatdissipation,DO_Heatdissipation,IOTA_Heatdissipation,Heatdissipation, IS_AC_COMPONENT from Tbl_PHT_ModuleDef) TBL_MOD_DEF,         
      Tbl_PHT_Cabinet_Configuration TBL_CAB        
 WHERE TBL_MOD.ModelID=TBL_MOD_DEF.ModelID         
 AND TBL_MOD.CabinetID=TBL_CAB.CabinetID AND TBL_CAB.CabinetID IN (' + @Group + ')
 and TBL_MOD.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
 
 '        
        SET @PowersupplySUBQRY = 'union SELECT ROW_NUMBER() OVER(ORDER BY TBL_CAB.CabinetName,TBL_MOD.PowerDrawTypeID,TBL_MOD.ModelID),        
TBL_CAB.CabinetName,        
(SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=TBL_CAB.CabinetTypeID)        
,TBL_CAB.CabinetDesc        
,(SELECT PowerDrawType FROM Tbl_PHT_Power_Draw_Type WHERE PowerDrawTypeID=TBL_MOD.PowerDrawTypeID)        
      ,TBL_CAB.Area        
      ,TBL_CAB.Location        
      ,TBL_CAB.GeneralNotes        
      ,(CASE               
      WHEN TBL_MOD.PowerDrawTypeID=''8B70E2DD-2DA1-46A4-A7FF-4632742F07A1'' THEN TBL_MOD.FeederType              
      ELSE              
       (CASE               
       WHEN TBL_MOD.PowerDrawTypeID IN (''CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5'',''8224F746-CFB1-4C67-82EA-FE6B0E420127'',''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'')               
       THEN (CASE WHEN TBL_CAB.PSUPSFeeder=0 THEN 3              
       ELSE 1 END) ELSE 1  END) END)        
      ,TBL_MOD.ModelID              
      ,TBL_MOD_DEF.HoneywellModel        
      ,TBL_MOD_DEF.Module_Group        
      ,TBL_MOD.ModelDescription        
      ,TBL_MOD.Quantity        
      ,(CASE WHEN TBL_MOD.IsUIO=1 THEN       
((TBL_MOD.AI_UIO_ChannelCount*TBL_MOD_DEF.AI_Heatdissipation)+(TBL_MOD.AO_UIO_ChannelCount*TBL_MOD_DEF.AO_Heatdissipation)+      
(TBL_MOD.DI_UIO_ChannelCount*TBL_MOD_DEF.DI_Heatdissipation)+(TBL_MOD.DO_UIO_ChannelCount*TBL_MOD_DEF.DO_Heatdissipation)+      
(TBL_MOD.IOTA_UIO_ChannelCount*TBL_MOD_DEF.IOTA_Heatdissipation)) ELSE TBL_MOD_DEF.Heatdissipation END)        
      , TBL_MOD_DEF.IS_AC_COMPONENT          
      ,TBL_MOD.OPCalc_A        
      ,TBL_MOD.OPCalc_B        
      ,TBL_MOD.OPCalc_C        
      ,TBL_MOD.OPCalc_D        
      ,TBL_MOD.OPCalc_E        
      ,TBL_MOD.OPCalc_F        
      ,TBL_MOD.OPCalc_G        
      ,TBL_MOD.OPCalc_H        
      ,TBL_MOD.OPCalc_I        
      ,@ISBTU_HR        
      ,'''+@Groups+''',0,0     
      , 0 as EnclosureWATTS      
      , 0 as EnclosureConversion        
      FROM Tbl_PHT_Cabinet_Module TBL_MOD,(select ModelID,HoneywellModel,Module_Group,0 as AI_Heatdissipation,0 as AO_Heatdissipation,0 as DI_Heatdissipation,
0 as DO_Heatdissipation,0 as IOTA_Heatdissipation,0 as Heatdissipation, 0 as IS_AC_COMPONENT from Tbl_PHT_PowerSupply_ModuleDef) TBL_MOD_DEF,         
      Tbl_PHT_Cabinet_Configuration TBL_CAB        
 WHERE TBL_MOD.ModelID=TBL_MOD_DEF.ModelID         
 AND TBL_MOD.CabinetID=TBL_CAB.CabinetID AND TBL_CAB.CabinetID IN (' + @Group + ')
 and TBL_MOD.PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'')
 '
      SET @ENCLOSURESURFACEQRY=' union '+      
  '  select ROW_NUMBER() OVER(ORDER BY TBL_CAB.CabinetName), CabinetName,                  
(SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=TBL_CAB.CabinetTypeID),CabinetDesc ,'''' as powerdrawType,Area,Location,    
'''' as GeneralNotes,      
0 ,0 as ModelID,''''as HoneywellModel,'''' as Module_Group,'''' as ModelDescription,      
0 as Quantity,0 as Heatdissipation,0 as IS_AC_COMPONENT,0 as OPCalc_A,0as OPCalc_B,0 as OPCalc_C,0 as OPCalc_D,0 as OPCalc_E,0 as OPCalc_F,0 as OPCalc_G,    
0 as OPCalc_H,0 as OPCalc_I,@ISBTU_HR, '''+@Groups+''''+',0,0,      
EnclosureSurfaceInWatts as EnclosureWATTS,      
CASE WHEN @ISBTU_HR=1 Then EnclosureSurfaceInBtu else EnclosureSurfaceInKcal end as EnclosureConversion        
from Tbl_PHT_Cabinet_Configuration TBL_CAB where EnclosureSurfaceInWatts>0  and ProjectId='+''''+@ProjectId+''''+' and CabinetID IN ('  
  
SET @QRYGROUP= @Group + ')'     
        
      SET @MainQRY=@SUBQRY+@PowersupplySUBQRY+@ENCLOSURESURFACEQRY+@QRYGROUP;  
        
        
   print @MainQRY     
EXEC(@SUBQRY+@PowersupplySUBQRY+@ENCLOSURESURFACEQRY+@QRYGROUP)        
        
DECLARE @SMQRY VARCHAR(max)       
DECLARE  @SMSUBQRY VARCHAR(max)  
DECLARE @SMPowersupplySUBQRY VARCHAR(MAX)   
DECLARE @SM@ENCLOSURESURFACEQRY VARCHAR(Max)  
DECLARE @SM@QRYGROUP VARCHAR(MAX)  
  
SET @SMSUBQRY='DECLARE @ISBTU_HR BIT        
     SELECT  @ISBTU_HR=TBL_RPT_SET.AdvPowerHeatUnit        
        FROM    TBL_PHT_PROJECT TBL_PRJ ,        
                Tbl_PHT_Report_Setting TBL_RPT_SET                        
        WHERE   TBL_PRJ.ProjectID = TBL_RPT_SET.ProjectID                        
                AND TBL_PRJ.ProjectID = '''+@ProjectId+'''  
 DECLARE @PF decimal(4,2);DECLARE @AdvIsPowerFactor bit;'+      
  ' SELECT @AdvIsPowerFactor=AdvIsPowerFactor FROM Tbl_PHT_Report_Setting where projectid= ' + '''' +@ProjectId + ''''+      
' IF(@AdvIsPowerFactor=1)      
BEGIN      
SELECT @PF=AdvPowerFactor FROM Tbl_PHT_Report_Setting where projectid='+ '''' + @ProjectId  +'''          
END      
ELSE      
BEGIN      
SET @PF=1      
END       
INSERT INTO #SM_MODULE_INFO          
 (CABINETNAME,CABINETTYPE,CABDESC,PowerDrawType,Area,Location,GeneralNotes,Is_Secondary,ModelID,HWModel,Module_Group,Mod_Desc,Qty,Heat,IsAC,A,B,C,D,E,F,G,H,I,IsBtu_hr,Groups,Vdrop,PF,EnclosureWATTS,EnclosureConversion)             
  (select          
   TBL_CAB.CabinetName,CabinetTypeName,CabinetDesc,PowerDrawType          
,TBL_CAB.Area,TBL_CAB.Location,TBL_CAB.GeneralNotes,         
CASE WHEN TBL_CAB.PSUPSFeeder=0 THEN 3 ELSE 1 END ,TBL_MOD.ModelID,mod_def.HoneywellModel,mod_def.Module_Group,TBL_MOD.ModelDescription,TBL_MOD.Quantity,TBL_MOD.TotalHeat_Des_Watts,'+'''0'''+' as IS_AC_COMPONENT,         
IDC_Pri as OPCalc_A,'+'''0'''+' as OPCalc_B,'+'''0'''+' as OPCalc_C,'+'''0'''+' as OPCalc_D,IAC_Pri as OPCalc_E,(TotalHeat_Des_Watts/@PF) as OPCalc_F,      
TotalHeat_Des_Btu as OPCalc_G,TotalHeat_Des_Watts as OPCalc_H,'        
+' TotalHeat_Des_Btu as OPCalc_I,@ISBTU_HR,'''+@Groups+''''+', Vdrop,CASE WHEN AdvIsPowerFactor=1 THEN AdvPowerFactor ELSE 1 END as PF    
, 0 as EnclosureWATTS      
, 0 as EnclosureConversion          
From Tbl_PHT_SMCabinet_Module TBL_MOD inner join Tbl_PHT_Cabinet_Configuration TBL_CAB           
ON TBL_MOD.CabinetID=TBL_CAB.CabinetID AND TBL_MOD.CabinetID=TBL_CAB.CabinetID        
inner join Tbl_PHT_Report_Setting RS on RS.projectid= TBL_CAB.projectid      
inner join (select ModelID,HoneywellModel,Module_Group from Tbl_PHT_ModuleDef ) mod_def on mod_def.ModelID=TBL_MOD.ModelID          
inner join Tbl_PHT_Cabinet_Type CAB_TYPE ON CAB_TYPE.CabinetTypeID=TBL_CAB.CabinetTypeID          
inner join Tbl_PHT_Power_Draw_Type DRAW_TYPE ON DRAW_TYPE.PowerDrawTypeID=TBL_MOD.PowerDrawTypeID          
where TBL_MOD.CabinetID IN (' + @Group + ') and RS.projectid=' + '''' + @ProjectId +''' 
and TBL_MOD.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''

'           
        SET @SMPowersupplySUBQRY='union
select          
   TBL_CAB.CabinetName,CabinetTypeName,CabinetDesc,PowerDrawType          
,TBL_CAB.Area,TBL_CAB.Location,TBL_CAB.GeneralNotes,         
CASE WHEN TBL_CAB.PSUPSFeeder=0 THEN 3 ELSE 1 END ,TBL_MOD.ModelID,mod_def.HoneywellModel,mod_def.Module_Group,TBL_MOD.ModelDescription,TBL_MOD.Quantity,TBL_MOD.TotalHeat_Des_Watts,'+'''0'''+' as IS_AC_COMPONENT,         
IDC_Pri as OPCalc_A,'+'''0'''+' as OPCalc_B,'+'''0'''+' as OPCalc_C,'+'''0'''+' as OPCalc_D,IAC_Pri as OPCalc_E,(TotalHeat_Des_Watts/@PF) as OPCalc_F,      
TotalHeat_Des_Btu as OPCalc_G,TotalHeat_Des_Watts as OPCalc_H,'        
+' TotalHeat_Des_Btu as OPCalc_I,@ISBTU_HR,'''+@Groups+''''+', Vdrop,CASE WHEN AdvIsPowerFactor=1 THEN AdvPowerFactor ELSE 1 END as PF    
, 0 as EnclosureWATTS      
, 0 as EnclosureConversion          
From Tbl_PHT_SMCabinet_Module TBL_MOD inner join Tbl_PHT_Cabinet_Configuration TBL_CAB           
ON TBL_MOD.CabinetID=TBL_CAB.CabinetID AND TBL_MOD.CabinetID=TBL_CAB.CabinetID        
inner join Tbl_PHT_Report_Setting RS on RS.projectid= TBL_CAB.projectid      
inner join (select ModelID,HoneywellModel,Module_Group from Tbl_PHT_PowerSupply_ModuleDef) mod_def on mod_def.ModelID=TBL_MOD.ModelID          
inner join Tbl_PHT_Cabinet_Type CAB_TYPE ON CAB_TYPE.CabinetTypeID=TBL_CAB.CabinetTypeID          
inner join Tbl_PHT_Power_Draw_Type DRAW_TYPE ON DRAW_TYPE.PowerDrawTypeID=TBL_MOD.PowerDrawTypeID          
where TBL_MOD.CabinetID IN (' + @Group + ') and RS.projectid=' + '''' + @ProjectId +''' 
and TBL_MOD.PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'' )

'   
       SET @SM@ENCLOSURESURFACEQRY=' union  '+ ' select CabinetName,                  
(SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=TBL_CAB.CabinetTypeID),CabinetDesc ,'''' as powerdrawType,Area,Location,    
'''' as GeneralNotes,0 ,0 as ModelID,''''as HoneywellModel,'''' as Module_Group,'''' as ModelDescription,      
0 as Quantity,0 as TotalHeat_Des_Watts,0 as IS_AC_COMPONENT,0 as OPCalc_A,0as OPCalc_B,0 as OPCalc_C,0 as OPCalc_D,0 as OPCalc_E,0 as OPCalc_F,0 as OPCalc_G,    
0 as OPCalc_H,0 as OPCalc_I,@ISBTU_HR, '''+@Groups+''''+',0 as Vdrop,0 as PF,      
EnclosureSurfaceInWatts as EnclosureWATTS,      
CASE WHEN @ISBTU_HR=1 Then EnclosureSurfaceInBtu else EnclosureSurfaceInKcal end as EnclosureConversion        
from Tbl_PHT_Cabinet_Configuration TBL_CAB inner join Tbl_PHT_SMCabinet_Module SM on    
TBL_CAB.CAbinetid=SM.CabinetId where EnclosureSurfaceInWatts>0 and ProjectId='+''''+@ProjectId+''''+' and TBL_CAB.CabinetID IN ('   
SET @SM@QRYGROUP = @Group + ')'    
   
  SET  @SMQRY=@SMSUBQRY+@SMPowersupplySUBQRY+@SM@ENCLOSURESURFACEQRY+@SM@QRYGROUP;  
   print @SMQRY   
EXEC(@SMSUBQRY+@SMPowersupplySUBQRY+@SM@ENCLOSURESURFACEQRY+@SM@QRYGROUP)        
          
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_CustomCabinetTempInfo]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_CustomCabinetTempInfo]  
 -- Add the parameters for the stored procedure here  
 @ProjectID uniqueidentifier,   
 @Group varchar(5000),  
 @Groups nvarchar(256)  
AS  
BEGIN  
  
IF 1=0 BEGIN  
    SET FMTONLY OFF  
END  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
   --Added by Shyamala for FR27
    
     
  --Ends here
   
 DECLARE @MainQRY NVARCHAR(max)  
   
 SET @MainQRY = '
     DECLARE @ISBTU_HR BIT
     DECLARE @CONVERSION VARCHAR(15)
     SELECT @ISBTU_HR=AdvPowerHeatUnit FROM Tbl_PHT_Report_Setting where projectid='''+convert(nvarchar(50), @ProjectID)+''' 
     IF(@ISBTU_HR=1)
     BEGIN
      SET @CONVERSION = ''' +' BTU/Hr '+ '''
     END
     ELSE
     BEGIN
           SET @CONVERSION = ''' +' KCal/Hr '+ '''
     END
 
 INSERT INTO #MODULE_INFO  
(CabinetName,CabinetType,Area,Location,CabinetDesc,CabinetHeight,CabinetWidth,CabinetDepth,FanQuantity,FanAirFlow,HeatLoad,GeneralNotes,
FanQty,Tambient,dT,CabTemp,HeatLoadWithConversion,EnclosureSurfaceInWatts,EnclosureSurfaceWithConversion,TotalWatts,TotalConversion,Groups)  
            Select TBL_CAB.CabinetName,  
        (SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=TBL_CAB.CabinetTypeID) as CabinetType,  
        TBL_CAB.Area,  
        TBL_CAB.Location,  
        TBL_CAB.CabinetDesc,  
        TBL_CAB.CabinetHeight,  
        TBL_CAB.CabinetWidth,  
        TBL_CAB.CabinetDepth,  
        TBL_CAB.FanQuantity,  
        TBL_CAB.FanAirFlow,  
        TBL_CAB.HeatLoad,  
        TBL_CAB.GeneralNotes,  
        TBL_TMP.FanQuantity as FanQty,  
        TBL_TMP.Tambient,  
        TBL_TMP.dT,  
        TBL_TMP.CabTemp,
        CASE WHEN(@ISBTU_HR=1) THEN Convert(varchar(50),TBL_CAB.HeatLoadInBTU)+@CONVERSION
                               ELSE Convert(varchar(50),TBL_CAB.HeatLoadInKcalHr)+@CONVERSION END As HeatLoadWithConversion,
        EnclosureSurfaceInWatts, 
       CASE WHEN(@ISBTU_HR=1)THEN Convert(varchar(50),EnclosureSurfaceInBtu)+@CONVERSION
                                ELSE Convert(varchar(50),EnclosureSurfaceInKcal)+@CONVERSION END As EnclosureSurfaceWithConversion,
        TBL_CAB.HeatLoad + EnclosureSurfaceInWatts As TotalWatts,
       CASE WHEN(@ISBTU_HR=1) THEN Convert(varchar(50),TBL_CAB.HeatLoadInBTU+EnclosureSurfaceInBtu)+@CONVERSION
                                ELSE Convert(varchar(50),TBL_CAB.HeatLoadInKcalHr + EnclosureSurfaceInKcal)+@CONVERSION END as TotalConversion                    
        ,'''+@Groups+'''  
 FROM Tbl_PHT_Cabinet_Temp TBL_TMP,Tbl_PHT_Cabinet_Configuration TBL_CAB  
 WHERE  TBL_TMP.CabinetID=TBL_CAB.CabinetID  
 AND TBL_CAB.ProjectID='''+convert(nvarchar(50), @ProjectID)+''' AND TBL_CAB.CabinetID IN (' + @Group + ')' +  
 'order by TBL_TMP.FanQuantity DESC'  
       
       
      -- print @MainQRY
 EXEC(@MainQRY)  
   
   
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchCabinetModule_CustomModels]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchCabinetModule_CustomModels] --0,'8b70bf68-46de-4578-a89f-73c9e85fa526',385
	@IsSMModule BIT,
	@CabinetID  VARCHAR(1500)='',
    @ModelIDs VARCHAR(1500)
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

		IF(@CabinetID = '00000000-0000-0000-0000-000000000000')
			SET @CabinetID = ''
        DECLARE @QRY VARCHAR(1500)
        IF(@IsSMModule = 1)
        BEGIN
			SET @QRY = 'SELECT *,Devices_OnBoards as nChan FROM Tbl_PHT_SMCabinet_Module WHERE '   
			IF(@CabinetID <> '')
				SET @QRY = @QRY + ' CabinetID IN (''' + @CabinetID + ''') AND '
			SET @QRY = @QRY + '  ModelID IN (' + @ModelIDs  + ') '
        END
        ELSE
        BEGIN
        --Commented by ram prasath
			--SET @QRY = 'SELECT * FROM Tbl_PHT_Cabinet_Module WHERE '  
			--IF(@CabinetID <> '') 
			--	SET @QRY = @QRY + ' CabinetID IN (''' + @CabinetID + ''') AND '
			--SET @QRY = @QRY + '  ModelID IN (' + @ModelIDs + ')'   
			
			SET @QRY = 'SELECT * FROM Tbl_PHT_Cabinet_Module WHERE '  
			IF(@CabinetID <> '') 
				SET @QRY = @QRY + ' Tbl_PHT_Cabinet_Module.CabinetID IN (''' + @CabinetID + ''') AND '
			SET @QRY = @QRY + '  Tbl_PHT_Cabinet_Module.ModelID IN (' + @ModelIDs + ')'
			  SET @QRY = @QRY + '  union select [CabinetModuleID],
	[CompID],
	''3eb06fd1-2f3c-4ead-9d32-fdc5a373f4e1'' as [PowerDrawTypeID],
	[ModelID],
	[ModelDescription],
	[Quantity],
	[IsUIO],
	[AI_UIO_ChannelCount] ,
	[AO_UIO_ChannelCount],
	[DI_UIO_ChannelCount],
	[DO_UIO_ChannelCount],
	[IOTA_UIO_ChannelCount],
	[FeederType],
	[OPCalc_A],
	[OPCalc_B],
	[OPCalc_C],
	[OPCalc_D],
	[OPCalc_E],
	[OPCalc_F],
	[OPCalc_G],
	[OPCalc_H] ,OPCalc_I,OPCalc_N,
	RowNum FROM Tbl_PHT_Miscelleneous_Module
WHERE  Tbl_PHT_Miscelleneous_Module.ModelID IN (' + @ModelIDs + ')'      
        END
        PRINT(@QRY)
        EXEC(@QRY)
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Delete_Cabinet]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Delete_Cabinet]     
 -- Add the parameters for the stored procedure here    
    @CabinetCabID VARCHAR(1500)    
AS     
    BEGIN    
        DECLARE @QRY VARCHAR(1500)  
        
        SET @QRY = 'DELETE FROM [Tbl_PHT_RUSIO_SM] WHERE '    
     
        SET @QRY = @QRY + ' Cabinet_ID IN (' + @CabinetCabID + ')'    
     
        EXEC(@QRY)   
        
          
            
          SET @QRY = 'DELETE FROM [Tbl_PHT_SMCabinet_Module] WHERE '    
     
        SET @QRY = @QRY + ' CabinetID IN (' + @CabinetCabID + ')'    
     
        EXEC(@QRY)    
          
            -- added by mani    
           SET @QRY = 'DELETE FROM [Tbl_PHT_Cabinet_Module] WHERE '    
     
        SET @QRY = @QRY + ' CabinetID IN (' + @CabinetCabID + ')'    
     
        EXEC(@QRY)    
            
        SET @QRY = 'DELETE FROM [Tbl_PHT_Cabinet_Configuration] WHERE '    
     
        SET @QRY = @QRY + ' CabinetID IN (' + @CabinetCabID + ')'    
     
        EXEC(@QRY)    
            
        SET @QRY = 'DELETE FROM [Tbl_PHT_Cabinet_Temp] WHERE '    
     
        SET @QRY = @QRY + ' CabinetID IN (' + @CabinetCabID + ')'    
     
        EXEC(@QRY)    
            
      --added by Ram Prasath
      SET @QRY = 'DELETE FROM [Tbl_PHT_Miscelleneous_Module] WHERE '    
     
        SET @QRY = @QRY + ' CompID IN (' + @CabinetCabID + ')'    
     
        EXEC(@QRY)    
            
        SET @QRY = 'DELETE FROM [Tbl_PHT_MiscComponents_Configuration] WHERE '    
     
        SET @QRY = @QRY + ' CompId IN (' + @CabinetCabID + ')'    
     
        EXEC(@QRY)    
            
           
            
         
    END    
------------------------------------------------------------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_CHECKPSUMODULE]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:  Shyamala         
-- Create date: 09-Sep-2015           
-- Description: To check the PSU module is referred in cabinets  
-- =============================================    
--DECLARE @DD BIT   
--exec SP_PHT_CHECKPSUMODULE 356,  @DD  output  
--select @DD  
  

--DECLARE @DD BIT   
--exec SP_PHT_CHECKPSUMODULE '18,2,355,360',  @DD  output  
--select @DD  

CREATE PROC [dbo].[SP_PHT_CHECKPSUMODULE]    
    @MODULEID VARCHAR(500),  
    @OUTPUT BIT OUTPUT   
AS          
BEGIN
DECLARE @MODCOUNT INT;
DECLARE @TBLMODELCOUNT TABLE 
(
 FRONTCOUNT INT,
 REARCOUNT INT,
 SMPSCOUNT INT
 );
DECLARE @QRY NVARCHAR(4000)
  SET @QRY = 'DECLARE @FRONTPSCOUNT INT '   
  SET @QRY = @QRY +  'DECLARE @REARPSCOUNT INT '  
  SET @QRY = @QRY +  'DECLARE @SMPSUCONFIG INT '  
  SET @QRY = @QRY + ' 
  DECLARE @MODELCOUNT TABLE 
(
  FRONTCOUNT INT,
 REARCOUNT INT,
 SMPSCOUNT INT );'
SET @QRY = @QRY + ' 
SELECT @FRONTPSCOUNT=COUNT(PSFront) FROM [Tbl_PHT_Cabinet_Configuration] ' +
' WHERE PSFront IN('+@MODULEID+')' 

SET @QRY = @QRY + '
SELECT @REARPSCOUNT= COUNT(PSREAR)FROM [Tbl_PHT_Cabinet_Configuration] ' + 
' WHERE PSREAR IN('+@MODULEID+')' 

SET @QRY = @QRY + ' 
SELECT @SMPSUCONFIG =COUNT(SMCONF.ModelID) FROM Tbl_PHT_PowerSupply_SMCabinet SMCONF ' +
' WHERE SMCONF.ModelID IN (' +@MODULEID+')'

SET @QRY = @QRY + ' 
INSERT @MODELCOUNT '+
 ' SELECT  @FRONTPSCOUNT,@REARPSCOUNT,@SMPSUCONFIG '
 SET @QRY = @QRY + ' 
 SELECT * FROM @MODELCOUNT'

  INSERT @TBLMODELCOUNT EXEC sp_executesql @QRY;
  SELECT * FROM @TBLMODELCOUNT
SELECT @OUTPUT= COUNT(*) FROM @TBLMODELCOUNT WHERE FRONTCOUNT>0 OR REARCOUNT>0 OR  SMPSCOUNT>0   
 
 RETURN @OUTPUT
       
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPHCabinetTypeName]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[sp_GETPHCabinetTypeName] --''
@ProjectName VARCHAR(1500)='',
@CabinetName VARCHAR(1500)='',
@AreaName VARCHAR(1500)='',
@LocationName VARCHAR(1500)=''
AS 
    BEGIN
        SET NOCOUNT ON 
  DECLARE @PName VARCHAR(1500)=''
  DECLARE @CName VARCHAR(1500)=''
  DECLARE @AName VARCHAR(1500)=''
  DECLARE @LName VARCHAR(1500)=''
  DECLARE @QRY VARCHAR(1500)
 IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''' '
            end     
             IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''' '
            end  
             IF ( @AreaName <> '' ) 
            BEGIN
            SET @AName = ' and TC.Area='''+@AreaName+''' '
            end     
             IF ( @LocationName <> '' ) 
            BEGIN
            SET @LName = ' and TC.Location='''+@LocationName+''' '
            end       
       SET @QRY = '
select distinct TCT.CabinetTypeName from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Cabinet_Type TCT,Tbl_PHT_Project TP
where TC.CabinetTypeID=TCT.CabinetTypeID and TC.ProjectID=TP.ProjectId' +@PName+@CName+@AName+@LName
print @QRY
exec(@QRY)
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPHCabinetName]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GETPHCabinetName] --''
@ProjectName VARCHAR(1500)=''
AS 
    BEGIN
        SET NOCOUNT ON 
  DECLARE @PName VARCHAR(1500)=''
  DECLARE @QRY VARCHAR(1500)
 IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''''
            end       
       SET @QRY = 'select CabinetID,CabinetName from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP
where TC.ProjectID=TP.ProjectId' +@PName
print @QRY
exec(@QRY)
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPHArea]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[sp_GETPHArea] --''
@ProjectName VARCHAR(1500)='',
@CabinetName VARCHAR(1500)=''
AS 
    BEGIN
        SET NOCOUNT ON 
  DECLARE @PName VARCHAR(1500)=''
  DECLARE @CName VARCHAR(1500)=''
  DECLARE @QRY VARCHAR(1500)
 IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''' '
            end     
             IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''' '
            end       
       SET @QRY = 'select distinct Area from (
select TC.Area from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_Project TP
where TC.CabinetID=TM.CabinetID and TC.ProjectID=TP.ProjectId' +@PName+@CName+ ' union select TC.Area from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_Project TP
where TC.CabinetID=TM.CabinetID and TC.ProjectID=TP.ProjectId' +@PName+@CName+') s'
print @QRY
exec(@QRY)
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPH60VDCps]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GETPH60VDCps]    -- 'test','testSM'
 -- Add the parameters for the stored procedure here    
   @ProjectName VARCHAR(1500)='',
    @CabinetName VARCHAR(1500)='',
    @AreaName VARCHAR(1500)='',
    @LocationName VARCHAR(1500)='',
    @CabinetTypeName VARCHAR(1500)='',
    @ModelView int=0
AS    

Begin
       DECLARE @QRY VARCHAR(1500)
DECLARE @PName VARCHAR(1500)=''
DECLARE @CName VARCHAR(1500)=''
DECLARE @AName VARCHAR(1500)=''
DECLARE @LName VARCHAR(1500)=''
DECLARE @CTName VARCHAR(1500)=''
DECLARE @GroupBy VARCHAR(1500)=' group By ProjectName,CabinetName,HoneywellModel'
IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''''
            end        
  IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''''
            end      
     IF ( @AreaName <> '' ) 
            BEGIN
            SET @AName = ' and TC.Area='''+@AreaName+''''
            end  
             IF ( @LocationName <> '' ) 
            BEGIN
            SET @LName = ' and TC.Location='''+@LocationName+''''
            end  
             IF ( @CabinetTypeName <> '' ) 
            BEGIN
            SET @CTName = ' and TCT.CabinetTypeName='''+@CabinetTypeName+''''
            end  
            if(@ModelView=0)
            begin
            SET @QRY = 'select TPS.HoneywellModel as ModuleName,TM.TotalHeat_Des_Watts as HeatDiss,TP.ProjectName,TC.CabinetName,TM.IDC_Pri as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
and TPS.OUTPUTVOLTAGE=''60VDC'''+@PName+@CName+@AName+@LName+@CTName
end
else if(@ModelView=1)
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,Sum(IDC_Pri/1000) as IDC,Sum(TM.TotalHeat_Des_Watts) as HeatDiss,Sum(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID and TMD.[60V_IO]=1 and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
else
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,Sum(IDC_Pri/1000) as IDC,Sum(TM.TotalHeat_Des_Watts) as HeatDiss,Sum(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID and (TMD.[24V_IO]=1 or TMD.[48V_IO]=1 or TMD.[60V_IO]=1 or TMD.[110V_IO]=1) and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
print @QRY
EXEC(@QRY)
End

--End
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPH48VDCps]    Script Date: 06/09/2017 21:18:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GETPH48VDCps]    -- 'test','testSM'
 -- Add the parameters for the stored procedure here    
   @ProjectName VARCHAR(1500)='',
    @CabinetName VARCHAR(1500)='',
    @AreaName VARCHAR(1500)='',
    @LocationName VARCHAR(1500)='',
    @CabinetTypeName VARCHAR(1500)='',
    @ModelView int=0
AS    

Begin
       DECLARE @QRY VARCHAR(1500)
DECLARE @PName VARCHAR(1500)=''
DECLARE @CName VARCHAR(1500)=''
DECLARE @AName VARCHAR(1500)=''
DECLARE @LName VARCHAR(1500)=''
DECLARE @CTName VARCHAR(1500)=''
DECLARE @GroupBy VARCHAR(1500)=' group By ProjectName,CabinetName,HoneywellModel'
IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''''
            end        
  IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''''
            end      
     IF ( @AreaName <> '' ) 
            BEGIN
            SET @AName = ' and TC.Area='''+@AreaName+''''
            end  
             IF ( @LocationName <> '' ) 
            BEGIN
            SET @LName = ' and TC.Location='''+@LocationName+''''
            end  
             IF ( @CabinetTypeName <> '' ) 
            BEGIN
            SET @CTName = ' and TCT.CabinetTypeName='''+@CabinetTypeName+''''
            end  
            if(@ModelView=0)
            begin
            SET @QRY = 'select TPS.HoneywellModel as ModuleName,TM.TotalHeat_Des_Watts as HeatDiss,TP.ProjectName,TC.CabinetName,TM.IDC_Pri as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
and TPS.OUTPUTVOLTAGE=''48VDC'''+@PName+@CName+@AName+@LName+@CTName
end
else if(@ModelView=1)
begin
SET @QRY = 'select TMD.HoneywellModel as ModuleName,TC.CabinetName as CabinetName,TP.ProjectName,Sum(IDC_Pri/1000) as IDC,Sum(TM.TotalHeat_Des_Watts) as HeatDiss,Sum(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID and TMD.[48V_IO]=1 and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
else
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,Sum(IDC_Pri/1000) as IDC,Sum(TM.TotalHeat_Des_Watts) as HeatDiss,Sum(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID and (TMD.[24V_IO]=1 or TMD.[48V_IO]=1 or TMD.[60V_IO]=1 or TMD.[110V_IO]=1) and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
print @QRY
EXEC(@QRY)
End

--End
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPH24VDCps]    Script Date: 06/09/2017 21:18:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GETPH24VDCps]    -- 'test','testSM'
 -- Add the parameters for the stored procedure here    
   @ProjectName VARCHAR(1500)='',
    @CabinetName VARCHAR(1500)='',
    @AreaName VARCHAR(1500)='',
    @LocationName VARCHAR(1500)='',
    @CabinetTypeName VARCHAR(1500)='',
    @ModelView int=0
AS    

Begin
       DECLARE @QRY VARCHAR(1500)
DECLARE @PName VARCHAR(1500)=''
DECLARE @CName VARCHAR(1500)=''
DECLARE @AName VARCHAR(1500)=''
DECLARE @LName VARCHAR(1500)=''
DECLARE @CTName VARCHAR(1500)=''
DECLARE @GroupBy VARCHAR(1500)=' group By ProjectName,CabinetName,HoneywellModel'
DECLARE @GroupBy1 VARCHAR(1500)=' group By ProjectName,CabinetName'

IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''''
            end        
  IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''''
            end      
     IF ( @AreaName <> '' ) 
            BEGIN
            SET @AName = ' and TC.Area='''+@AreaName+''''
            end  
             IF ( @LocationName <> '' ) 
            BEGIN
            SET @LName = ' and TC.Location='''+@LocationName+''''
            end  
             IF ( @CabinetTypeName <> '' ) 
            BEGIN
            SET @CTName = ' and TCT.CabinetTypeName='''+@CabinetTypeName+''''
            end  
            if(@ModelView=-1)
            begin
            SET @QRY = 'select '''' as ModuleName,sum(TM.TotalHeat_Des_Watts) as HeatDiss,TP.ProjectName,TC.CabinetName,sum(TM.IDC_Pri) as IDC,Sum(TPS.CurrentRating) as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
'+@PName+@CName+@AName+@LName+@CTName+@GroupBy1
end
           else if(@ModelView=0)
            begin
            SET @QRY = 'select TPS.HoneywellModel as ModuleName,TM.TotalHeat_Des_Watts as HeatDiss,TP.ProjectName,TC.CabinetName,TM.IDC_Pri as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
and TPS.OUTPUTVOLTAGE=''24VDC'''+@PName+@CName+@AName+@LName+@CTName
end
else if(@ModelView=1)
begin
SET @QRY = 'select TMD.HoneywellModel as ModuleName,TC.CabinetName as CabinetName,TP.ProjectName,Sum(IDC_Pri/1000) as IDC,Sum(TM.TotalHeat_Des_Watts) as HeatDiss,Sum(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID and TMD.[24V_IO]=1 and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
else
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,Sum(IDC_Pri/1000) as IDC,Sum(TM.TotalHeat_Des_Watts) as HeatDiss,Sum(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID and (TMD.[24V_IO]=1 or TMD.[48V_IO]=1 or TMD.[60V_IO]=1 or TMD.[110V_IO]=1) and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
print @QRY
EXEC(@QRY)
End

--End
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPH110VDCps]    Script Date: 06/09/2017 21:18:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GETPH110VDCps]    -- 'test','testSM'
 -- Add the parameters for the stored procedure here    
   @ProjectName VARCHAR(1500)='',
    @CabinetName VARCHAR(1500)='',
    @AreaName VARCHAR(1500)='',
    @LocationName VARCHAR(1500)='',
    @CabinetTypeName VARCHAR(1500)='',
    @ModelView int=0
AS    

Begin
       DECLARE @QRY VARCHAR(1500)
DECLARE @PName VARCHAR(1500)=''
DECLARE @CName VARCHAR(1500)=''
DECLARE @AName VARCHAR(1500)=''
DECLARE @LName VARCHAR(1500)=''
DECLARE @CTName VARCHAR(1500)=''
DECLARE @GroupBy VARCHAR(1500)=' group By ProjectName,CabinetName,HoneywellModel'
IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''''
            end        
  IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''''
            end      
     IF ( @AreaName <> '' ) 
            BEGIN
            SET @AName = ' and TC.Area='''+@AreaName+''''
            end  
             IF ( @LocationName <> '' ) 
            BEGIN
            SET @LName = ' and TC.Location='''+@LocationName+''''
            end  
             IF ( @CabinetTypeName <> '' ) 
            BEGIN
            SET @CTName = ' and TCT.CabinetTypeName='''+@CabinetTypeName+''''
            end  
            if(@ModelView=0)
            begin
            SET @QRY = 'select TPS.HoneywellModel as ModuleName,TM.TotalHeat_Des_Watts as HeatDiss,TP.ProjectName,TC.CabinetName,TM.IDC_Pri as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
and TPS.OUTPUTVOLTAGE=''110VDC'''+@PName+@CName+@AName+@LName+@CTName
end
else if(@ModelView=1)
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,Sum(IDC_Pri/1000) as IDC,Sum(TM.TotalHeat_Des_Watts) as HeatDiss,Sum(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID and TMD.[110V_IO]=1 and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
else
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,Sum(IDC_Pri/1000) as IDC,Sum(TM.TotalHeat_Des_Watts) as HeatDiss,Sum(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID and (TMD.[24V_IO]=1 or TMD.[48V_IO]=1 or TMD.[60V_IO]=1 or TMD.[110V_IO]=1) and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
print @QRY
EXEC(@QRY)
End

--End
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPHLocation]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[sp_GETPHLocation] --''
@ProjectName VARCHAR(1500)='',
@CabinetName VARCHAR(1500)='',
@AreaName VARCHAR(1500)=''
AS 
    BEGIN
        SET NOCOUNT ON 
  DECLARE @PName VARCHAR(1500)=''
  DECLARE @CName VARCHAR(1500)=''
  DECLARE @AName VARCHAR(1500)=''
  DECLARE @QRY VARCHAR(1500)
 IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''' '
            end     
             IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''' '
            end  
             IF ( @AreaName <> '' ) 
            BEGIN
            SET @AName = ' and TC.Area='''+@AreaName+''' '
            end       
       SET @QRY = 'select distinct Location from (
select TC.Location from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_Project TP
where TC.CabinetID=TM.CabinetID and TC.ProjectID=TP.ProjectId' +@PName+@CName+@AName+' union select TC.Location from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_Project TP
where TC.CabinetID=TM.CabinetID and TC.ProjectID=TP.ProjectId' +@PName+@CName+@AName+') s'
print @QRY
exec(@QRY)
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPHREARps]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GETPHREARps] --  '',''  
 -- Add the parameters for the stored procedure here    
     @ProjectName VARCHAR(1500)='',
    @CabinetName VARCHAR(1500)='',
    @AreaName VARCHAR(1500)='',
    @LocationName VARCHAR(1500)='',
    @CabinetTypeName VARCHAR(1500)='',
    @ModelView int=0
AS    

Begin
       DECLARE @QRY VARCHAR(1500)
DECLARE @PName VARCHAR(1500)=''
DECLARE @CName VARCHAR(1500)=''
DECLARE @AName VARCHAR(1500)=''
DECLARE @LName VARCHAR(1500)=''
DECLARE @CTName VARCHAR(1500)=''
DECLARE @GroupBy VARCHAR(1500)=' group By ProjectName,CabinetName,HoneywellModel'

IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''''
            end        
  IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''''
            end      
     IF ( @AreaName <> '' ) 
            BEGIN
            SET @AName = ' and TC.Area='''+@AreaName+''''
            end  
             IF ( @LocationName <> '' ) 
            BEGIN
            SET @LName = ' and TC.Location='''+@LocationName+''''
            end  
             IF ( @CabinetTypeName <> '' ) 
            BEGIN
            SET @CTName = ' and TCT.CabinetTypeName='''+@CabinetTypeName+''''
            end  
            if(@ModelView=0)
            begin
SET @QRY = 'select TPS.HoneywellModel as ModuleName,TM.OPCalc_F as HeatDiss,TP.ProjectName,TC.CabinetName,TM.OPCalc_A as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
 and ModelDescription like ''%- Rear PS%'''+@PName+@CName+@AName+@LName+@CTName
end
else if(@ModelView=1)
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,SUM(OPCalc_A) as IDC,SUM(TM.OPCalc_F) as HeatDiss,SUM(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID  and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'' and TM.PowerDrawTypeID=''8224F746-CFB1-4C67-82EA-FE6B0E420127'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
else
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,SUM(OPCalc_A) as IDC,SUM(TM.OPCalc_F) as HeatDiss,SUM(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID  and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'' and (TM.PowerDrawTypeID=''CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5'' or TM.PowerDrawTypeID=''8224F746-CFB1-4C67-82EA-FE6B0E420127'')'+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
EXEC(@QRY)
End
GO
/****** Object:  StoredProcedure [dbo].[sp_PHT_Delete_Group]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_PHT_Delete_Group]  
@GroupID varchar(100)   
AS   
  
Begin  
  
 exec('delete from tbl_PHT_Groups where ID  in ( ' + @GroupID + ')')  
   
  
 End
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Delete_Module]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Delete_Module] 
	-- Add the parameters for the stored procedure here
    @CabinetModuleID VARCHAR(1500)
 
AS 
    BEGIN
        DECLARE @QRY VARCHAR(1500)
        SET @QRY = 'DELETE FROM Tbl_PHT_RUSIO_SM WHERE '   
      
                SET @QRY = @QRY + ' Module_ID IN (' + @CabinetModuleID + ')' 
        EXEC(@QRY)   
        SET @QRY = 'DELETE FROM Tbl_PHT_Cabinet_Module WHERE '   
      
                SET @QRY = @QRY + ' CabinetModuleID IN (' + @CabinetModuleID + ')'        
     
        EXEC(@QRY)
          SET @QRY = 'DELETE FROM Tbl_PHT_SMCabinet_Module WHERE '    
       
                SET @QRY = @QRY + ' CabinetModuleID IN (' + @CabinetModuleID  + ')'
        EXEC(@QRY)
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Delete_MiscelleneousModule]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Delete_MiscelleneousModule]     --'b0986182-f391-448e-98c3-31e8f2ec8e84'
 -- Add the parameters for the stored procedure here    
    @CabinetCabID VARCHAR(max)    
AS     
    BEGIN    
      DECLARE @QRY VARCHAR(max)
          
        SET @QRY = 'DELETE FROM [Tbl_PHT_Miscelleneous_Module] WHERE '   
      
                SET @QRY = @QRY + ' CabinetModuleID IN (' + @CabinetCabID + ')'        
     
        EXEC(@QRY)
      --  DECLARE @QRY VARCHAR(1500)  
        
      --DELETE FROM [Tbl_PHT_Miscelleneous_Module] WHERE CabinetModuleID IN (@CabinetCabID )
      --DELETE FROM [Tbl_PHT_MiscComponents_Configuration] WHERE CompID IN (@CabinetCabID )
            -- added by mani    
     --      SET @QRY = 'DELETE FROM [Tbl_PHT_Miscelleneous_Module] WHERE '    
     
     --   SET @QRY = @QRY + ' CabinetModuleID IN (' + @CabinetCabID + ')'    
     --print @QRY
     --   EXEC(@QRY)    
            
       --select * from [Tbl_PHT_Miscelleneous_Module]
                   
            
         
    END    
------------------------------------------------------------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_CabinetList]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_CabinetList] --'1C29AB46-5CD1-405F-9ECE-498918005EF2','help','helpsm','none'
	-- Add the parameters for the stored procedure here
    @ProjectID UNIQUEIDENTIFIER ,
    @Location NVARCHAR(256) ,
    @Area NVARCHAR(256) ,
    @CabinetType NVARCHAR(256) 
AS 
    BEGIN
        DECLARE @QRY VARCHAR(1500)
        SET @QRY = 'SELECT  TBL_CAB.Location, TBL_CAB.Area,TBL_CAB_TYP.CabinetTypeName ,TBL_CAB.CabinetID, TBL_CAB.CabinetName, TBL_CAB.CabinetDesc, ISNULL(TBL_CAB.IsActive,0) AS IsActive, TBL_CAB.HostName,0 as delstatus,ISNULL(TBL_CAB.Is_IDCCheck,0) as Is_IDCCheck,TBL_CAB.IDCError FROM Tbl_PHT_Cabinet_Configuration TBL_CAB,Tbl_PHT_Cabinet_Type TBL_CAB_TYP  WHERE TBL_CAB.CabinetTypeID=TBL_CAB_TYP.CabinetTypeID AND TBL_CAB.ProjectID='''
            + CONVERT(VARCHAR(250), @ProjectID) + ''''
            
            

        IF ( @Location <> 'ALL' ) 
            BEGIN
                SET @QRY = @QRY + ' AND TBL_CAB.Location=''' + @Location + ''''
            END
        IF ( @Area <> 'ALL' ) 
            BEGIN
                SET @QRY = @QRY + ' AND  TBL_CAB.Area=''' + @Area + ''''
            END	
        IF ( @CabinetType <> 'ALL' and @CabinetType <> '') 
            BEGIN
                SET @QRY = @QRY + ' AND  TBL_CAB_TYP.CabinetTypeName=''' + @CabinetType + ''''
                   -- + CONVERT(VARCHAR(10), @CabinetType) + ''
            END	
            SET @QRY = @QRY + 'union SELECT  TBL_MISC.Location, TBL_MISC.Area,TBL_MISC_TYP.MiscTypeName ,TBL_MISC.CompID, TBL_MISC.Name, TBL_MISC.[Desc], 0 AS IsActive, '''' as HostName,0 as delstatus,0 as Is_IDCCheck,'''' as IDCError FROM Tbl_PHT_MiscComponents_Configuration TBL_MISC,Tbl_PHT_Miscelleneous_Type TBL_MISC_TYP  WHERE TBL_MISC.MiscTypeID=TBL_MISC_TYP.MiscTypeID  AND TBL_MISC.ProjectID='''
            + CONVERT(VARCHAR(250), @ProjectID) + ''''
             IF ( @Location <> 'ALL' ) 
            BEGIN
                SET @QRY = @QRY + ' AND TBL_MISC.Location=''' + @Location + ''''
            END
        IF ( @Area <> 'ALL' ) 
            BEGIN
                SET @QRY = @QRY + ' AND  TBL_MISC.Area=''' + @Area + ''''
            END	
            IF ( @CabinetType <> 'ALL' and @CabinetType <> '') 
            BEGIN
                SET @QRY = @QRY + ' AND  TBL_MISC_TYP.MiscTypeName=''' + @CabinetType + ''''
            END	
            print @QRY
        EXEC(@QRY)
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_PHT_GroupExists]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PHT_GroupExists]
@GroupID VARCHAR(100) 
AS 

BEGIN

 EXEC('select Group_Name from tbl_PHT_Groups where ID in(select distinct GroupID from Tbl_PHT_SMCabinet_Module where GroupID in( ' + @GroupID + '))')
 
 
 END
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_PHT_GROUP]    Script Date: 06/09/2017 21:18:26 ******/
CREATE TYPE [dbo].[TYPE_PHT_GROUP] AS TABLE(
	[Group Name] [nvarchar](256) NULL,
	[Group Type] [nvarchar](256) NULL,
	[Group ID] [nvarchar](256) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Type_PHT_AdvSetting_Update_SMCabinet]    Script Date: 06/09/2017 21:18:26 ******/
CREATE TYPE [dbo].[Type_PHT_AdvSetting_Update_SMCabinet] AS TABLE(
	[CabinetModuleID] [varchar](40) NULL,
	[TotalHeat_Des_Watts] [varchar](40) NULL,
	[TotalHeat_Des_Btu] [varchar](40) NULL,
	[IDC_Pri] [varchar](40) NULL,
	[IAC_Pri] [varchar](40) NULL,
	[TotalVA] [decimal](9, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Type_PHT_AdvSetting_Update_RUSIO]    Script Date: 06/09/2017 21:18:26 ******/
CREATE TYPE [dbo].[Type_PHT_AdvSetting_Update_RUSIO] AS TABLE(
	[ID] [varchar](20) NULL,
	[Total_Heat_Dessipation] [varchar](40) NULL,
	[TotalPower] [varchar](40) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Type_PHT_AdvSetting_Update_CabinetTemperature]    Script Date: 06/09/2017 21:18:26 ******/
CREATE TYPE [dbo].[Type_PHT_AdvSetting_Update_CabinetTemperature] AS TABLE(
	[CabinetID] [varchar](40) NULL,
	[FanQuantity] [varchar](40) NULL,
	[Tambient] [varchar](40) NULL,
	[dT] [varchar](40) NULL,
	[CabTemp] [varchar](40) NULL
)
GO
/****** Object:  Table [dbo].[TBL_PHT_ToolVersion]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_PHT_ToolVersion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Version_Number] [real] NULL,
	[Created_Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_PHT_SMCabinet_Module]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_SMCabinet_Module](
	[CabinetModuleID] [uniqueidentifier] NOT NULL,
	[CabinetID] [uniqueidentifier] NULL,
	[GroupID] [int] NULL,
	[PowerDrawTypeID] [uniqueidentifier] NOT NULL,
	[ModelID] [int] NOT NULL,
	[ModelDescription] [nvarchar](256) NULL,
	[Quantity] [int] NOT NULL,
	[Is_Redundant] [bit] NULL,
	[Is_RUISO] [bit] NULL,
	[IS_DO] [bit] NULL,
	[AI_RUSIO_ChannelCount] [int] NULL,
	[AO_RUSIO_ChannelCount] [int] NULL,
	[DI_RUSIO_ChannelCount] [int] NULL,
	[DO_RUSIO_ChannelCount] [int] NULL,
	[FeederType] [bit] NULL,
	[IDC_Pri] [decimal](16, 2) NULL,
	[IAC_Pri] [decimal](16, 2) NULL,
	[TotalHeat_Des_Watts] [decimal](16, 2) NULL,
	[TotalHeat_Des_Btu] [decimal](16, 2) NULL,
	[Total_Current] [decimal](16, 2) NULL,
	[IAC_Sec] [decimal](16, 1) NULL,
	[RowNum] [int] NULL,
	[Load] [decimal](16, 2) NULL,
	[IS_FTA] [bit] NULL,
	[UseIn_HeatCalc] [bit] NULL,
	[VDC_Type] [int] NULL,
	[Vdrop] [decimal](16, 2) NULL,
	[TotalVA] [decimal](16, 2) NULL,
	[Devices_OnBoards] [int] NULL,
 CONSTRAINT [PK_Tbl_PH_SMCabinet_Module] PRIMARY KEY CLUSTERED 
(
	[CabinetModuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PHT_SM_Units]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_PHT_SM_Units](
	[ChannelType] [varchar](10) NOT NULL,
	[Units] [decimal](16, 3) NULL,
	[IsRusio] [bit] NULL,
	[Load] [decimal](16, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 06/09/2017 21:18:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Boopathi M
-- Create date: 19-Jun-2013
-- Description:	To split strings
-- =============================================
CREATE FUNCTION [dbo].[SplitString]
(    
      @Input NVARCHAR(MAX)--,
      --@Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> ','
      BEGIN
            SET @Input = @Input + ','
      END
 
      WHILE CHARINDEX(',', @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(',', @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END
GO
/****** Object:  Table [dbo].[Tbl_PHT_Report_Setting]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Report_Setting](
	[ReportSettingID] [uniqueidentifier] NOT NULL,
	[ProjectID] [uniqueidentifier] NOT NULL,
	[ReportTitle] [nvarchar](256) NULL,
	[ReportSubTitle1] [nvarchar](256) NULL,
	[ReportSubTitle2] [nvarchar](256) NULL,
	[ReportSubTitle3] [nvarchar](256) NULL,
	[RptTitleReportCover] [bit] NULL,
	[RptTitleReportHeader] [bit] NULL,
	[RptSubTitle1ReportCover] [bit] NULL,
	[RptSubTitle2ReportCover] [bit] NULL,
	[RptSubTitle3ReportCover] [bit] NULL,
	[AdvPowerSupplyEff] [decimal](10, 2) NULL,
	[AdvPowerFactor] [decimal](10, 2) NULL,
	[AdvInrushCurrent] [decimal](10, 2) NULL,
	[AdvAdmbientTemp] [decimal](10, 2) NULL,
	[AdvPowerHeatUnit] [bit] NULL,
	[AdvIsPowerFactor] [bit] NULL,
	[LatestRevision] [bit] NULL,
 CONSTRAINT [PK_Tbl_PH_Report_Setting] PRIMARY KEY CLUSTERED 
(
	[ReportSettingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchUnsavedModules]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchUnsavedModules]
	@IsSMModule BIT, 
	@ModuleGroup VARCHAR(100)
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
		 
        SET NOCOUNT ON ;

		CREATE TABLE #Modules (Item VARCHAR(200))
		INSERT INTO #Modules SELECT Item FROM dbo.SplitString(@ModuleGroup)
	
        DECLARE @QRY VARCHAR(1500)
		SET @QRY = 'SELECT  ModelID FROM Tbl_PHT_ModuleDef WHERE'    
        IF(@IsSMModule = 1)
        BEGIN
			SET @QRY = @QRY + ' ModelID not IN (select modelid from Tbl_PHT_SMCabinet_Module WHERE ModelDescription=Description and PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'')'
        END
        ELSE
        BEGIN
			SET @QRY = @QRY + ' ModelID not IN (select modelid from Tbl_PHT_Cabinet_Module where PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'')'        
        END
        SET @QRY = @QRY + ' AND IsCustom = 1  AND  Module_Group IN (SELECT Item FROM #Modules )'
        
        SET @QRY =@QRY+ 'UNION SELECT  ModelID FROM Tbl_PHT_PowerSupply_ModuleDef WHERE'    
        IF(@IsSMModule = 1)
        BEGIN
			SET @QRY = @QRY + ' ModelID not IN (select modelid from Tbl_PHT_SMCabinet_Module WHERE ModelDescription=Description and PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'')'
        END
        ELSE
        BEGIN
			SET @QRY = @QRY + ' ModelID not IN (select modelid from Tbl_PHT_Cabinet_Module where PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'')'        
        END
        SET @QRY = @QRY + ' AND IsCustom = 1  AND  Module_Group IN (SELECT Item FROM #Modules )'
        
        PRINT @QRY
        EXEC(@QRY)
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchProjectSettingsList]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  

CREATE PROCEDURE [dbo].[SP_PHT_FetchProjectSettingsList]  
AS   
    BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
        SET NOCOUNT ON ;  
  
        SELECT  ProjectID,ProjectName,CustomerName,PONbr,ProjectNbr, HonDocumentNbr,CustomerDocumentNbr,ProjNameReportHeader,ProjNbrReportCover,
        ProjNbrReportHeader,HonDocNbrReportCover,HonDocNbrReportHeader,CustomerDocNbrReportCover,CustomerDocNbrReportHeader,InputVoltage,
        InputFrequency,CreatedBy,convert(datetime,CreatedDate)as CreatedDate,ModifiedBy,convert(datetime,ModifiedDate)as ModifiedDate
        FROM    Tbl_PHT_Project ;  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchProjectSettings]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchProjectSettings]  
    @ProjectID UNIQUEIDENTIFIER  
AS   
    BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
        SET NOCOUNT ON ;  
  
    -- Insert statements for procedure here  
        SELECT   ProjectID,ProjectName,CustomerName,PONbr,ProjectNbr, HonDocumentNbr,CustomerDocumentNbr,ProjNameReportHeader,ProjNbrReportCover,
        ProjNbrReportHeader,HonDocNbrReportCover,HonDocNbrReportHeader,CustomerDocNbrReportCover,CustomerDocNbrReportHeader,InputVoltage,
        InputFrequency,CreatedBy,convert(datetime,CreatedDate) as CreatedDate,ModifiedBy,convert(datetime,ModifiedDate) as ModifiedDate 
        FROM    [PowerHeatCalc].[dbo].[Tbl_PHT_Project]  
        WHERE   ProjectID = @ProjectID ;  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchMiscelleneousModule]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchMiscelleneousModule] --'00000000-0000-0000-0000-000000000000'  
    @CabinetID UNIQUEIDENTIFIER  
AS   
    BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
        SET NOCOUNT ON ;  
  
        SELECT  *,CompID as CabinetID,NeWID() as PowerDrawTypeID  
        FROM    Tbl_PHT_Miscelleneous_Module  
        WHERE   CompID = @CabinetID  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FETCH_SMPSU]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FETCH_SMPSU]          
 @CABINETID uniqueidentifier,  
 @POWERSUPPLY VARCHAR(50) ,
 @MODELID INT 
   
 AS  
 BEGIN  
   
   --IF(@POWERSUPPLY<>'')
   --BEGIN
			-- SELECT MD.ModelID,MD.OutputVoltage,CabinetModuleID,IDC_Pri,TotalHeat_Des_Watts,TotalHeat_Des_Btu FROM Tbl_PHT_SMCabinet_Module SCM INNER JOIN Tbl_PHT_ModuleDef MD ON MD.ModelID=SCM.ModelID  
			-- WHERE CabinetID=@CABINETID  
			-- AND OutputVoltage=@POWERSUPPLY  
   --END
   --ELSE IF(@POWERSUPPLY='' AND @MODELID>0)
   --BEGIN
   --          SELECT MD.ModelID,MD.OutputVoltage,CabinetModuleID,IDC_Pri,TotalHeat_Des_Watts,TotalHeat_Des_Btu FROM Tbl_PHT_SMCabinet_Module SCM INNER JOIN Tbl_PHT_ModuleDef MD ON MD.ModelID=SCM.ModelID  
			-- WHERE CabinetID=@CABINETID  
			-- AND SCM.ModelID=@MODELID 
   --END
       
   
   IF(@POWERSUPPLY<>'')
   BEGIN
			 SELECT MD.ModelID,MD.OutputVoltage,CabinetModuleID,IDC_Pri,TotalHeat_Des_Watts,TotalHeat_Des_Btu FROM Tbl_PHT_SMCabinet_Module SCM INNER JOIN Tbl_PHT_PowerSupply_ModuleDef MD ON MD.ModelID=SCM.ModelID  
			 WHERE CabinetID=@CABINETID  
			 AND OutputVoltage=@POWERSUPPLY  and PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
   END
   ELSE IF(@POWERSUPPLY='' AND @MODELID>0)
   BEGIN
             SELECT MD.ModelID,MD.OutputVoltage,CabinetModuleID,IDC_Pri,TotalHeat_Des_Watts,TotalHeat_Des_Btu FROM Tbl_PHT_SMCabinet_Module SCM INNER JOIN Tbl_PHT_PowerSupply_ModuleDef MD ON MD.ModelID=SCM.ModelID  
			 WHERE CabinetID=@CABINETID  
			 AND SCM.ModelID=@MODELID and PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
   END
 END
GO
/****** Object:  StoredProcedure [dbo].[sp_PHT_Fetch_SM_Units]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author: Manimaran  
-- Create date: 6-sep-2014  
-- Description:Fetchin SM Units  
-- =============================================      
CREATE PROCEDURE [dbo].[sp_PHT_Fetch_SM_Units]    
     
AS    
BEGIN    
 select ChannelType,Units,IsRusio,[Load] from tbl_PHT_SM_Units    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Project_Name_Exist]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Visweswaran Varadarajan
-- Create date: 17-Jun-2013
-- Description:	To Check the Cabinet configuration based on Cabient Type Id and Cabinet name
-- =============================================
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_Project_Name_Exist] 
	-- Add the parameters for the stored procedure here
	@ProjectID UNIQUEIDENTIFIER, 
    @ProjectName NVARCHAR(256)     
    
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;
       select * from Tbl_PHT_Project where ProjectID != @ProjectID and ProjectName=@ProjectName
            END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_PowerDrawType]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_PowerDrawType]
	-- Add the parameters for the stored procedure here
    @TypeID UNIQUEIDENTIFIER ,
    @TypeName VARCHAR(150)
AS 
    BEGIN
        IF ( LEN(@TypeName) > 0 ) 
            BEGIN
                IF ( @TypeName = 'ALL' ) 
                    BEGIN
                        SELECT  PowerDrawTypeID ,
                                PowerDrawType
                        FROM    Tbl_PHT_Power_Draw_Type
                    END
                ELSE 
                    BEGIN
                        SELECT  PowerDrawTypeID ,
                                PowerDrawType
                        FROM    Tbl_PHT_Power_Draw_Type
                        WHERE   PowerDrawType = @TypeName
                    END
            END
        ELSE 
            BEGIN
                SELECT  PowerDrawTypeID ,
                        PowerDrawType
                FROM    Tbl_PHT_Power_Draw_Type
                WHERE   PowerDrawTypeID = @TypeID
            END
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FETCH_PHValues]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_PHT_FETCH_PHValues]      
@Cabinetid uniqueidentifier,      
      
@Power int      
      
as      
begin      
select ISNULL(sum(IDC_Pri),0) + ISNULL(SUM(IAC_Pri)*1000,0) as Tot_Power, ISNULL(sum(TotalHeat_Des_Watts),0) as Tot_Watts  
 from Tbl_PHT_SMCabinet_Module where CabinetID=@Cabinetid       
and VDC_Type=@Power      
end
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_ModuleInfo_Project]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_ModuleInfo_Project] --'7a0fc75b-329b-4cbd-b36b-2ce3443135bd',6,1,'Additional Power','399,425,426,431,432'
@ProjectID VARCHAR(200),         
@CabinetTypeID INT,         
@IsSMModule BIT,         
@ModuleGroup VARCHAR(100),         
@ModelIDs VARCHAR(1500) = ''        
AS         
    BEGIN        
    CREATE TABLE #Modules (Item VARCHAR(200))        
 INSERT INTO #Modules SELECT Item FROM dbo.SplitString(@ModuleGroup) 
        --select item from #Modules
    DECLARE @QRY VARCHAR(max)        
  IF(@IsSMModule = 0)        
  BEGIN        
  SET @QRY = 'SELECT DISTINCT A.ModelID, A.[Description], A.HeatDissipation,'        
  SET @QRY = @QRY + 'A.FanCapacity, A.Category, A.HoneywellModel, 0 AS ModelSelection, [IS_AC_Component],Module_Group,IS_MISC_COMP,CurrentRating FROM  (select ModelID, [Description],HeatDissipation,FanCapacity,Category,HoneywellModel,0 AS ModelSelection, [IS_AC_Component], Module_Group,IS_MISC_COMP,0 as CurrentRating,IsCustom from Tbl_PHT_ModuleDef union select '
    SET @QRY = @QRY +'ModelID, [Description],HeatDissipation,0 as FanCapacity,Category,HoneywellModel,0 AS ModelSelection, [IS_AC_Component], Module_Group,0 as IS_MISC_COMP,CurrentRating,IsCustom FROM  Tbl_PHT_PowerSupply_ModuleDef) A, '         
  SET @QRY = @QRY + ' Tbl_PHT_Cabinet_Module B, Tbl_PHT_Cabinet_Configuration C WHERE A.ModelID = B.ModelID '          
  SET @QRY = @QRY + ' AND B.CabinetID = C.CabinetID AND '        
  --SET @QRY = @QRY + ' C.CabinetTypeID = ' + CAST(@CabinetTypeID AS VARCHAR(255)) +' AND A.Module_Group IN (SELECT Item FROM #Modules ) AND A.IsCustom = 1 '        
  SET @QRY = @QRY + ' A.Module_Group IN (SELECT Item FROM #Modules ) AND A.IsCustom = 1 '   
  
  --SET @QRY = @QRY + ' UNION '
  -- SET @QRY = @QRY+'SELECT DISTINCT A.ModelID, A.[Description], A.HeatDissipation,'        
  --SET @QRY = @QRY + '0 as FanCapacity, A.Category, A.HoneywellModel, 0 AS ModelSelection, [IS_AC_Component],Module_Group,0 as IS_MISC_COMP,CurrentRating FROM  Tbl_PHT_PowerSupply_ModuleDef A, '         
  --SET @QRY = @QRY + ' Tbl_PHT_Cabinet_Module B, Tbl_PHT_Cabinet_Configuration C WHERE A.ModelID = B.ModelID '          
  --SET @QRY = @QRY + ' AND B.CabinetID = C.CabinetID AND '        
  --SET @QRY = @QRY + ' A.Module_Group IN (SELECT Item FROM #Modules ) AND A.IsCustom = 1 ' 
       
   IF(@ModelIDs != '')        
   BEGIN        
    SET @QRY = @QRY + ' UNION '        
    --SET @QRY = @QRY + ' SELECT ''' + @PROJECTID +''' AS ProjectID , ''00000000-0000-0000-0000-000000000000'' AS CabinetID, '      
    SET @QRY = @QRY + ' SELECT DISTINCT '          
    SET @QRY = @QRY + 'ModelID, [Description],HeatDissipation,FanCapacity,Category,HoneywellModel,0 AS ModelSelection, [IS_AC_Component], Module_Group,IS_MISC_COMP,CurrentRating '        
    SET @QRY = @QRY + 'FROM  (select ModelID, [Description],HeatDissipation,FanCapacity,Category,HoneywellModel,0 AS ModelSelection, [IS_AC_Component], Module_Group,IS_MISC_COMP,0 as CurrentRating,IsCustom from Tbl_PHT_ModuleDef union select '
    SET @QRY = @QRY +'ModelID, [Description],HeatDissipation,0 as FanCapacity,Category,HoneywellModel,0 AS ModelSelection, [IS_AC_Component], Module_Group,0 as IS_MISC_COMP,CurrentRating,IsCustom FROM  Tbl_PHT_PowerSupply_ModuleDef) A WHERE ModelID IN (' + @ModelIDs + ')'  
   
    -- SET @QRY = @QRY + ' UNION '       
    --SET @QRY = @QRY + ' SELECT DISTINCT '          
    --SET @QRY = @QRY + 'ModelID, [Description],HeatDissipation,0 as FanCapacity,Category,HoneywellModel,0 AS ModelSelection, [IS_AC_Component], Module_Group,0 as IS_MISC_COMP,CurrentRating '        
    --SET @QRY = @QRY + 'FROM  Tbl_PHT_PowerSupply_ModuleDef WHERE ModelID IN (' + @ModelIDs + ')'          
   END           
  END        
  ELSE        
  BEGIN        
  SET @QRY = 'SELECT DISTINCT A.ModelID, A.[Description], A.Category, A.HoneywellModel,'        
  SET @QRY = @QRY + 'A.nInputLoad, A.nOutputLoad, A.def_OutputLoad, nwdg, nL_5V, nV_drop, A.nChan, '    
  SET @QRY = @QRY + ' CASE WHEN cSignalType IS NULL OR cSignalType = '''' THEN ''Select'' ELSE cSignalType END AS CSignalType, '        
  SET @QRY = @QRY + 'CASE WHEN [IS_AC_Component] = 1 THEN ''AC'' WHEN [24v_IO] = 1 THEN ''24VDC'' WHEN [48v_IO] = 1 THEN ''48VDC'' WHEN [60v_IO] = 1 THEN'        
  SET @QRY = @QRY + ' ''60VDC'' WHEN [110v_IO] = 1 THEN ''110VDC'' WHEN [220v_IO] = 1 THEN ''220VDC'' END AS SupplyVoltage,'        
  SET @QRY = @QRY + 'CASE WHEN [IS_AC_Component] = 1 THEN 0 WHEN [24v_IO] = 1 THEN nl_24i WHEN [48v_IO] = 1 THEN nl_48i WHEN [60v_IO] = 1 THEN nl_60i'        
  SET @QRY = @QRY + ' WHEN [110v_IO] = 1 THEN nl_110i WHEN [220v_IO] = 1 THEN nl_220i END AS InternalPower, '          
  SET @QRY = @QRY + 'CASE WHEN [IS_AC_Component] = 1 THEN 0  WHEN [24v_IO] = 1 THEN nl_24e WHEN [48v_IO] = 1 THEN nl_48e WHEN [60v_IO] = 1 THEN nl_60e'        
  SET @QRY = @QRY + ' WHEN [110v_IO] = 1 THEN nl_110e WHEN [220v_IO] = 1 THEN nl_220e END AS ExternalPower , ISNULL(A.HeatDissipation,0.0) AS [Load], ISNULL(A.Fancapacity,0) as Fancapacity, '        
  SET @QRY = @QRY + ' 0 AS ModelSelection, OutputVoltage, [IS_AC_Component], Module_Group ,  ISNULL(Power_Dissipation_Barrier, 0.000) as Power_Dissipation_Barrier, ISNULL(Devices_OnBoard,0) as Devices_OnBoard,0 as CurrentRating  FROM  Tbl_PHT_ModuleDef A, '        
  SET @QRY = @QRY + ' Tbl_PHT_SMCabinet_Module B, Tbl_PHT_Cabinet_Configuration C WHERE A.ModelID = B.ModelID  AND A.Description = B.ModelDescription '          
  SET @QRY = @QRY + ' AND B.CabinetID = C.CabinetID AND '      
  SET @QRY = @QRY +'A.Module_Group IN (SELECT Item FROM #Modules ) AND A.IsCustom = 1 and PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'' '   
    
     SET @QRY = @QRY + ' UNION ' 
      SET @QRY = @QRY +'SELECT DISTINCT A.ModelID, A.[Description], A.Category, A.HoneywellModel,'        
  SET @QRY = @QRY + '0 as nInputLoad, 0 as nOutputLoad, 0 as def_OutputLoad,0 as nwdg,0 as nL_5V,0 as nV_drop,0 as nChan, '    
  SET @QRY = @QRY + ' '''' CSignalType, '        
  SET @QRY = @QRY + ' OutputVoltage AS SupplyVoltage,'        
  SET @QRY = @QRY + ' 0 AS InternalPower, '          
  SET @QRY = @QRY + ' 0 AS ExternalPower , ISNULL(A.HeatDissipation,0.0) AS [Load], 0 as Fancapacity, '        
  SET @QRY = @QRY + ' 0 AS ModelSelection, OutputVoltage, [IS_AC_Component], Module_Group ,  0 as Power_Dissipation_Barrier, 0 as Devices_OnBoard,CurrentRating  FROM  Tbl_PHT_PowerSupply_ModuleDef A, '        
  SET @QRY = @QRY + ' Tbl_PHT_SMCabinet_Module B, Tbl_PHT_Cabinet_Configuration C WHERE A.ModelID = B.ModelID  AND A.Description = B.ModelDescription '          
  SET @QRY = @QRY + ' AND B.CabinetID = C.CabinetID AND '      
  SET @QRY = @QRY +'A.Module_Group IN (SELECT Item FROM #Modules ) AND A.IsCustom = 1 and PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'' ' 
       
  IF(@ModelIDs != '')        
   BEGIN        
    SET @QRY = @QRY + ' UNION '        
    SET @QRY = @QRY + ' SELECT DISTINCT '       
    SET @QRY = @QRY + 'ModelID, [Description],Category,HoneywellModel, '        
    SET @QRY = @QRY + 'nInputLoad, nOutputLoad, def_OutputLoad, nwdg, nL_5V, nV_drop, 0 as nChan, '      
    SET @QRY = @QRY + ' CASE WHEN cSignalType IS NULL OR cSignalType = '''' THEN ''Select'' ELSE cSignalType END AS CSignalType, '          
    SET @QRY = @QRY + 'CASE WHEN [IS_AC_Component] = 1 THEN ''AC''  WHEN [24v_IO] = 1 THEN ''24VDC'' WHEN [48v_IO] = 1 THEN ''48VDC'' WHEN [60v_IO] = 1 THEN'        
    SET @QRY = @QRY + ' ''60VDC'' WHEN [110v_IO] = 1 THEN ''110VDC'' WHEN [220v_IO] = 1 THEN ''220VDC'' END AS SupplyVoltage,'        
    SET @QRY = @QRY + 'CASE WHEN [IS_AC_Component] = 1 THEN 0  WHEN [24v_IO] = 1 THEN nl_24i WHEN [48v_IO] = 1 THEN nl_48i WHEN [60v_IO] = 1 THEN nl_60i'        
    SET @QRY = @QRY + ' WHEN [110v_IO] = 1 THEN nl_110i WHEN [220v_IO] = 1 THEN nl_220i END AS InternalPower, '          
    SET @QRY = @QRY + 'CASE WHEN [IS_AC_Component] = 1 THEN 0  WHEN [24v_IO] = 1 THEN nl_24e WHEN [48v_IO] = 1 THEN nl_48e WHEN [60v_IO] = 1 THEN nl_60e'        
    SET @QRY = @QRY + ' WHEN [110v_IO] = 1 THEN nl_110e WHEN [220v_IO] = 1 THEN nl_220e END AS ExternalPower , ISNULL(HeatDissipation,0.0) AS [Load], ISNULL(Fancapacity,0) as Fancapacity, '        
    SET @QRY = @QRY + ' 0 AS ModelSelection, OutputVoltage, [IS_AC_Component], Module_Group, ISNULL(Power_Dissipation_Barrier, 0.000) as Power_Dissipation_Barrier, ISNULL(Devices_OnBoard,0) as Devices_OnBoard,0 as CurrentRating '        
    SET @QRY = @QRY + 'FROM  Tbl_PHT_ModuleDef WHERE ModelID IN (' + @ModelIDs + ')'      
    
    SET @QRY = @QRY + ' UNION '        
    --SET @QRY = @QRY + ' SELECT ''' + @PROJECTID +''' AS ProjectID , ''00000000-0000-0000-0000-000000000000'' AS CabinetID, '        
    SET @QRY = @QRY + ' SELECT DISTINCT '       
    SET @QRY = @QRY + 'ModelID, [Description],Category,HoneywellModel, '        
    SET @QRY = @QRY + '0 as nInputLoad,0 as nOutputLoad,0 as def_OutputLoad, 0 as nwdg,0 as nL_5V,0 as nV_drop, 0 as nChan, '      
    SET @QRY = @QRY + ' '''' AS CSignalType, '          
     SET @QRY = @QRY + ' OutputVoltage AS SupplyVoltage,'        
   SET @QRY = @QRY + ' 0 AS InternalPower, '          
     SET @QRY = @QRY + ' 0 AS ExternalPower , ISNULL(HeatDissipation,0.0) AS [Load], 0 AS Fancapacity, '        
    SET @QRY = @QRY + ' 0 AS ModelSelection, OutputVoltage, [IS_AC_Component], Module_Group, 0 AS Power_Dissipation_Barrier, 0 AS Devices_OnBoard,CurrentRating '        
    SET @QRY = @QRY + 'FROM  Tbl_PHT_PowerSupply_ModuleDef WHERE ModelID IN (' + @ModelIDs + ')'          
   END           
  END        
  PRINT @QRY        
  EXEC(@QRY)        
 END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_ModuelDefByID]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_ModuelDefByID]   --5   
    @ModelID INT
AS
BEGIN
    SELECT  *,0 as CurrentRating      
    FROM    [dbo].[Tbl_PHT_ModuleDef]    
    WHERE   ( [ModelID] = @ModelID )
    union
       SELECT  ModelID,Category,Manufacturer, HoneywellModel,'' as NonHWManufacturerPartNbr,Description,Weight,Heatdissipation,SupplyVoltage,
        'False' as PHCompChannelWise,0 as FanCapacity,0 as AO_Heatdissipation,0 as AI_Heatdissipation,0 as DI_Heatdissipation,0 as DO_Heatdissipation,0 as IOTA_Heatdissipation,
        0 as General_Field1,0 as General_Field2,0 as General_Field3,0 as General_Field4,0 as General_Field5,IS_AC_COMPONENT,Module_Group,code,0 as nChan,'' as cSignalType,
        0 as nWDG,0 as nInputLoad,'False' as [24V_IO],'False' as [48V_IO],'False' as [60V_IO],'False' as [110V_IO],'False' as [220V_IO],0 as nL_5V,0 as nL_24i,0 as nL_24e,0 as nL_48i,0 as nL_48e,0 as nL_60i,0 as nL_60e,0 as nL_110i,0 as nL_110e,
        0 as nL_220i,0 as nL_220e,0 as nV_drop,0 as nOutputLoad,0 as def_OutputLoad,IsCustom,OutputVoltage,0 as Power_Dissipation_Barrier,0 as Devices_OnBoard,'False' as Is_Misc_Comp,CurrentRating      
    FROM    [dbo].[Tbl_PHT_PowerSupply_ModuleDef]    
    WHERE   ( [ModelID] = @ModelID )      
    ORDER BY HONEYWELLMODEL ASC      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_ModuelDef]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--// Modified by mani --Added Is_SMModule param to fetch SMModule alone      
   -- exec SP_PHT_Fetch_ModuelDef @ModelID=0,@Module_Group='',@Is_SMModule=1  
create PROC [dbo].[SP_PHT_Fetch_ModuelDef]        --32,'',0
    @ModelID INT ,          
    @Module_Group VARCHAR(100),      
    @Is_SMModule bit      
AS           
    SET NOCOUNT ON           
              --declare @Module_group1 as nvarchar(max)=''
              --if(@Module_Group<>'')
              --set @Module_group1='and [Module_Group] = '''+@Module_Group+''' )'
    BEGIN          
    if(@Is_SMModule=0)      
    Begin      
        IF ( @ModelID = 0          
             AND ( @Module_Group IS NULL          
                   OR LEN(@Module_Group) = 0          
                 )          
           )           
            BEGIN          
            print 1
                SELECT  [ModelID] ,          
                        [Category] ,          
                        [Manufacturer] ,          
                        [HoneywellModel] ,          
                        [NonHWManufacturerPartNbr] ,          
                        [Description] ,          
                        [Weight] ,          
                        ISNULL([Heatdissipation], 0) AS Heatdissipation ,          
                        [SupplyVoltage] ,          
                        [PHCompChannelWise] ,          
                        [FanCapacity] ,          
                        ISNULL([AO_Heatdissipation], 0) AS AO_Heatdissipation ,          
                        ISNULL([AI_Heatdissipation], 0) AS AI_Heatdissipation ,          
                        ISNULL([DI_Heatdissipation], 0) AS DI_Heatdissipation ,          
                        ISNULL([DO_Heatdissipation], 0) AS DO_Heatdissipation ,          
                        ISNULL([IOTA_Heatdissipation], 0) AS IOTA_Heatdissipation ,          
                        [General_Field1] ,          
                        [General_Field2] ,          
                        [General_Field3] ,          
                        [General_Field4] ,          
                        [General_Field5] ,          
                        [IS_AC_COMPONENT] ,          
                        [Module_Group],Is_Misc_Comp,0 as CurrentRating          
                FROM    [dbo].[Tbl_PHT_ModuleDef]          
                WHERE   [Module_Group] <> 'Power Supply'  and Module_Group!='SM-Cabinet'  and Module_Group!='Additional Power' and Module_Group!='Power Supply SM' and Module_Group != 'Utility'  and Module_Group!= N'Server/Network'      
                ORDER BY HONEYWELLMODEL ASC          
            END          
        ELSE           
            IF ( @ModelID = 0 )           
                BEGIN    
                  
                  (  SELECT  [ModelID] ,          
                            [Category] ,          
                            [Manufacturer] ,          
                            [HoneywellModel] ,          
                            [NonHWManufacturerPartNbr] ,          
                            [Description] ,          
                            [Weight] ,          
                            ISNULL([Heatdissipation], 0) AS Heatdissipation ,          
                            [SupplyVoltage] ,          
                            [PHCompChannelWise] ,          
                            [FanCapacity] ,          
                            ISNULL([AO_Heatdissipation], 0) AS AO_Heatdissipation ,          
                            ISNULL([AI_Heatdissipation], 0) AS AI_Heatdissipation ,          
                            ISNULL([DI_Heatdissipation], 0) AS DI_Heatdissipation ,          
                            ISNULL([DO_Heatdissipation], 0) AS DO_Heatdissipation ,          
                            ISNULL([IOTA_Heatdissipation], 0) AS IOTA_Heatdissipation ,          
                            [General_Field1] ,          
                            [General_Field2] ,          
                            [General_Field3] ,          
                            [General_Field4] ,          
                            [General_Field5] ,          
                            [IS_AC_COMPONENT] ,          
                            [Module_Group],Is_Misc_Comp,0 as CurrentRating          
                  FROM    [dbo].[Tbl_PHT_ModuleDef]          
                    WHERE   [Module_Group] = @Module_Group )
                    union 
                      (  SELECT  [ModelID] ,          
                            [Category] ,          
                            [Manufacturer] ,          
                            [HoneywellModel] ,          
                            '' as [NonHWManufacturerPartNbr] ,          
                            [Description] ,          
                            [Weight] ,          
                            ISNULL([Heatdissipation], 0) AS Heatdissipation ,          
                            OutputVoltage as [SupplyVoltage] ,          
                            'False' as [PHCompChannelWise] ,          
                            0 as [FanCapacity] ,          
                            0 AS AO_Heatdissipation ,          
                            0 AS AI_Heatdissipation ,          
                            0 AS DI_Heatdissipation ,          
                            0 AS DO_Heatdissipation ,          
                            0 AS IOTA_Heatdissipation ,          
                            0 as [General_Field1] ,          
                            0 as [General_Field2] ,          
                            0 as [General_Field3] ,          
                            0 as [General_Field4] ,          
                            0 as [General_Field5] ,          
                            [IS_AC_COMPONENT] ,          
                            [Module_Group],'False' as Is_Misc_Comp,CurrentRating          
                  FROM    [dbo].[Tbl_PHT_PowerSupply_ModuleDef]          
                    WHERE   [Module_Group] = @Module_Group )       
                    ORDER BY HONEYWELLMODEL ASC          
                END          
            ELSE         
                BEGIN        
                    if(@Module_group<>'')
                    begin
                    (SELECT  [ModelID] ,          
                            [Category] ,          
                            [Manufacturer] ,          
                            [HoneywellModel] ,          
                            [NonHWManufacturerPartNbr] ,       
                            [Description] ,          
                            [Weight] ,          
                            ISNULL([Heatdissipation], 0) AS Heatdissipation ,          
                            [SupplyVoltage] ,          
                            [PHCompChannelWise] ,          
                   [FanCapacity] ,          
                            ISNULL([AO_Heatdissipation], 0) AS AO_Heatdissipation ,          
                            ISNULL([AI_Heatdissipation], 0) AS AI_Heatdissipation ,          
                            ISNULL([DI_Heatdissipation], 0) AS DI_Heatdissipation ,          
                            ISNULL([DO_Heatdissipation], 0) AS DO_Heatdissipation ,          
                            ISNULL([IOTA_Heatdissipation], 0) AS IOTA_Heatdissipation ,          
                            [General_Field1] ,          
                            [General_Field2] ,          
                            [General_Field3] ,          
                            [General_Field4] ,          
                            [General_Field5] ,          
                            [IS_AC_COMPONENT] ,          
                            [Module_Group],Is_Misc_Comp,0 as CurrentRating         
                    FROM   [dbo].[Tbl_PHT_ModuleDef]          
                    WHERE   ( [ModelID] = @ModelID and Module_Group=@Module_Group )  ) 
                       union 
                      (  SELECT  [ModelID] ,          
                            [Category] ,          
                            [Manufacturer] ,          
                            [HoneywellModel] ,          
                            '' as [NonHWManufacturerPartNbr] ,          
                            [Description] ,          
                            [Weight] ,          
                            ISNULL([Heatdissipation], 0) AS Heatdissipation ,          
                            [SupplyVoltage] ,          
                            'False' as [PHCompChannelWise] ,          
                            0 as [FanCapacity] ,          
                            0 AS AO_Heatdissipation ,          
                            0 AS AI_Heatdissipation ,          
                            0 AS DI_Heatdissipation ,          
                            0 AS DO_Heatdissipation ,          
                            0 AS IOTA_Heatdissipation ,          
                            0 as [General_Field1] ,          
                            0 as [General_Field2] ,          
                            0 as [General_Field3] ,          
                            0 as [General_Field4] ,          
                            0 as [General_Field5] ,          
                            [IS_AC_COMPONENT] ,          
                            [Module_Group],'False' as Is_Misc_Comp,CurrentRating          
                  FROM    [dbo].[Tbl_PHT_PowerSupply_ModuleDef]   
                  WHERE   ( [ModelID] = @ModelID and Module_Group=@Module_Group))     
                    ORDER BY HONEYWELLMODEL ASC          
                END 
                else
                begin
                 (SELECT  [ModelID] ,          
                            [Category] ,          
                            [Manufacturer] ,          
                            [HoneywellModel] ,          
                            [NonHWManufacturerPartNbr] ,       
                            [Description] ,          
                            [Weight] ,          
                            ISNULL([Heatdissipation], 0) AS Heatdissipation ,          
                            [SupplyVoltage] ,          
                            [PHCompChannelWise] ,          
                   [FanCapacity] ,          
                            ISNULL([AO_Heatdissipation], 0) AS AO_Heatdissipation ,          
                            ISNULL([AI_Heatdissipation], 0) AS AI_Heatdissipation ,          
                            ISNULL([DI_Heatdissipation], 0) AS DI_Heatdissipation ,          
                            ISNULL([DO_Heatdissipation], 0) AS DO_Heatdissipation ,          
                            ISNULL([IOTA_Heatdissipation], 0) AS IOTA_Heatdissipation ,          
                            [General_Field1] ,          
                            [General_Field2] ,          
                            [General_Field3] ,          
                            [General_Field4] ,          
                            [General_Field5] ,          
                            [IS_AC_COMPONENT] ,          
                            [Module_Group],Is_Misc_Comp,0 as CurrentRating         
                    FROM   [dbo].[Tbl_PHT_ModuleDef]          
                    WHERE   ( [ModelID] = @ModelID )  ) 
                       union 
                      (  SELECT  [ModelID] ,          
                            [Category] ,          
                            [Manufacturer] ,          
                            [HoneywellModel] ,          
                            '' as [NonHWManufacturerPartNbr] ,          
                            [Description] ,          
                            [Weight] ,          
                            ISNULL([Heatdissipation], 0) AS Heatdissipation ,          
                            [SupplyVoltage] ,          
                            'False' as [PHCompChannelWise] ,          
                            0 as [FanCapacity] ,          
                            0 AS AO_Heatdissipation ,          
                            0 AS AI_Heatdissipation ,          
                            0 AS DI_Heatdissipation ,          
                            0 AS DO_Heatdissipation ,          
                            0 AS IOTA_Heatdissipation ,          
                            0 as [General_Field1] ,          
                            0 as [General_Field2] ,          
                            0 as [General_Field3] ,          
                            0 as [General_Field4] ,          
                            0 as [General_Field5] ,          
                            [IS_AC_COMPONENT] ,          
                            [Module_Group],'False' as Is_Misc_Comp,CurrentRating          
                  FROM    [dbo].[Tbl_PHT_PowerSupply_ModuleDef]   
                  WHERE   ( [ModelID] = @ModelID  ) )     
                    ORDER BY HONEYWELLMODEL ASC           
                 end   
                  end    
        END      
        Else-- Fetch SM Module      
        Begin    
                 
          if @Module_Group = ''  
              
        select ModelID,Category,Manufacturer,HoneywellModel,NonHWManufacturerPartNbr,Description,Weight,Heatdissipation,SupplyVoltage,
        PHCompChannelWise,FanCapacity,AO_Heatdissipation,AI_Heatdissipation,DI_Heatdissipation,DO_Heatdissipation,IOTA_Heatdissipation,
        General_Field1,General_Field2,General_Field3,General_Field4,General_Field5,IS_AC_COMPONENT,Module_Group,code,nChan,cSignalType,
        nWDG,nInputLoad,[24V_IO],[48V_IO],[60V_IO],[110V_IO],[220V_IO],nL_5V,nL_24i,nL_24e,nL_48i,nL_48e,nL_60i,nL_60e,nL_110i,nL_110e,
        nL_220i,nL_220e,nV_drop,nOutputLoad,def_OutputLoad,IsCustom,OutputVoltage,Power_Dissipation_Barrier,Devices_OnBoard,Is_Misc_Comp,0 as CurrentRating 
        from Tbl_PHT_ModuleDef where Module_Group='SM-Cabinet' or  Module_Group='Power Supply SM' or Module_Group= 'Additional Power'   
        or (Module_Group= 'Utility'and honeywellmodel not in ('FanBox 240VAC - MU-511','FanBox 120VAC - MU-611') ) or Module_Group= N'Server/Network'   
          union 
          select ModelID,Category,Manufacturer,HoneywellModel,'' as NonHWManufacturerPartNbr,Description,Weight,Heatdissipation,SupplyVoltage,
        'False' as PHCompChannelWise,0 as FanCapacity,0 as AO_Heatdissipation,0 as AI_Heatdissipation,0 as DI_Heatdissipation,0 as DO_Heatdissipation,0 as IOTA_Heatdissipation,
        0 as General_Field1,0 as General_Field2,0 as General_Field3,0 as General_Field4,0 as General_Field5,IS_AC_COMPONENT,Module_Group,code,0 as nChan,'' as cSignalType,
        0 as nWDG,0 as nInputLoad,'False' as [24V_IO],'False' as [48V_IO],'False' as [60V_IO],'False' as [110V_IO],'False' as [220V_IO],0 as nL_5V,0 as nL_24i,0 as nL_24e,0 as nL_48i,0 as nL_48e,0 as nL_60i,0 as nL_60e,0 as nL_110i,0 as nL_110e,
        0 as nL_220i,0 as nL_220e,0 as nV_drop,0 as nOutputLoad,0 as def_OutputLoad,IsCustom,OutputVoltage,0 as Power_Dissipation_Barrier,0 as Devices_OnBoard,'False' as Is_Misc_Comp,CurrentRating  from Tbl_PHT_PowerSupply_ModuleDef where Module_Group='SM-Cabinet' or  Module_Group='Power Supply SM' or Module_Group= 'Additional Power'   
        or (Module_Group= 'Utility'and honeywellmodel not in ('FanBox 240VAC - MU-511','FanBox 120VAC - MU-611') ) or Module_Group= N'Server/Network'   
          ORDER BY HONEYWELLMODEL ASC          
  else    
        select ModelID,Category,Manufacturer,HoneywellModel,NonHWManufacturerPartNbr,Description,Weight,Heatdissipation,SupplyVoltage,
        PHCompChannelWise,FanCapacity,AO_Heatdissipation,AI_Heatdissipation,DI_Heatdissipation,DO_Heatdissipation,IOTA_Heatdissipation,
        General_Field1,General_Field2,General_Field3,General_Field4,General_Field5,IS_AC_COMPONENT,Module_Group,code,nChan,cSignalType,
        nWDG,nInputLoad,[24V_IO],[48V_IO],[60V_IO],[110V_IO],[220V_IO],nL_5V,nL_24i,nL_24e,nL_48i,nL_48e,nL_60i,nL_60e,nL_110i,nL_110e,
        nL_220i,nL_220e,nV_drop,nOutputLoad,def_OutputLoad,IsCustom,OutputVoltage,Power_Dissipation_Barrier,Devices_OnBoard,Is_Misc_Comp,0 as CurrentRating from Tbl_PHT_ModuleDef where Module_Group=@Module_Group    
         and honeywellmodel not in ('FanBox 240VAC - MU-511','FanBox 120VAC - MU-611')  
         union
            select ModelID,Category,Manufacturer, HoneywellModel,'' as NonHWManufacturerPartNbr,Description,Weight,Heatdissipation,SupplyVoltage,
        'False' as PHCompChannelWise,0 as FanCapacity,0 as AO_Heatdissipation,0 as AI_Heatdissipation,0 as DI_Heatdissipation,0 as DO_Heatdissipation,0 as IOTA_Heatdissipation,
        0 as General_Field1,0 as General_Field2,0 as General_Field3,0 as General_Field4,0 as General_Field5,IS_AC_COMPONENT,Module_Group,code,0 as nChan,'' as cSignalType,
        0 as nWDG,0 as nInputLoad,'False' as [24V_IO],'False' as [48V_IO],'False' as [60V_IO],'False' as [110V_IO],'False' as [220V_IO],0 as nL_5V,0 as nL_24i,0 as nL_24e,0 as nL_48i,0 as nL_48e,0 as nL_60i,0 as nL_60e,0 as nL_110i,0 as nL_110e,
        0 as nL_220i,0 as nL_220e,0 as nV_drop,0 as nOutputLoad,0 as def_OutputLoad,IsCustom,OutputVoltage,0 as Power_Dissipation_Barrier,0 as Devices_OnBoard,'False' as Is_Misc_Comp,CurrentRating  from Tbl_PHT_PowerSupply_ModuleDef where Module_Group=@Module_Group    
         and honeywellmodel not in ('FanBox 240VAC - MU-511','FanBox 120VAC - MU-611')  
         ORDER BY HONEYWELLMODEL ASC          
        End      
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_ModelInfo]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_ModelInfo] 
	-- Add the parameters for the stored procedure here
    @ModelNumber NVARCHAR(255)
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;
        SELECT  [ModelID] ,
                [Category] ,
                [Manufacturer] ,
                [HoneywellModel] ,
                [NonHWManufacturerPartNbr] ,
                [Description] ,
                [Weight] ,
                [Heatdissipation] ,
                [SupplyVoltage] ,
                [PHCompChannelWise] ,
                [FanCapacity] ,
                [AO_Heatdissipation] ,
                [AI_Heatdissipation] ,
                [DI_Heatdissipation] ,
                [DO_Heatdissipation] ,
                [IOTA_Heatdissipation] ,
                [General_Field1] ,
                [General_Field2] ,
                [General_Field3] ,
                [General_Field4] ,
                [General_Field5] ,
                [IS_AC_COMPONENT] ,
                [Module_Group]
        FROM    [PowerHeatCalc].[dbo].[Tbl_PHT_ModuleDef]
        WHERE   [HoneywellModel] = @ModelNumber
        
        union
       
         SELECT  [ModelID] ,
                [Category] ,
                [Manufacturer] ,
                [HoneywellModel] ,
                '' as [NonHWManufacturerPartNbr] ,
                [Description] ,
                [Weight] ,
                [Heatdissipation] ,
                [SupplyVoltage] ,
                'False' as [PHCompChannelWise] ,
                0 as [FanCapacity] ,
                0 as [AO_Heatdissipation] ,
                0 as [AI_Heatdissipation] ,
                0 as [DI_Heatdissipation] ,
                0 as [DO_Heatdissipation] ,
                0 as [IOTA_Heatdissipation] ,
                0 as [General_Field1] ,
                0 as [General_Field2] ,
                0 as [General_Field3] ,
                0 as [General_Field4] ,
                0 as [General_Field5] ,
                [IS_AC_COMPONENT] ,
                [Module_Group]
        FROM    [PowerHeatCalc].[dbo].[Tbl_PHT_PowerSupply_ModuleDef]
        WHERE   [HoneywellModel] = @ModelNumber
        ORDER BY HONEYWELLMODEL ASC
    -- Insert statements for procedure here
	
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Formula]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_Formula]
AS 
    BEGIN
        SELECT  FunctionID ,
                Alais ,
                FormulaName ,
                Formula
        FROM    Tbl_PHT_Formula_Table
        ORDER BY functionID ASC
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_DefaultPSUFORSM]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                
-- Author:  <Shyamala>                
-- Create date: <04-Nov-2015                
-- Description: <This SP will be used to get default PSU modules for SM cabinet>                
-- ============================================= 
    
CREATE PROC [dbo].[SP_PHT_Fetch_DefaultPSUFORSM]        
   
AS         
    SET NOCOUNT ON         
            
    BEGIN        
      
           --SELECT Modelid,HoneywellModel FROM Tbl_PHT_ModuleDef WHERE module_group='Power Supply SM' and category='FLT'
           SELECT Modelid,HoneywellModel FROM Tbl_PHT_PowerSupply_ModuleDef WHERE module_group='Power Supply SM' and category='FLT'
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Delete_Modules]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Delete_Modules] --1,359,'Utility Supply'
	-- Add the parameters for the stored procedure here
	@IsSMModule BIT,
    @ModelIDs VARCHAR(1500),
    @Module_Group VARCHAR(100)
 
AS 
    BEGIN  
  
  
		CREATE TABLE #Modules (Item VARCHAR(200))		
 
 INSERT INTO #Modules SELECT Item FROM dbo.SplitString(@Module_Group)
 set @Module_Group='and Module_Group in(SELECT Item FROM #Modules)'
 
        DECLARE @QRY VARCHAR(max)
        DECLARE @PowerDrawTypeID nvarchar(max)
        if(@Module_Group='Power Supply' or @Module_Group='Power Supply SM')
        set @PowerDrawTypeID=' and PowerDrawTypeID=''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'''
        IF(@IsSMModule = 1)
        BEGIN
		
			SET @QRY = 'DELETE FROM Tbl_PHT_SMCabinet_Module WHERE '    
	       
			SET @QRY = @QRY + ' ModelID IN (' + @ModelIDs  + ')' + @PowerDrawTypeID  + ''
			EXEC(@QRY)
        
			--DELETE FROM Tbl_PHT_SMCabinet_Module WHERE ModelID IN (@ModelIDs)
        END
        ELSE
        BEGIN
			SET @QRY = 'DELETE FROM Tbl_PHT_Cabinet_Module WHERE '   
	      
			SET @QRY = @QRY + ' ModelID IN (' + @ModelIDs + ')' + @PowerDrawTypeID  + ''        
	     
			EXEC(@QRY)
			--DELETE FROM Tbl_PHT_Cabinet_Module WHERE ModelID IN (@ModelIDs)
        END
        
        SET @QRY = 'DELETE FROM Tbl_PHT_ModuleDef WHERE '   
	      
		SET @QRY = @QRY + ' ModelID IN (' + @ModelIDs + ')' + @Module_Group  + ''      
		EXEC(@QRY)
		SET @QRY = 'DELETE FROM Tbl_PHT_PowerSupply_ModuleDef WHERE '   
	      
		SET @QRY = @QRY + ' ModelID IN (' + @ModelIDs + ') ' + @Module_Group  + ''  
		EXEC(@QRY)
		
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_GroupTypes]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_PHT_Fetch_GroupTypes]
as
Begin
select GroupType_ID, GroupType_Name   from Tbl_PHT_Group_Type 
End
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Cabinet_Type]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_Cabinet_Type] @CabinetTypeID INT
AS 
    SET NOCOUNT ON 
    
    BEGIN
        IF ( @CabinetTypeID = -1 ) 
            BEGIN
                SELECT  [CabinetTypeID] ,
                        [CabinetTypeName]
                FROM    [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Type]
                ORDER BY [CabinetTypeName] ASC
            END
        ELSE 
            IF ( @CabinetTypeID = 0 ) 
                BEGIN
                    SELECT  [CabinetTypeID] ,
                            [CabinetTypeName]
                    FROM    [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Type] where [CabinetTypeName] <> 'Utility Supply'
                    ORDER BY [CabinetTypeName] ASC
                END
            ELSE 
                BEGIN
                    SELECT  [CabinetTypeID] ,
                            [CabinetTypeName]
                    FROM    [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Type]
                    WHERE   ( [CabinetTypeID] = @CabinetTypeID )
                    ORDER BY [CabinetTypeName] ASC
                END
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Cabinet_Temp]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_Cabinet_Temp]  
    @CabinetID UNIQUEIDENTIFIER  
AS   
    BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
        SET NOCOUNT ON ;  
  
        SELECT  CabTempID,CabinetID,FanQuantity,Tambient,dT,CabTemp,Fan_AirFlow  
        FROM    Tbl_PHT_Cabinet_Temp  
        WHERE   CabinetID = @CabinetID  
        ORDER BY FanQuantity DESC  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Cabinet_Search]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_Cabinet_Search] --'ut','Utility Supply','MODELNUMBER',0 --'ut','dcs system,network,server','MODELNUMBER',0
 -- Add the parameters for the stored procedure here        
    @SearchKey VARCHAR(255) ,        
    @modelGroup VARCHAR(255) ,        
    @SearchType VARCHAR(50),      
    @IsSMModule bit      
AS         
    BEGIN        
    CREATE TABLE #Modules (Item VARCHAR(200))    
 INSERT INTO #Modules SELECT Item FROM dbo.SplitString(@modelGroup)     
     
 CREATE TABLE #Category (Item VARCHAR(200))    
 INSERT INTO #Category SELECT Item FROM dbo.SplitString(@SearchKey)     
 -- SET NOCOUNT ON added to prevent extra result sets from        
 -- interfering with SELECT statements.     
  DECLARE @QRY_GROUP AS VARCHAR(max)=''  
  if(@modelGroup<>'Utility Supply')   
  begin   
  SET @QRY_GROUP ='and  Module_Group <> ''Utility Supply'''
  end
 IF (@IsSMModule = 0)      
 Begin      
        IF ( LEN(@SearchKey) > 0 )         
            BEGIN        
                IF ( @SearchType = 'CATEGORY' )         
                    BEGIN        
                        IF ( @SearchKey = 'All' )         
                            BEGIN        
                              
                                SELECT DISTINCT        
                                        ModelId ,        
                                        HoneywellModel ,        
                                        Description ,        
                                        Module_Group ,        
                                        '' AS qty,        
                                        IS_AC_COMPONENT AS IsAc,    
                                        Category,    
                                        IsCustom,Is_Misc_Comp,Devices_OnBoard  as Noofdevice
                                FROM    Tbl_PHT_ModuleDef        
                                WHERE   Module_Group <> 'Power Supply'  and Module_Group <> 'SM-Cabinet'  and Module_Group <> 'Additional Power'   
                                 and Module_Group <> 'Power Supply SM' and Module_Group <> N'Server/Network'  and  Module_Group <> 'Utility' 
    
                                ORDER BY HoneywellModel ASC        
                            END        
                        ELSE      
                            BEGIN       
                                 
                                SELECT DISTINCT        
                                        ModelId ,        
                                        HoneywellModel ,        
                                        Description ,        
                                        Module_Group ,        
                                        '' AS qty,        
                                        IS_AC_COMPONENT AS IsAc,    
                                        Category,    
                                        IsCustom,Is_Misc_Comp,Devices_OnBoard   as Noofdevice 
                                FROM    Tbl_PHT_ModuleDef        
                                WHERE   CATEGORY  IN (SELECT Item FROM #Category)      
                                        AND Module_Group <> 'Power Supply'  and Module_Group <> 'SM-Cabinet'    
                                        and Module_Group <> 'Additional Power' and Module_Group <> N'Server/Network'    
                                        and Module_Group <> 'Power Supply SM'  and  Module_Group <> 'Utility'  
                                ORDER BY HoneywellModel ASC        
                            END        
                    END         
                ELSE         
                    BEGIN       
                          
                        DECLARE @QRY AS VARCHAR(max)        
                        SET @QRY = 'SELECT DISTINCT ModelId,HoneywellModel,Description,Module_Group,'''' as qty,IS_AC_COMPONENT AS IsAc,   
                        Category, IsCustom,Is_Misc_Comp,Devices_OnBoard as Noofdevice FROM Tbl_PHT_ModuleDef WHERE HoneywellModel LIKE ''%'        
                            + @SearchKey        
                            + '%'' AND Module_Group<>''Power Supply'' and Module_Group <> ''SM-Cabinet'' and Module_Group <> N''Server/Network''   
                              and Module_Group <> ''Additional Power''  and Module_Group <> ''Power Supply SM''    
                              and  Module_Group <> ''Utility'''+@QRY_GROUP+'   ORDER BY HoneywellModel ASC'        
                               --Commentd by Ram Prasath for unwanted module in ups power draw tab
                             --and  Module_Group <> ''Utility'' ORDER BY HoneywellModel ASC'        
                             
                        PRINT @QRY         
                        EXEC(@QRY) ;         
                    END        
            END        
        ELSE         
            BEGIN        
                IF ( LEN(@modelGroup) > 0 )         
                    BEGIN        
                          
                        SELECT DISTINCT        
                                Category        
                        FROM    Tbl_PHT_ModuleDef        
                        --WHERE   Module_Group = @modelGroup        
                        WHERE   Module_Group IN (SELECT Item FROM #Modules)   
                        union
                        SELECT DISTINCT        
                                Category        
                        FROM    Tbl_PHT_PowerSupply_ModuleDef       
                        WHERE   Module_Group IN (SELECT Item FROM #Modules)      
                        ORDER BY Category ASC        
                    END        
                ELSE         
                    BEGIN    
                         
                        SELECT DISTINCT        
                                Category        
                        FROM    Tbl_PHT_ModuleDef        
                        --WHERE   Module_Group <> 'Power Supply' and Module_Group <> 'SM-Cabinet' and Module_Group <> N'Server/Network' and Module_Group <> 'Additional Power'  and Module_Group <> 'Power Supply SM'  and  Module_Group <> 'Utility'       
                        WHERE   Module_Group <> 'SM-Cabinet' and Module_Group <> N'Server/Network' and Module_Group <> 'Additional Power'    
                         and  Module_Group <> 'Utility'   
                        union
                         SELECT DISTINCT        
                                Category        
                        FROM    Tbl_PHT_PowerSupply_ModuleDef        
						WHERE   Module_Group <> 'SM-Cabinet' and Module_Group <> N'Server/Network' and Module_Group <> 'Additional Power'    
                         and  Module_Group <> 'Utility'         
                        ORDER BY Category ASC        
                    END        
            END        
                  
       END --end IsSMModule If      
  Else      
        
  Begin      
  IF ( LEN(@SearchKey) > 0 )         
            BEGIN       
           
                IF ( @SearchType = 'CATEGORY' )         
                    BEGIN        
                        IF ( @SearchKey = 'All' )         
                            BEGIN        
                                   
                                SELECT DISTINCT        
                                        ModelId ,        
                                        HoneywellModel ,        
                                        Description ,        
                                        Module_Group ,        
                                        '' AS qty ,      
                                          IS_AC_COMPONENT AS IsAc ,    
                                        CASE WHEN Module_Group in ('Utility','Server/Network')   
                                        THEN ISNULL(Heatdissipation,0) ELSE ISNULL(def_OutputLoad,0) END AS [Load],    
                                        Category,  IsCustom,Is_Misc_Comp,Devices_OnBoard as Noofdevice    
                                FROM    Tbl_PHT_ModuleDef        
                                WHERE   Module_Group =@modelGroup   
                                and honeywellmodel not in ('FanBox 240VAC - MU-511','FanBox 120VAC - MU-611') 
                                union 
                                    SELECT DISTINCT        
                                        ModelId ,        
                                        HoneywellModel ,        
                                        Description ,        
                                        Module_Group ,        
                                        '' AS qty ,      
                                          IS_AC_COMPONENT AS IsAc ,    
                                        CASE WHEN Module_Group in ('Utility','Server/Network')   
                                        THEN ISNULL(Heatdissipation,0) ELSE 0 END AS [Load],    
                                        Category,  IsCustom,0 as Is_Misc_Comp ,0 as Noofdevice  
                                FROM    Tbl_PHT_PowerSupply_ModuleDef        
                                WHERE   Module_Group =@modelGroup   
                                and honeywellmodel not in ('FanBox 240VAC - MU-511','FanBox 120VAC - MU-611')   
                                ORDER BY HoneywellModel ASC        
                            END        
                        ELSE         
                            BEGIN      
                               
                                SELECT DISTINCT        
                                        ModelId ,        
                                        HoneywellModel ,        
                                        Description ,        
                                        Module_Group ,        
                                        '' AS qty,      
                                          IS_AC_COMPONENT AS IsAc,    
                                        CASE WHEN Module_Group in ('Utility','Server/Network') THEN ISNULL(Heatdissipation,0)   
                                        ELSE ISNULL(def_OutputLoad,0) END AS [Load],    
                                        Category,             
                                        IsCustom,Is_Misc_Comp,Devices_OnBoard  as Noofdevice  
                                FROM    Tbl_PHT_ModuleDef        
               WHERE   CATEGORY = @SearchKey        
                                        AND Module_Group=@modelGroup   
                                         and honeywellmodel not in ('FanBox 240VAC - MU-511','FanBox 120VAC - MU-611')   
                                         union  
                                         SELECT DISTINCT        
                                        ModelId ,        
                                        HoneywellModel ,        
                                        Description ,        
                                        Module_Group ,        
                                        '' AS qty,      
                                          IS_AC_COMPONENT AS IsAc,    
                                        CASE WHEN Module_Group in ('Utility','Server/Network') THEN ISNULL(Heatdissipation,0)   
                                        ELSE 0 END AS [Load],    
                                        Category,             
                                        IsCustom,0 as Is_Misc_Comp,0 as Noofdevice 
                                FROM    Tbl_PHT_PowerSupply_ModuleDef        
               WHERE   CATEGORY = @SearchKey        
                                        AND Module_Group=@modelGroup   
                                         and honeywellmodel not in ('FanBox 240VAC - MU-511','FanBox 120VAC - MU-611') 
                                ORDER BY HoneywellModel ASC        
                            END        
                    END         
                ELSE         
                    BEGIN      
                    
                        DECLARE @QRY1 AS VARCHAR(max)        
                        SET @QRY1 = 'SELECT DISTINCT ModelId,HoneywellModel,Description,Module_Group,'''' as qty,  
                        IS_AC_COMPONENT AS IsAc, CASE WHEN Module_Group in (''Utility'',''Server/Network'')   
                        THEN ISNULL(Heatdissipation,0) ELSE ISNULL(def_OutputLoad,0) END AS [Load], Category,   
                        IsCustom,Is_Misc_Comp,Devices_OnBoard as Noofdevice FROM Tbl_PHT_ModuleDef WHERE HoneywellModel LIKE ''%'        
                            + @SearchKey        
                            + '%'' AND Module_Group= ''' + @modelGroup +''' 
                            
                           union SELECT DISTINCT ModelId,HoneywellModel,Description,Module_Group,'''' as qty,  
                        IS_AC_COMPONENT AS IsAc, CASE WHEN Module_Group in (''Utility'',''Server/Network'')   
                        THEN ISNULL(Heatdissipation,0) ELSE 0 END AS [Load], Category,   
                        IsCustom,0 as Is_Misc_Comp,0 as Noofdevice FROM Tbl_PHT_PowerSupply_ModuleDef WHERE HoneywellModel LIKE ''%'        
                            + @SearchKey        
                            + '%'' AND Module_Group= ''' + @modelGroup +'''
                               ORDER BY HoneywellModel ASC'
                                
                        EXEC(@QRY1) ;         
                    END      
            END        
        ELSE         
            BEGIN     
                  
                IF ( LEN(@modelGroup) > 0 )         
                    BEGIN    
                      
                        SELECT DISTINCT        
                                Category        
                        FROM    Tbl_PHT_ModuleDef        
                        --WHERE   Module_Group = @modelGroup        
                        WHERE   Module_Group IN (SELECT Item FROM #Modules) 
                        union
                            SELECT DISTINCT        
                                Category        
                        FROM    Tbl_PHT_PowerSupply_ModuleDef             
                        WHERE   Module_Group IN (SELECT Item FROM #Modules)     
                        ORDER BY Category ASC        
                    END       
                ELSE         
                    BEGIN   
                      
                        SELECT DISTINCT        
                                Category        
                        FROM    Tbl_PHT_ModuleDef        
                        --WHERE   Module_Group =@modelGroup        
                         WHERE   Module_Group IN (SELECT Item FROM #Modules)
                         union
                                SELECT DISTINCT        
                                Category        
                        FROM    Tbl_PHT_PowerSupply_ModuleDef           
                         WHERE   Module_Group IN (SELECT Item FROM #Modules)  
                        ORDER BY Category ASC        
                    END        
            END        
                  
        
  End           
        
   END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_DeleteProjectDetails]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_PHT_DeleteProjectDetails]
    @ProjectID UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

        DELETE  FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Project]
        WHERE   [ProjectID] = @ProjectID 
      
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPHProjectName]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GETPHProjectName]
AS 
    BEGIN
        SET NOCOUNT ON 
  
       select ProjectID,ProjectName from Tbl_PHT_Project

    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_AdvSetting_Update_SMCabinet_Temp]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_PHT_AdvSetting_Update_SMCabinet_Temp]
@SMCabinetTemp Type_PHT_AdvSetting_Update_CabinetTemperature Readonly      
as 	
	
	
--Declare @SMCabinetTemp Type_PHT_AdvSetting_Update_CabinetTemperature 
--Insert into @SMCabinetTemp (CabTempID, CabTemp)
--Values 
--('CA5BFBFB-708D-4485-97BF-AF31FBC917FC', '26'),
--('B44C442A-523F-41A4-9027-BD46E1A27F38', '27'),
--('A1BA7628-4731-4609-8A40-DCEB29CE3F22', '26'),
--('35E037AE-9854-4825-86CB-E1743613D33A', '35')


--CabTempID, CabTemp
Declare @CabinetID varchar(40), @FanQuantity varchar(40),@Tambient  varchar(40),@dT  varchar(40),@CabTemp  varchar(40)
Declare @UpdateQuery varchar(max) 

Declare Cursor_SMCabinetTemp cursor FAST_FORWARD FOR SELECT * FROM @SMCabinetTemp
Declare @RowCnt int



Open Cursor_SMCabinetTemp      
FETCH NEXT FROM Cursor_SMCabinetTemp INTO @CabinetID, @FanQuantity,@Tambient,@dT,@CabTemp

WHILE @@FETCH_STATUS = 0      
BEGIN

select @RowCnt = count(*) from Tbl_PHT_Cabinet_Temp where CabinetID = cast(@CabinetID as uniqueidentifier)
IF(@RowCnt >0)
BEGIN

Update Tbl_PHT_Cabinet_Temp set  Tambient=@Tambient,dT=@dT, CabTemp = @CabTemp 
where CabinetID = cast(@CabinetID as uniqueidentifier) and FanQuantity=@FanQuantity ;
 
 --print @CabinetID + 'sdf' + @FanQuantity+'sdf'+@Tambient+'sdf'+@dT+'sdf'+@CabTemp
 
 
END

FETCH NEXT FROM Cursor_SMCabinetTemp INTO @CabinetID, @FanQuantity,@Tambient,@dT,@CabTemp

      
END      
CLOSE Cursor_SMCabinetTemp      
DEALLOCATE Cursor_SMCabinetTemp
GO
/****** Object:  Table [dbo].[Tbl_PHT_Cabinet_Configuration]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Cabinet_Configuration](
	[CabinetID] [uniqueidentifier] NOT NULL,
	[ProjectID] [uniqueidentifier] NOT NULL,
	[CabinetName] [nvarchar](256) NULL,
	[CabinetDesc] [nvarchar](256) NULL,
	[CabinetTypeID] [int] NOT NULL,
	[Area] [nvarchar](256) NULL,
	[Location] [nvarchar](256) NULL,
	[GeneralNotes] [nvarchar](500) NULL,
	[PSFront] [int] NULL,
	[PSRear] [int] NULL,
	[PSUPSFeeder] [int] NULL,
	[CabinetHeight] [int] NULL,
	[CabinetWidth] [int] NULL,
	[CabinetDepth] [int] NULL,
	[FanQuantity] [int] NULL,
	[IsActive] [bit] NULL,
	[HostName] [nvarchar](255) NULL,
	[EditStartTime] [datetime] NULL,
	[FanModel] [nvarchar](50) NULL,
	[FanAirFlow] [int] NULL,
	[HeatLoad] [decimal](16, 2) NULL,
	[HeatLoadInBTU] [decimal](16, 2) NULL,
	[HeatLoadInKcalHr] [decimal](16, 2) NULL,
	[EnclosureSurfaceInWatts] [decimal](16, 2) NULL,
	[EnclosureSurfaceInBtu] [decimal](16, 2) NULL,
	[EnclosureSurfaceInKcal] [decimal](16, 2) NULL,
	[FrontEfficiency] [decimal](18, 2) NULL,
	[RearEfficiency] [decimal](18, 2) NULL,
	[Is_IDCCheck] [bit] NULL,
	[IDCError] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tbl_PH_Cabinet_Configuration] PRIMARY KEY CLUSTERED 
(
	[CabinetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_CabinetConfig_CabinetID] UNIQUE NONCLUSTERED 
(
	[CabinetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_Miscelleneous_Module]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Update_Miscelleneous_Module]  
    @CabinetModuleID UNIQUEIDENTIFIER ,  
    @CabinetID UNIQUEIDENTIFIER , 
    @ModelID INT ,  
    @ModelDescription NVARCHAR(256) ,  
    @Quantity INT ,  
    @IsUIO BIT ,  
    @AI_UIO_ChannelCount INT ,  
    @AO_UIO_ChannelCount INT ,  
    @DI_UIO_ChannelCount INT ,  
    @DO_UIO_ChannelCount INT ,  
    @IOTA_UIO_ChannelCount INT ,  
    --@FeederType BIT ,  
    @FeederType INT ,  
    @OPCalc_A [decimal](16, 3),  
    @OPCalc_B [decimal](16, 3),  
    @OPCalc_C [decimal](16, 3),  
    @OPCalc_D [decimal](16, 3),  
    @OPCalc_E [decimal](16, 3),  
    @OPCalc_F [decimal](16, 3),  
    @OPCalc_G [decimal](16, 3),  
    @OPCalc_H [decimal](16, 3),  
    @OPCalc_I [decimal](16, 3),  
    @OPCalc_N [decimal](16, 3),  
    @RowNum int,  
    @Status BIT OUTPUT  
AS   
    BEGIN  
        SET NOCOUNT ON   
        IF ( ( SELECT   COUNT(*)  
               FROM     [PowerHeatCalc].[dbo].Tbl_PHT_Miscelleneous_Module  
               WHERE    [CabinetModuleID] = @CabinetModuleID  
             ) > 0 )   
            BEGIN  
                UPDATE  [PowerHeatCalc].[dbo].Tbl_PHT_Miscelleneous_Module  
                --     [CabinetModuleID] = @CabinetID , commented by karthik to avoid duplication  
                    SET    [ModelID] = @ModelID ,  
                        [ModelDescription] = @ModelDescription ,  
                        [Quantity] = @Quantity ,  
                        [IsUIO] = @IsUIO ,  
                        [AI_UIO_ChannelCount] = @AI_UIO_ChannelCount ,  
                        [AO_UIO_ChannelCount] = @AO_UIO_ChannelCount ,  
                        [DI_UIO_ChannelCount] = @DI_UIO_ChannelCount ,  
                        [DO_UIO_ChannelCount] = @DO_UIO_ChannelCount ,  
                        [IOTA_UIO_ChannelCount] = @IOTA_UIO_ChannelCount ,  
                        [FeederType] = @FeederType,  
                        [OPCalc_A] = @OPCalc_A,  
                        [OPCalc_B] = @OPCalc_B,  
                        [OPCalc_C] = @OPCalc_C,  
                        [OPCalc_D] = @OPCalc_D,  
                        [OPCalc_E] = @OPCalc_E,  
                        [OPCalc_F] = @OPCalc_F,  
                        [OPCalc_G] = @OPCalc_G,  
                        [OPCalc_H] = @OPCalc_H,  
                        [OPCalc_I] = @OPCalc_I,  
                        [OPCalc_N] = @OPCalc_N,  
                        [RowNum]   = 1                          
                WHERE   [CabinetModuleID] = @CabinetModuleID  
      
            END  
        ELSE   
            BEGIN  
                INSERT  INTO [PowerHeatCalc].[dbo].Tbl_PHT_Miscelleneous_Module  
                        ( [CabinetModuleID] ,  
                          [CompID] ,    
                          [ModelID] ,  
                          [ModelDescription] ,  
                          [Quantity] ,  
                          [IsUIO] ,  
                          [AI_UIO_ChannelCount] ,  
                          [AO_UIO_ChannelCount] ,  
                          [DI_UIO_ChannelCount] ,  
                          [DO_UIO_ChannelCount] ,  
                          [IOTA_UIO_ChannelCount] ,  
                          [FeederType],  
                            [OPCalc_A],  
                            [OPCalc_B] ,  
                        [OPCalc_C],  
                        [OPCalc_D],  
                        [OPCalc_E] ,  
                        [OPCalc_F],  
                        [OPCalc_G],  
                        [OPCalc_H],  
                        [OPCalc_I],  
                        [OPCalc_N],  
                        [RowNum]                                 
                        )  
                        SELECT  @CabinetModuleID ,  
                                @CabinetID ,    
                                @ModelID ,  
                           @ModelDescription ,  
                                @Quantity ,  
                                @IsUIO ,  
                                @AI_UIO_ChannelCount ,  
                                @AO_UIO_ChannelCount ,  
                                @DI_UIO_ChannelCount ,  
                                @DO_UIO_ChannelCount ,  
                                @IOTA_UIO_ChannelCount ,  
                                @FeederType,  
                                @OPCalc_A,  
                                 @OPCalc_B,  
                                @OPCalc_C,  
                                @OPCalc_D,  
                                @OPCalc_E,  
                                @OPCalc_F,  
                                @OPCalc_G,  
                                @OPCalc_H,  
                                @OPCalc_I,  
                                @OPCalc_N,  
                                1                                
            END  
        SET @Status = 1  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_UpdateProjectSettings]    Script Date: 06/09/2017 21:18:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_UpdateProjectSettings]
    @ProjectID UNIQUEIDENTIFIER ,
    @ProjectName NVARCHAR(256) ,
    @CustomerName NVARCHAR(256) ,
    @PONbr NVARCHAR(256) ,
    @ProjectNbr NVARCHAR(256) ,
    @HonDocumentNbr NVARCHAR(256) ,
    @CustomerDocumentNbr NVARCHAR(256) ,
    @ProjNameReportHeader BIT ,
    @ProjNbrReportCover BIT ,
    @ProjNbrReportHeader BIT ,
    @HonDocNbrReportCover BIT ,
    @HonDocNbrReportHeader BIT ,
    @CustomerDocNbrReportCover BIT ,
    @CustomerDocNbrReportHeader BIT ,
    @InputVoltage INT ,
    @InputFrequency INT ,
    @CreatedBy NVARCHAR(50) ,
    @CreatedDate NVARCHAR(50) ,
    @ModifiedBy NVARCHAR(50) ,
    @ModifiedDate NVARCHAR(50) ,
    @Status BIT OUTPUT
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;
        IF ( ( SELECT   COUNT(*)
               FROM     [PowerHeatCalc].[dbo].[Tbl_PHT_Project]
               WHERE    ProjectID = @ProjectID
             ) > 0 ) 
            BEGIN
                UPDATE  [PowerHeatCalc].[dbo].[Tbl_PHT_Project]
                SET     [ProjectName] = @ProjectName ,
                        [CustomerName] = @CustomerName ,
                        [PONbr] = @PONbr ,
                        [ProjectNbr] = @ProjectNbr ,
                        [HonDocumentNbr] = @HonDocumentNbr ,
                        [CustomerDocumentNbr] = @CustomerDocumentNbr ,
                        [ProjNameReportHeader] = @ProjNameReportHeader ,
                        [ProjNbrReportCover] = @ProjNbrReportCover ,
                        [ProjNbrReportHeader] = @ProjNbrReportHeader ,
                        [HonDocNbrReportCover] = @HonDocNbrReportCover ,
                        [HonDocNbrReportHeader] = @HonDocNbrReportHeader ,
                        [CustomerDocNbrReportCover] = @CustomerDocNbrReportCover ,
                        [CustomerDocNbrReportHeader] = @CustomerDocNbrReportHeader ,
                        [InputVoltage] = @InputVoltage ,
                        [InputFrequency] = @InputFrequency ,
                        [ModifiedBy] = @ModifiedBy ,
                        [ModifiedDate] = @ModifiedDate
                WHERE   [ProjectID] = @ProjectID 	  
	       
                SET @Status = 1    
            END
        ELSE 
            IF ( ( SELECT   COUNT(*)
                   FROM     [PowerHeatCalc].[dbo].[Tbl_PHT_Project]
                   WHERE    ProjectName = @ProjectName
                 ) = 0 ) 
                BEGIN
                    INSERT  INTO [PowerHeatCalc].[dbo].[Tbl_PHT_Project]
                            ( [ProjectID] ,
                              [ProjectName] ,
                              [CustomerName] ,
                              [PONbr] ,
                              [ProjectNbr] ,
                              [HonDocumentNbr] ,
                              [CustomerDocumentNbr] ,
                              [ProjNameReportHeader] ,
                              [ProjNbrReportCover] ,
                              [ProjNbrReportHeader] ,
                              [HonDocNbrReportCover] ,
                              [HonDocNbrReportHeader] ,
                              [CustomerDocNbrReportCover] ,
                              [CustomerDocNbrReportHeader] ,
                              [InputVoltage] ,
                              [InputFrequency] ,
                              [CreatedBy] ,
                              [CreatedDate] ,
                              [ModifiedBy] ,
                              [ModifiedDate]
                            )
                    VALUES  ( @ProjectID ,
                              @ProjectName ,
                              @CustomerName ,
                              @PONbr ,
                              @ProjectNbr ,
                              @HonDocumentNbr ,
                              @CustomerDocumentNbr ,
                              @ProjNameReportHeader ,
                              @ProjNbrReportCover ,
                              @ProjNbrReportHeader ,
                              @HonDocNbrReportCover ,
                              @HonDocNbrReportHeader ,
                              @CustomerDocNbrReportCover ,
                              @CustomerDocNbrReportHeader ,
                              @InputVoltage ,
                              @InputFrequency ,
                              @CreatedBy ,
                              @CreatedDate ,
                              @ModifiedBy ,
                              @ModifiedDate
                            )
           
                    SET @Status = 1
                END 
            ELSE 
                BEGIN
                    SET @Status = 0
                END       
 
     
                      
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_UpdatePH_ForSMPSU]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_UpdatePH_ForSMPSU]          
    @CabinetId UNIQUEIDENTIFIER    ,  
    @CabModuleId UNIQUEIDENTIFIER,  
    @ModelId INT,  
    @POWER DECIMAL(16,2),  
    @HEATDISSIPATION DECIMAL(16,2),  
    @BTU DECIMAL(16,2)  
    
 AS    
 BEGIN    
   
 UPDATE Tbl_PHT_SMCabinet_Module SET IDC_Pri= @POWER ,    
                       TotalHeat_Des_Watts= @HEATDISSIPATION,    
                       TotalHeat_Des_Btu= @BTU    
                       WHERE   ModelID=  @ModelId  AND CabinetID=@CabinetId 
                       --AND   CabinetModuleID=@CabModuleId  
   
    
 END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_Cabinet_Temperature]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Update_Cabinet_Temperature]
    @CabinetID UNIQUEIDENTIFIER ,
    @CabTempID UNIQUEIDENTIFIER ,
    @FanQuantity INT ,
    @Tambient [decimal](16, 2),
    @dT INT ,
    @CabTemp [decimal](16, 2),  
    @Fan_AirFlow [decimal](16, 2),        
    @Status BIT OUTPUT
AS 
    BEGIN
        SET NOCOUNT ON        
                INSERT  INTO [dbo].Tbl_PHT_Cabinet_Temp
                        ( [CabTempID]
           ,[CabinetID]
           ,[FanQuantity]
           ,[Tambient]
           ,[dT]
           ,[CabTemp]
           ,Fan_AirFlow  )
                        SELECT  @CabTempID ,
                                @CabinetID ,
                                @FanQuantity ,
                                @Tambient ,
                                @dT ,
                                @CabTemp,
                                @Fan_AirFlow                                                                  
        SET @Status = 1
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchCabinetModule_SM]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchCabinetModule_SM]  
    @CabinetID UNIQUEIDENTIFIER  
AS   
    BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
        SET NOCOUNT ON ;  
  
       SELECT  *,Devices_OnBoards as nChan  
        FROM    Tbl_PHT_SMCabinet_Module  
        WHERE   CabinetID = @CabinetID  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Calculation]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Calculation]
	@PS_EFF DECIMAL(10,3),
	@POWER_FACTOR DECIMAL(10,3),
	@INRUSH DECIMAL(10,3),
	@PS_OUTPUT DECIMAL(10,3),
	@INPUT_SUPPLY DECIMAL(10,3),
	@QTY int, 
	@HEAT DECIMAL(10,3),
	@IS_AC BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @FORMULA_TBL TABLE(Alias nvarchar(50),
	Formula nvarchar(255))
	
	--SELECT FORUMAL FROM FORMULA TABLE
	INSERT INTO @FORMULA_TBL
	SELECT [Alais]
      ,[Formula]  FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Formula_Table]
  
--UPDATE PROJECT SETTINGS & ADVANCE SETTINGS VALUE IN TABLE VARIABLE

UPDATE @FORMULA_TBL SET  Formula=Convert(Varchar(15),@PS_EFF) WHERE Alias='J'
UPDATE @FORMULA_TBL SET  Formula=Convert(Varchar(15),@POWER_FACTOR) WHERE Alias='K'
UPDATE @FORMULA_TBL SET  Formula=Convert(Varchar(15),@INRUSH) WHERE Alias='L'
UPDATE @FORMULA_TBL SET  Formula=Convert(Varchar(15),@PS_OUTPUT) WHERE Alias='M'
UPDATE @FORMULA_TBL SET  Formula=Convert(Varchar(15),@INPUT_SUPPLY) WHERE Alias='N'
UPDATE @FORMULA_TBL SET  Formula=Convert(Varchar(15),@HEAT) WHERE Alias='O'
UPDATE @FORMULA_TBL SET  Formula=Convert(Varchar(15),@QTY) WHERE Alias='P'

--CALCULATION PART - START

DECLARE @ALIAS varchar(25)
DECLARE @DynamicFormula varchar(500)
DECLARE @OVALUE DECIMAL(10,3)

DECLARE PHT_CRSR CURSOR FOR

SELECT Alias
FROM @FORMULA_TBL 

OPEN PHT_CRSR

FETCH NEXT FROM PHT_CRSR INTO  @ALIAS

WHILE (@@FETCH_STATUS = 0) 
BEGIN
SET @DynamicFormula='';
SET @OVALUE=0;

SELECT @DynamicFormula=Formula FROM @FORMULA_TBL WHERE Alias=@ALIAS;

IF(LEN(@DynamicFormula)>0)
	BEGIN
		IF(@IS_AC=1)
			BEGIN

				IF(@ALIAS='C' OR @ALIAS='D')
				BEGIN
					SET @DynamicFormula='0';
				END
			END
		ELSE
			BEGIN
				IF(@ALIAS='C' OR @ALIAS='B')
				BEGIN
					SET @DynamicFormula='0';
				END
			END


		SET @DynamicFormula=REPLACE(@DynamicFormula,'A',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='A'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'B',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='B'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'C',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='C'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'D',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='D'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'E',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='E'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'F',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='F'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'G',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='G'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'H',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='H'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'I',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='I'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'J',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='J'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'K',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='K'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'L',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='L'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'M',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='M'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'N',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='N'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'O',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='O'));
		SET @DynamicFormula=REPLACE(@DynamicFormula,'P',(SELECT Formula FROM @FORMULA_TBL WHERE Alias='P'));

		SET @DynamicFormula='SELECT '+@DynamicFormula

		DECLARE @RESULT table (OP_VALUE DECIMAL(10,3));

		INSERT INTO @RESULT (OP_VALUE) EXECUTE(@DynamicFormula);

		SELECT @OVALUE=OP_VALUE FROM @RESULT

		UPDATE @FORMULA_TBL SET Formula=@OVALUE WHERE Alias=@ALIAS

	END
FETCH NEXT FROM PHT_CRSR INTO @ALIAS

END 

CLOSE PHT_CRSR
DEALLOCATE PHT_CRSR

SELECT * FROM @FORMULA_TBL

END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Insert_ModuleDef_SM]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------Build 3    
         
   CREATE PROC [dbo].[SP_PHT_Insert_ModuleDef_SM]        
    @Category NVARCHAR(100) ,          
    @HoneywellModel NVARCHAR(50) ,           
    @Description NVARCHAR(256) ,        
    @code Nvarchar(10),        
    @nChan int ,        
    @cSignalType Nvarchar(50),        
    @nWDG int,        
    @nInputLoad decimal(10,2),        
    @24V_IO bit,        
    @48V_IO bit,        
    @60V_IO bit,        
    @110V_IO bit,        
    @220V_IO bit,        
    @nL_5V decimal(10,2),        
    @nL_24i decimal(10,2),        
    @nL_24e decimal(10,2),        
    @nL_48i decimal(10,2),        
    @nL_48e decimal(10,2),        
    @nL_60i decimal(10,2),        
    @nL_60e decimal(10,2),        
    @nL_110i decimal(10,2),        
    @nL_110e decimal(10,2),        
    @nL_220i decimal(10,2),        
    @nL_220e decimal(10,2),        
    @nOutputLoad decimal(10,2),        
    @def_OutputLoad decimal(10,2),        
       @Module_Group VARCHAR(100) ,        
       @VDrop decimal(10,2),        
          @Status BIT OUTPUT,  
          @IS_AC_COMPONENT bit,  
        @PHCompChannelWise bit,  
        @FanCapacity NVARCHAR(100),  
        @Heatdissipation FLOAT ,
        @OutputVoltage NVARCHAR(100) ,
        @PowerDissipationBarrier decimal(10,3) ,  
        @DevicesOnBoard int ,
        @CurrentRating    decimal(16,3)   
AS         
    BEGIN        
        DECLARE @MODELID INT   
        DECLARE @POWERSUPPLY VARCHAR(50)
        
             
        SET @MODELID = 0        
 --TO GET NEXT MODEL_ID NUMBER  
 if(@code<>'PSU')
 begin      
        --SELECT  @MODELID = ( CASE WHEN MAX(MODELID) IS NULL THEN 1        
        --                          ELSE ( MAX(MODELID) + 1 )        
        --                     END )        
        --FROM    tbl_PHT_MODULEDEF  
        
        select @MODELID = ( CASE WHEN MAX(MODELID) IS NULL THEN 1        
                                  ELSE ( MAX(MODELID) + 1 ) END ) from 
(        
   SELECT  ISNULL(MAX(ModelID),0) as ModelID FROM Tbl_PHT_ModuleDef
   
)temp;
        end
        else
        begin 
          SELECT  @MODELID = ( CASE WHEN MAX(MODELID) IS NULL THEN 1        
                                  ELSE ( MAX(MODELID) + 1 )        
                             END )        
        FROM    (        
   SELECT  ISNULL(MAX(ModelID),0) as ModelID FROM Tbl_PHT_PowerSupply_ModuleDef
)temp;  
        end      
 --TO INSERT INTO TABLE        
        IF ( @MODELID > 0 and @code<>'PSU')         
            BEGIN  
            
                 
								INSERT  INTO [dbo].[Tbl_PHT_ModuleDef]        
										(         
										  [ModelID]         
						,[Category]                  
						,[HoneywellModel]             
						,[Description]             
						,[Module_Group]        
						,[code]        
						,[nChan]        
						,[cSignalType]        
						,[nWDG]        
						,[nInputLoad]        
						,[24V_IO]        
						,[48V_IO]        
						,[60V_IO]        
						,[110V_IO]        
						,[220V_IO]        
						,[nL_5V]        
						,[nL_24i]        
						,[nL_24e]        
						,[nL_48i]        
						,[nL_48e]        
						,[nL_60i]        
						,[nL_60e]        
						,[nL_110i]        
						,[nL_110e]        
						,[nL_220i]        
						,[nL_220e]         
						,[nV_drop]               
						,[nOutputLoad]        
						,[def_OutputLoad]    
						,[Heatdissipation],  
						IS_AC_COMPONENT,  
						PHCompChannelWise ,  
						[FanCapacity],  
						[IsCustom],
						[OutputVoltage]   ,
						[Power_Dissipation_Barrier]     ,
						[Devices_OnBoard]
				                
										)        
										SELECT          
										  @MODELID,        
										  @Category ,             
						@HoneywellModel  ,           
						@Description  ,        
						@Module_Group  ,        
						@code,        
						@nChan ,        
						@cSignalType,        
						@nWDG,         
						@nInputLoad ,        
						@24V_IO ,        
						@48V_IO ,        
						@60V_IO ,        
						@110V_IO ,        
						@220V_IO ,        
						@nL_5V ,        
						@nL_24i ,        
						@nL_24e ,        
						@nL_48i ,        
						@nL_48e ,        
						@nL_60i ,        
						@nL_60e ,        
						@nL_110i ,        
						@nL_110e ,        
						@nL_220i ,        
						@nL_220e ,        
						@VDrop,      
						@nOutputLoad ,        
						@def_OutputLoad,    
						 @Heatdissipation,  
						 @IS_AC_COMPONENT,  
						@PHCompChannelWise ,  
						@FanCapacity,  
						1  ,
						@OutputVoltage      ,
						@PowerDissipationBarrier,
						@DevicesOnBoard      
            
            
              
            END     
            
            else IF ( @MODELID > 0 and @code='PSU')         
            BEGIN  
            
                 
								INSERT  INTO [dbo].[Tbl_PHT_PowerSupply_ModuleDef]        
										(         
										  [ModelID]         
						,[Category]                  
						,[HoneywellModel]             
						,[Description]             
						,[Module_Group]        
						,[code]   
						,[Heatdissipation],  
						IS_AC_COMPONENT,  
						[IsCustom],
						[OutputVoltage],CurrentRating
				                
										)        
										SELECT          
										  @MODELID,        
										  @Category ,             
						@HoneywellModel  ,           
						@Description  ,        
						@Module_Group  ,        
						@code,    					   
						 @Heatdissipation,  
						 @IS_AC_COMPONENT,					 
						1 ,
						@OutputVoltage,@CurrentRating
						   
            
            
              
            END      
            
            
			--IF (@code='PSU')
			--BEGIN
			--  UPDATE Tbl_PHT_ModuleDef SET [24V_IO]=0,[48V_IO]=0,[60V_IO]=0,[110V_IO]=0,[220V_IO]=0 WHERE HoneywellModel=@HoneywellModel
			--END   
        
         
        SET @Status = 1   
        
        
             
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Insert_ModuleDef]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Insert_ModuleDef]  
    @Category NVARCHAR(100) ,  
    @Manufacturer NVARCHAR(100) ,  
    @HoneywellModel NVARCHAR(50) ,  
    @NonHWManufacturerPartNbr NVARCHAR(50) ,  
    @Description NVARCHAR(256) ,  
    @Weight FLOAT ,  
    @Heatdissipation FLOAT , 
    @CurrentRating FLOAT , 
    @SupplyVoltage NVARCHAR(50) ,  
    @PHCompChannelWise BIT ,  
    @FanCapacity NVARCHAR(100) ,  
    @AI_Heatdissipation FLOAT ,  
    @AO_Heatdissipation FLOAT ,  
    @DI_Heatdissipation FLOAT ,  
    @DO_Heatdissipation FLOAT ,  
    @IOTA_Heatdissipation FLOAT ,  
    @General_Field1 NVARCHAR(100) ,  
    @General_Field2 NVARCHAR(100) ,  
    @General_Field3 NVARCHAR(100) ,  
    @General_Field4 NVARCHAR(100) ,  
    @General_Field5 NVARCHAR(100) ,  
    @IS_AC_COMPONENT BIT ,  
    @Module_Group VARCHAR(100) , 
    @IS_MISC_COMPONENT BIT =0,  
    @OutputVoltage NVARCHAR(100), 
    @Status BIT OUTPUT  
AS   
    BEGIN  
        DECLARE @MODELID INT  
        SET @MODELID = 0  
 --TO GET NEXT MODEL_ID NUMBER  
        --SELECT  @MODELID = ( CASE WHEN MAX(MODELID) IS NULL THEN 1  
        --                          ELSE ( MAX(MODELID) + 1 )  
        --                     END )  
        --FROM    tbl_PHT_MODULEDEF
        
        select @MODELID = ( CASE WHEN MAX(MODELID) IS NULL THEN 1        
                                  ELSE ( MAX(MODELID) + 1 ) END ) from 
(        
   SELECT  ISNULL(MAX(ModelID),0) as ModelID FROM Tbl_PHT_ModuleDef
   UNION 
   SELECT  ISNULL(MAX(ModelID),0) as ModelID FROM Tbl_PHT_PowerSupply_ModuleDef
)temp;  
 --TO INSERT INTO TABLE  
        IF ( @MODELID > 0 and @Module_Group<>'Power Supply')   
            BEGIN   
               select @MODELID = ( CASE WHEN MAX(MODELID) IS NULL THEN 1        
                                  ELSE ( MAX(MODELID) + 1 ) END ) from 
(        
   SELECT  ISNULL(MAX(ModelID),0) as ModelID FROM Tbl_PHT_ModuleDef   
)temp;  
                INSERT  INTO [dbo].[Tbl_PHT_ModuleDef]  
                        ( [ModelID] ,  
                          [Category] ,  
                          [Manufacturer] ,  
                          [HoneywellModel] ,  
                          [NonHWManufacturerPartNbr] ,  
                          [Description] ,  
                          [Weight] ,  
                          [Heatdissipation] ,  
                          [SupplyVoltage] ,  
                          [PHCompChannelWise] ,  
                          [FanCapacity] ,  
                          [AO_Heatdissipation] ,  
                          [AI_Heatdissipation] ,  
                          [DI_Heatdissipation] ,  
                          [DO_Heatdissipation] ,  
                          [IOTA_Heatdissipation] ,  
                          [General_Field1] ,  
                          [General_Field2] ,  
                          [General_Field3] ,  
                          [General_Field4] ,  
                          [General_Field5] ,  
                          [IS_AC_COMPONENT] ,  
                          [Module_Group] ,  
                          [IsCustom]  ,
                          [Is_Misc_Comp],
                           [OutputVoltage]
                        )  
                        SELECT  @ModelID ,  
                                @Category ,  
                                @Manufacturer ,  
                                @HoneywellModel ,  
                                @NonHWManufacturerPartNbr ,  
                                @Description ,  
                                @Weight ,  
                                @Heatdissipation ,  
                                @SupplyVoltage ,  
                                @PHCompChannelWise ,  
                                @FanCapacity ,  
                                @AI_Heatdissipation ,  
                                @AO_Heatdissipation ,  
                                @DI_Heatdissipation ,  
                                @DO_Heatdissipation ,  
                                @IOTA_Heatdissipation ,  
                                @General_Field1 ,  
                                @General_Field2 ,  
                                @General_Field3 ,  
                                @General_Field4 ,  
                                @General_Field5 ,  
                                @IS_AC_COMPONENT ,  
                                @Module_Group ,  
                                1 ,
                                @IS_MISC_COMPONENT,
                                @OutputVoltage 
            END  
            else
            begin
               select @MODELID = ( CASE WHEN MAX(MODELID) IS NULL THEN 1        
                                  ELSE ( MAX(MODELID) + 1 ) END ) from 
(    
   SELECT  ISNULL(MAX(ModelID),0) as ModelID FROM Tbl_PHT_PowerSupply_ModuleDef
)temp;  
            INSERT  INTO [dbo].[Tbl_PHT_PowerSupply_ModuleDef]  
                        ( [ModelID] ,  
                          [Category] ,  
                          [Manufacturer] ,  
                          [HoneywellModel] ,   
                          [Description] ,  
                          [Weight] ,  
                          [Heatdissipation] ,  
                          [SupplyVoltage] , 
                          [IS_AC_COMPONENT] ,  
                          [Module_Group] ,  
                          [IsCustom]  ,
                           [OutputVoltage],
                           CurrentRating
                        )  
                        SELECT  @ModelID ,  
                                @Category ,  
                                @Manufacturer ,  
                                @HoneywellModel ,   
                                @Description ,  
                                @Weight ,  
                                @Heatdissipation ,  
                                @SupplyVoltage ,                                
                                @IS_AC_COMPONENT ,  
                                @Module_Group ,  
                                1 ,
                                @OutputVoltage ,
                                @CurrentRating
            end
        SET @Status = 1  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_CustomCabinetTemp]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_CustomCabinetTemp]   
 -- Add the parameters for the stored procedure here  
 @ProjId1 uniqueidentifier,  
 @Group1 varchar(5000),  
 @Group2 varchar(5000),  
 @Group3 varchar(5000)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
  
IF 1=0 BEGIN  
    SET FMTONLY OFF  
END  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  --Modified for FR27
--      CREATE TABLE #MODULE_INFO  
--(CabinetName nvarchar(256),CabinetType VARCHAR(200),Area nvarchar(256),Location nvarchar(256),CabinetDesc VARCHAR(256),CabinetHeight int,CabinetWidth int,CabinetDepth int,FanQuantity int,FanAirFlow int,HeatLoad decimal(16, 2),GeneralNotes nvarchar(500),Fa
--nQty int,Tambient decimal(16, 2),dT int,CabTemp decimal(16, 2),Groups nvarchar(256))  
            CREATE TABLE #MODULE_INFO  
(CabinetName nvarchar(256),CabinetType VARCHAR(200),Area nvarchar(256),Location nvarchar(256),CabinetDesc VARCHAR(256),CabinetHeight int,
CabinetWidth int,CabinetDepth int,FanQuantity int,FanAirFlow int,HeatLoad decimal(16, 2),GeneralNotes nvarchar(500),FanQty int,
Tambient decimal(16, 2),dT int,CabTemp decimal(16, 2),HeatLoadWithConversion varchar(100),EnclosureSurfaceInWatts decimal(16,2),
EnclosureSurfaceWithConversion varchar(100),TotalWatts decimal(16,2),TotalConversion varchar(100),Groups nvarchar(256))  
--ends here

Declare @ProjId varchar(75)  
set @ProjId = @ProjId1  
if(Len(@Group1) > 0)  
Begin  
EXEC SP_PHT_RPT_Fetch_CustomCabinetTempInfo @ProjectId=@ProjId , @Group = @Group1 ,@Groups = 'Group1'  
End  
if(Len(@Group2) > 0)  
Begin  
EXEC SP_PHT_RPT_Fetch_CustomCabinetTempInfo @ProjectId=@ProjId , @Group = @Group2 ,@Groups = 'Group2'  
End  
if(Len(@Group3) > 0)  
Begin  
EXEC SP_PHT_RPT_Fetch_CustomCabinetTempInfo @ProjectId=@ProjId , @Group = @Group3 ,@Groups = 'Group3'  
End  
  
  
 --SELECT DISTINCT CabinetName,CabinetType,Area,Location,CabinetDesc,CabinetHeight,CabinetWidth,CabinetDepth,FanQuantity,FanAirFlow,HeatLoad,GeneralNotes,FanQty,Tambient,dT,CabTemp,Groups from #MODULE_INFO order by FanQty DESC  
 SELECT DISTINCT CabinetName,CabinetType,Area,Location,CabinetDesc,CabinetHeight,CabinetWidth,CabinetDepth,FanQuantity,FanAirFlow,
 HeatLoad,GeneralNotes,FanQty,Tambient,dT,CabTemp,HeatLoadWithConversion,EnclosureSurfaceInWatts,EnclosureSurfaceWithConversion,TotalWatts,TotalConversion,Groups
 from #MODULE_INFO order by FanQty DESC  
 
  
END
GO
/****** Object:  Table [dbo].[Tbl_PHT_MiscComponents_Configuration]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_MiscComponents_Configuration](
	[CompId] [uniqueidentifier] NOT NULL,
	[ProjectID] [uniqueidentifier] NULL,
	[Name] [nvarchar](50) NULL,
	[Desc] [nvarchar](50) NULL,
	[MiscTypeID] [int] NULL,
	[Area] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[GeneralNotes] [nvarchar](500) NULL,
	[PSUPSFeeder] [int] NULL,
 CONSTRAINT [PK_Tbl_PHT_MiscComponents_Configuration] PRIMARY KEY CLUSTERED 
(
	[CompId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PHT_Groups]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_PHT_Groups](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Group_Name] [varchar](50) NOT NULL,
	[ProjectID] [uniqueidentifier] NOT NULL,
	[Group_Type] [int] NOT NULL,
	[Description] [varchar](250) NULL,
 CONSTRAINT [PK_tbl_PHT_Groups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_PowerSupply_SMCabinet]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_PHT_PowerSupply_SMCabinet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Cabinet_ID] [uniqueidentifier] NULL,
	[ModelID] [int] NULL,
	[PowerSupply_Type] [varchar](50) NULL,
	[Efficiency] [decimal](18, 2) NULL,
	[MaxRatePower] [decimal](18, 2) NULL,
	[IsRedundant] [bit] NULL,
	[IsSelected] [bit] NOT NULL,
 CONSTRAINT [PK_Tbl_PHT_PowerSupply_SMCabinet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_Cabinet_Module]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Cabinet_Module](
	[CabinetModuleID] [uniqueidentifier] NOT NULL,
	[CabinetID] [uniqueidentifier] NULL,
	[PowerDrawTypeID] [uniqueidentifier] NOT NULL,
	[ModelID] [int] NOT NULL,
	[ModelDescription] [nvarchar](256) NULL,
	[Quantity] [int] NOT NULL,
	[IsUIO] [bit] NULL,
	[AI_UIO_ChannelCount] [int] NULL,
	[AO_UIO_ChannelCount] [int] NULL,
	[DI_UIO_ChannelCount] [int] NULL,
	[DO_UIO_ChannelCount] [int] NULL,
	[IOTA_UIO_ChannelCount] [int] NULL,
	[FeederType] [int] NULL,
	[OPCalc_A] [decimal](16, 2) NULL,
	[OPCalc_B] [decimal](16, 2) NULL,
	[OPCalc_C] [decimal](16, 2) NULL,
	[OPCalc_D] [decimal](16, 2) NULL,
	[OPCalc_E] [decimal](16, 2) NULL,
	[OPCalc_F] [decimal](16, 2) NULL,
	[OPCalc_G] [decimal](16, 2) NULL,
	[OPCalc_H] [decimal](16, 2) NULL,
	[OPCalc_I] [decimal](16, 2) NULL,
	[OPCalc_N] [decimal](16, 2) NULL,
	[RowNum] [int] NULL,
 CONSTRAINT [PK_Tbl_PH_Cabinet_Module] PRIMARY KEY CLUSTERED 
(
	[CabinetModuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_CabinetTempInfo]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec dbo.SP_PHT_RPT_Fetch_CabinetTempInfo @ProjectID='F4224D05-78B8-413B-AC91-19CFCD94AE16'


CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_CabinetTempInfo]    
 -- Add the parameters for the stored procedure here    
 @ProjectID uniqueidentifier     
AS    
BEGIN    
    
    --Added by Shyamala for FR27
     DECLARE @ISBTU_HR BIT
     DECLARE @CONVERSION VARCHAR(15)
     SELECT @ISBTU_HR=AdvPowerHeatUnit FROM Tbl_PHT_Report_Setting where projectid=@ProjectID
     IF(@ISBTU_HR=1)
     BEGIN
      SET @CONVERSION = ' BTU/Hr '
     END
     ELSE
     BEGIN
           SET @CONVERSION = ' KCal/Hr '
     END
     
    --Ends here
IF 1=0 BEGIN    
    SET FMTONLY OFF    
END    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 Select TBL_CAB.CabinetName,    
        (SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=TBL_CAB.CabinetTypeID) as CabinetType,    
        TBL_CAB.Area,    
        TBL_CAB.Location,    
        TBL_CAB.CabinetDesc,    
        TBL_CAB.CabinetHeight,    
        TBL_CAB.CabinetWidth,    
        TBL_CAB.CabinetDepth,    
        TBL_CAB.FanQuantity,    
        TBL_CAB.FanAirFlow,    
        TBL_CAB.HeatLoad,    
        TBL_CAB.GeneralNotes,    
        TBL_TMP.FanQuantity as FanQty,    
        TBL_TMP.Tambient,    
        TBL_TMP.dT,    
        TBL_TMP.CabTemp  ,
        CASE WHEN(@ISBTU_HR=1) THEN Convert(varchar(50),TBL_CAB.HeatLoadInBTU)+@CONVERSION
                               ELSE Convert(varchar(50),TBL_CAB.HeatLoadInKcalHr)+@CONVERSION END As HeatLoadWithConversion,
                               
       EnclosureSurfaceInWatts, 
       CASE WHEN(@ISBTU_HR=1)THEN Convert(varchar(50),EnclosureSurfaceInBtu)+@CONVERSION
                                ELSE Convert(varchar(50),EnclosureSurfaceInKcal)+@CONVERSION END As EnclosureSurfaceWithConversion,
       TBL_CAB.HeatLoad + EnclosureSurfaceInWatts As TotalWatts,
       CASE WHEN(@ISBTU_HR=1) THEN Convert(varchar(50),TBL_CAB.HeatLoadInBTU+EnclosureSurfaceInBtu)+ @CONVERSION
                              ELSE Convert(varchar(50),TBL_CAB.HeatLoadInKcalHr + EnclosureSurfaceInKcal)+@CONVERSION END as TotalConversion
       
       
 FROM Tbl_PHT_Cabinet_Temp TBL_TMP,Tbl_PHT_Cabinet_Configuration TBL_CAB    
 WHERE  TBL_TMP.CabinetID=TBL_CAB.CabinetID    
 AND TBL_CAB.ProjectID=@ProjectID    
 order by TBL_CAB.CabinetName,TBL_TMP.FanQuantity DESC    
            
     
     
     
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_MISCELLENEOUSInfo]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_MISCELLENEOUSInfo] --'6E04565E-E8C2-4B18-807B-DDFCE2B77081'         
 -- Add the parameters for the stored procedure here          
 @PROJECTID uniqueidentifier   --='6E04565E-E8C2-4B18-807B-DDFCE2B77081'
AS          
BEGIN          
          
IF 1=0 BEGIN          
    SET FMTONLY OFF          
END          
 -- SET NOCOUNT ON added to prevent extra result sets from          
 -- interfering with SELECT statements.          
 SET NOCOUNT ON;          

    
--Added By Ram Prasath
CREATE TABLE #MISCELLENEOUSMODULE_INFO (ROWNUM INT,CABINETNAME VARCHAR(255),CABINETTYPE VARCHAR(100),CABDESC VARCHAR(256),Area nvarchar(256),          
 Location nvarchar(256) ,GeneralNotes nvarchar(500) ,Is_Secondary int,ModelID INT,HWModel VARCHAR(150),Module_Group VARCHAR(100),Mod_Desc varchar(500),Qty int,Heat decimal(16,2),IsAC Bit,A decimal(16,2),          
B decimal(16,2),          
C decimal(16,2),          
D decimal(16,2),          
E decimal(16,2),          
F decimal(16,2),          
G decimal(16,2),          
H decimal(16,2),          
I decimal(16,2),    
Vdrop decimal(16,2),     
PF decimal(16,2) ,        
IsBtu_hr bit,          
SIAC decimal(16,2) default 0.00,          
SVA decimal(16,2) default 0.00,          
SWatts decimal(16,2) default 0.00,          
SG decimal(16,2) default 0.00,          
SI decimal(16,2) default 0.00,          
SNDC decimal(16,2) default 0.00
,EnclosureWATTS decimal(16,2)
,EnclosureConversion decimal(16,2)
)        
          
  
          
DECLARE @CABID uniqueidentifier          
--ADDED BY SHYAMALA          
DECLARE @CABINET_TYPE AS INT      
   
DECLARE @PF decimal(4,2)     
   
DECLARE @AdvIsPowerFactor bit    
  SELECT @AdvIsPowerFactor=AdvIsPowerFactor FROM Tbl_PHT_Report_Setting where projectid=@PROJECTID     
IF(@AdvIsPowerFactor=1)    
BEGIN    
SELECT @PF=AdvPowerFactor FROM Tbl_PHT_Report_Setting   where projectid=@PROJECTID       
END    
ELSE    
BEGIN    
SET @PF=1    
END        
        
        
        
         
          
SELECT @CABINET_TYPE=Misc_type.MiscTypeID from           
dbo.Tbl_PHT_MiscComponents_Configuration config inner join Tbl_PHT_Miscelleneous_Type Misc_type           
on config.MiscTypeID=Misc_type.MiscTypeID where CompId=@CABID          
          
--ENDS HERE          
 
          
       
          
          --Added By Ram Prasath
          
         
        DECLARE @MISCID uniqueidentifier              
DECLARE PHT_MISC_CABID CURSOR FOR          
SELECT CompID FROM Tbl_PHT_MiscComponents_Configuration WHERE PROJECTID=@PROJECTID          
       DECLARE @ISBTU_HR BIT                
               
OPEN PHT_MISC_CABID          
       
FETCH NEXT FROM PHT_MISC_CABID INTO  @CABID          
          
WHILE (@@FETCH_STATUS = 0)           
BEGIN          
     
                      
                 
        SELECT                  
                @ISBTU_HR=TBL_RPT_SET.AdvPowerHeatUnit                
        FROM    TBL_PHT_PROJECT TBL_PRJ ,                
                Tbl_PHT_Report_Setting TBL_RPT_SET,                
                Tbl_PHT_MiscComponents_Configuration TBL_MISC                
        WHERE   TBL_PRJ.ProjectID = TBL_RPT_SET.ProjectID                
        AND TBL_MISC.CompID=@CABID                
                AND TBL_PRJ.ProjectID = TBL_MISC.ProjectID   
INSERT INTO #MISCELLENEOUSMODULE_INFO                
(CABINETNAME,CABINETTYPE,CABDESC,Area,Location,GeneralNotes,Is_Secondary,ModelID,HWModel,Module_Group,Mod_Desc,Qty,Heat,IsAC,A,B,C,D,E,F,G,H,I,Vdrop,PF,IsBtu_hr,EnclosureWATTS,EnclosureConversion)                
SELECT               
--ROW_NUMBER() OVER(ORDER BY TBL_CAB.CabinetName,TBL_MOD.PowerDrawTypeID,TBL_MOD.ModelID),                
TBL_CAB.Name,                
(SELECT DisplayText as MiscTypeName FROM Tbl_PHT_Miscelleneous_Type WHERE MiscTypeID=TBL_CAB.MiscTypeID)                
,TBL_CAB.[Desc]  
      ,TBL_CAB.Area                
      ,TBL_CAB.Location                
      ,TBL_CAB.GeneralNotes        --(CASE WHEN TBL_MOD.FeederType=2 THEN 1    ELSE 0 END)  
      ,TBL_MOD.FeederType      
      ,TBL_MOD.ModelID                      
      ,TBL_MOD_DEF.HoneywellModel                
      ,TBL_MOD_DEF.Module_Group                
      ,TBL_MOD.ModelDescription                
      ,TBL_MOD.Quantity                
      ,(CASE               
      WHEN TBL_MOD.IsUIO=1               
      THEN ((TBL_MOD.AI_UIO_ChannelCount*TBL_MOD_DEF.AI_Heatdissipation)+(TBL_MOD.AO_UIO_ChannelCount*TBL_MOD_DEF.AO_Heatdissipation)+              
      (TBL_MOD.DI_UIO_ChannelCount*TBL_MOD_DEF.DI_Heatdissipation)+              
      (TBL_MOD.DO_UIO_ChannelCount*TBL_MOD_DEF.DO_Heatdissipation)+(TBL_MOD.IOTA_UIO_ChannelCount*TBL_MOD_DEF.IOTA_Heatdissipation))              
       ELSE TBL_MOD_DEF.Heatdissipation END)                
      ,TBL_MOD_DEF.IS_AC_COMPONENT                  
      ,TBL_MOD.OPCalc_A                
      ,TBL_MOD.OPCalc_B                
      ,TBL_MOD.OPCalc_C                
      ,TBL_MOD.OPCalc_D                
      ,TBL_MOD.OPCalc_E                
      ,TBL_MOD.OPCalc_F                
      ,TBL_MOD.OPCalc_G                
      ,TBL_MOD.OPCalc_H                
      ,TBL_MOD.OPCalc_I         
      ,0 ,        
      0         
      ,@ISBTU_HR    
     , 0 as EnclosureWATTS    
     , 0 as EnclosureConversion              
      FROM Tbl_PHT_Miscelleneous_Module TBL_MOD,Tbl_PHT_ModuleDef TBL_MOD_DEF,                 
      Tbl_PHT_MiscComponents_Configuration TBL_CAB                
 WHERE TBL_MOD.ModelID=TBL_MOD_DEF.ModelID                 
 AND TBL_MOD.CompId=TBL_CAB.CompId                
 AND TBL_CAB.CompId=@CABID           
--EXEC SP_PHT_RPT_Fetch_ModuleInfo @CABINETID=@CABID,@PROJID=@PROJECTID          
FETCH NEXT FROM PHT_MISC_CABID INTO @CABID          
          
END           
          
CLOSE PHT_MISC_CABID          
DEALLOCATE PHT_MISC_CABID 
          
             
                    
  --UPDATE #MISCELLENEOUSMODULE_INFO SET           
  --SIAC = E,          
  --SVA = F,          
  --SWatts = H,          
  --SG = G,          
  --SI =I where Is_Secondary = 1  
  UPDATE #MISCELLENEOUSMODULE_INFO SET           
  SIAC = E,          
  SVA = F,          
  SWatts = H,          
  SG = G,          
  SI =I,E=0,F=0,H=0,G=0,I=0 where Is_Secondary = 2    
  
    UPDATE #MISCELLENEOUSMODULE_INFO SET           
  SIAC = E,          
  SVA = F,          
  SWatts = H,          
  SG = G,          
  SI =I where Is_Secondary = 3        
          
  UPDATE #MISCELLENEOUSMODULE_INFO SET           
  SNDC = A          
  where IsAC = 0          
          
  UPDATE #MISCELLENEOUSMODULE_INFO SET           
  SNDC = 0          
  where IsAC = 1          
          
  --UPDATE #MISCELLENEOUSMODULE_INFO SET           
  --SIAC = 0,          
  --SVA = 0,          
  --SWatts = 0,          
  --SG = 0,          
  --SI = 0 where Is_Secondary = 0  
          
         --end here 
          
   
            
       SELECT CABINETNAME ,          
  CABINETTYPE ,CABDESC,        
  Area,          
   Location,          
   GeneralNotes,          
   Is_Secondary,          
   ModelID ,          
   HWModel ,          
   Module_Group,          
   Mod_Desc ,          
   Qty ,          
   Heat ,          
   IsAC ,          
   A ,          
  B ,          
  C,          
  D ,          
  E ,          
  F,          
  G ,          
  H ,          
  I, (CASE WHEN IsBtu_hr=1 THEN 'Btu/Hr' ELSE 'Kcal/Hr' END) as BTU_KCAL_UNIT,          
  SIAC,          
  SVA,          
  SWatts,          
  SG,          
  SI,          
  SNDC,Vdrop,PF,EnclosureWATTS
,EnclosureConversion FROM #MISCELLENEOUSMODULE_INFO    
       
            
                
                    
     DROP TABLE #MISCELLENEOUSMODULE_INFO           
          
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_CustomSummary]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_CustomSummary]    --'c733800d-bcba-413a-979b-11b8e49052d7','''2ebf2046-8e43-4a13-a802-9f5cf31383b3''','','' 
 -- Add the parameters for the stored procedure here    
 @ProjId1 uniqueidentifier,    
 @Group1 varchar(5000),    
 @Group2 varchar(5000),    
 @Group3 varchar(5000)    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
    
IF 1=0 BEGIN    
    SET FMTONLY OFF    
END    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
    
    CREATE TABLE #MODULE_INFO (ROWNUM INT,CABINETNAME VARCHAR(255),CABINETTYPE VARCHAR(100),CABDESC VARCHAR(256),PowerDrawType VARCHAR(255),Area nvarchar(256),    
 Location nvarchar(256),GeneralNotes nvarchar(500),Is_Secondary int,ModelID INT,HWModel VARCHAR(150),Module_Group VARCHAR(100),Mod_Desc varchar(500),Qty int,Heat decimal(16,2),IsAC Bit,A decimal(16,2),    
B decimal(16,2),    
C decimal(16,2),    
D decimal(16,2),    
E decimal(16,2),    
F decimal(16,2),    
G decimal(16,2),    
H decimal(16,2),    
I decimal(16,2),    
IsBtu_hr bit,    
Groups nvarchar(256),    
SIAC decimal(16,2),    
SVA decimal(16,2),    
SWatts decimal(16,2),    
SG decimal(16,2),    
SI decimal(16,2),    
SNDC decimal(16,2),    
Vdrop decimal(16,2),    
PF decimal(16,2)
,EnclosureWATTS decimal(16,2)  
,EnclosureConversion decimal(16,2))    
    
    
    CREATE TABLE #SM_MODULE_INFO (ROWNUM INT,CABINETNAME VARCHAR(255),CABINETTYPE VARCHAR(100),CABDESC VARCHAR(256),PowerDrawType VARCHAR(255),Area nvarchar(256),    
 Location nvarchar(256) ,GeneralNotes nvarchar(500) ,Is_Secondary int,ModelID INT,HWModel VARCHAR(150),Module_Group VARCHAR(100),Mod_Desc varchar(500),Qty int,Heat decimal(16,2),IsAC Bit,A decimal(16,2),    
B decimal(16,2),    
C decimal(16,2),    
D decimal(16,2),    
E decimal(16,2),    
F decimal(16,2),    
G decimal(16,2),    
H decimal(16,2),    
I decimal(16,2),    
IsBtu_hr bit,    
Groups nvarchar(256),    
SIAC decimal(16,2),    
SVA decimal(16,2),    
SWatts decimal(16,2),    
SG decimal(16,2),    
SI decimal(16,2),    
SNDC decimal(16,2),    
Vdrop decimal(16,2),    
PF decimal(16,2)
,EnclosureWATTS decimal(16,2)  
,EnclosureConversion decimal(16,2)  
)    
    
    
DECLARE @PF decimal(4,2)     
--@ProjectId    
DECLARE @AdvIsPowerFactor bit    
  SELECT @AdvIsPowerFactor=AdvIsPowerFactor FROM Tbl_PHT_Report_Setting where projectid=@ProjId1     
IF(@AdvIsPowerFactor=1)    
BEGIN    
SELECT @PF=AdvPowerFactor FROM Tbl_PHT_Report_Setting   where projectid=@ProjId1       
END    
ELSE    
BEGIN    
SET @PF=1    
END    
    
    
Declare @ProjId varchar(75)    
set @ProjId = @ProjId1    
if(Len(@Group1) > 0)    
Begin    
EXEC SP_PHT_RPT_Fetch_CustomModuleInfo @ProjectId=@ProjId , @Group = @Group1 ,@Groups = 'Group1'    
End    
if(Len(@Group2) > 0)    
Begin    
EXEC SP_PHT_RPT_Fetch_CustomModuleInfo @ProjectId=@ProjId , @Group = @Group2 ,@Groups = 'Group2'    
End    
if(Len(@Group3) > 0)    
Begin    
EXEC SP_PHT_RPT_Fetch_CustomModuleInfo @ProjectId=@ProjId , @Group = @Group3 ,@Groups = 'Group3'    
End    
    
  UPDATE #MODULE_INFO SET           
  SIAC = E,          
  SVA = F,          
  SWatts = H,          
  SG = G,          
  SI =I,E=0,F=0,H=0,G=0,I=0 where Is_Secondary = 2    
  
    UPDATE #MODULE_INFO SET           
  SIAC = E,          
  SVA = F,          
  SWatts = H,          
  SG = G,          
  SI =I where Is_Secondary = 3  
    
UPDATE #MODULE_INFO SET     
SNDC = A    
where IsAC = 0    
    
UPDATE #MODULE_INFO SET     
SNDC = 0    
where IsAC = 1    
    
--UPDATE #MODULE_INFO SET     
--SIAC = 0,    
--SVA = 0,    
--SWatts = 0,    
--SG = 0,    
--SI = 0 where Is_Secondary = 0    
    
    
    
    
UPDATE #SM_MODULE_INFO SET     
 SIAC = E,    
 --SVA = Round(((Heat)/@PF),3),    
 SVA = Round(((Heat)/@PF),2),    
 SWatts = Heat,    
 --SG = Round((Heat*3.413),3),    
 SG = Round((Heat*3.413),2),    
 --SI =Round(((Heat*3.413)/3.968),3) where Is_Secondary = 1    
 SI =Round(((Heat*3.413)/3.968),2),E=0,F=0,H=0,G=0,I=0 where Is_Secondary = 2    
 
     
UPDATE #SM_MODULE_INFO SET     
 SIAC = E,    
 --SVA = Round(((Heat)/@PF),3),    
 SVA = Round(((Heat)/@PF),2),    
 SWatts = Heat,    
 --SG = Round((Heat*3.413),3),    
 SG = Round((Heat*3.413),2),    
 --SI =Round(((Heat*3.413)/3.968),3) where Is_Secondary = 1    
 SI =Round(((Heat*3.413)/3.968),2),
 F=Round(((Heat)/@PF),2),H=Heat,G=Round((Heat*3.413),2),I=Round(((Heat*3.413)/3.968),2)
  where Is_Secondary = 3
     
    
UPDATE #SM_MODULE_INFO SET     
 SNDC = A    
 where IsAC = 0    
    
UPDATE #SM_MODULE_INFO SET     
 SNDC = 0    
 where IsAC = 1     
     
--UPDATE #SM_MODULE_INFO SET     
-- SIAC = 0,    
-- SVA = 0,    
-- SWatts = 0,    
-- SG = 0,    
-- SI = 0 where Is_Secondary = 0     
      
    
    
DECLARE @QRY NVARCHAR(MAX)    
    
                                                                                                                                                                                                                                                               
  
                                                       
SET @QRY='SELECT CABINETNAME ,CABINETTYPE,CABDESC,PowerDrawType ,Area,Location,GeneralNotes ,Is_Secondary,HWModel ,ModelID , Module_Group ,Mod_Desc     
,Qty ,Heat,IsAC,A,B,C,D,E,F,G,H,I,(CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN cast(Round(F,2) as Decimal(16,2)) ELSE 0 END) AS VA,    
(CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN H ELSE 0 END)  AS WATTS,    
(CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN (CASE WHEN IsBtu_hr=1 THEN cast(Round(G,2) as Decimal(16,2)) ELSE cast(Round(I,2) as Decimal(16,2)) END) ELSE 0 END)  AS BTU_KCAL,    
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN cast(Round(F,2) as Decimal(16,2)) ELSE 0 END) AS VA_SEC,    
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN cast(Round(H,2) as Decimal(16,2)) ELSE 0 END) AS WATTS_SEC,    
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN (CASE WHEN IsBtu_hr=1 THEN cast(Round(G,2) as Decimal(16,2)) ELSE cast(Round(I,2) as Decimal(16,2)) END) ELSE 0 END) AS BTU_KCAL_SEC,    
(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN cast(Round(F,2) as Decimal(16,2)) ELSE 0 END) AS VA_UTIL,(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN cast(Round(H,2) as Decimal(16,2)) ELSE 0 END)  AS WATTS_UTIL,    
(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN (CASE WHEN IsBtu_hr=1 THEN cast(Round(G,2) as Decimal(16,2)) ELSE cast(Round(I,2) as Decimal(16,2)) END) ELSE 0 END)  AS BTU_KCAL_UTIL,    
(CASE WHEN IsBtu_hr=1 THEN ''Btu/Hr'' ELSE ''Kcal/Hr'' END) as BTU_KCAL_UNIT,Groups,SIAC,SVA,SWatts,SG,SI,SNDC,Vdrop,PF ,EnclosureWATTS,EnclosureConversion    
FROM #MODULE_INFO '+ ' union all ' +    
    
'SELECT CABINETNAME ,CABINETTYPE ,CABDESC,PowerDrawType ,Area,Location ,GeneralNotes,Is_Secondary,HWModel,ModelID , Module_Group ,Mod_Desc ,    
Qty,Heat,IsAC,A,B,C,D,E,F,G,H,I,CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN Cast(Round(((Heat)/'+Convert(varchar(50),@PF)+'),2) as Decimal(16,2)) ELSE 0 END AS VA,    
CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN Heat ELSE 0 END as WATTS,    
(CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN (CASE WHEN IsBtu_hr=1 THEN Cast(Round((Heat*3.413),2) As Decimal(16,2)) ELSE CAST(Round(((Heat*3.413)/3.968),2) AS decimal(16,2)) END) ELSE 0 END)  AS BTU_KCAL,    
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN  Cast(Round(((Heat)/'+Convert(varchar(50),@PF)+'),2) As Decimal(16,2)) ELSE 0 END) AS VA_SEC,    
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN Heat ELSE 0 END) AS WATTS_SEC,    
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN (CASE WHEN IsBtu_hr=1 THEN Cast(Round((Heat*3.413),2) As Decimal(16,2)) ELSE Cast(Round(((Heat*3.413)/3.968),2) As Decimal(16,2)) END) ELSE 0 END) AS BTU_KCAL_SEC,    
(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN Cast(Round(((Heat)/'+Convert(varchar(50),@PF)+'),2) As Decimal(16,2)) ELSE 0 END) AS VA_UTIL,    
(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN Heat ELSE 0 END)  AS WATTS_UTIL,    
(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN (CASE WHEN IsBtu_hr=1 THEN G ELSE I END) ELSE 0 END)  AS BTU_KCAL_UTIL,    
(CASE WHEN IsBtu_hr=1 THEN ''Btu/Hr'' ELSE ''Kcal/Hr'' END) as BTU_KCAL_UNIT,Groups,SIAC,SVA,SWatts,SG,SI,SNDC,Vdrop,PF ,EnclosureWATTS,EnclosureConversion   
FROM #SM_MODULE_INFO '  + ' order by Groups,CABINETNAME '    
    
     
     
    
    
    
Exec (@QRY)    
 
DROP TABLE #MODULE_INFO    
    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_ResetCabinetConfigTimeOutRecords]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_PHT_ResetCabinetConfigTimeOutRecords]
AS 
    BEGIN
        DECLARE @val_CabinetID UNIQUEIDENTIFIER
        DECLARE CabinetID_CURSOR CURSOR FOR
        SELECT [CabinetID]      
        FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Configuration]
        WHERE DATEDIFF(minute, EditStartTime, CURRENT_TIMESTAMP) > 60
        OPEN CabinetID_CURSOR
        FETCH NEXT FROM CabinetID_CURSOR
INTO @val_CabinetID
        WHILE @@FETCH_STATUS = 0 
            BEGIN
                UPDATE  [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Configuration]
                SET     IsActive = 0 ,
                        hostname = '' ,
                        EditStartTime = ''
                WHERE   @val_CabinetID = [CabinetID]
                FETCH NEXT FROM CabinetID_CURSOR
      INTO @val_CabinetID
            END
        CLOSE CabinetID_CURSOR
        DEALLOCATE CabinetID_CURSOR   
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_Cabinet_Configuration]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Update_Cabinet_Configuration]    
    @CabinetID UNIQUEIDENTIFIER ,    
    @ProjectID UNIQUEIDENTIFIER ,    
    @CabinetName NVARCHAR(256) ,    
    @CabinetDesc NVARCHAR(256) ,    
    @CabinetTypeID INT ,    
    @Area NVARCHAR(256) ,    
    @Location NVARCHAR(256) ,    
    @GeneralNotes NVARCHAR(500) ,    
    @PSFront INT ,    
    @PSRear INT ,    
    @PSUPSFeeder INT ,    
    @CabinetHeight INT ,    
    @CabinetWidth INT ,    
    @CabinetDepth INT ,    
    @FanQuantity INT ,    
    @FanAirFlow INT ,    
    @HeatLoad [decimal](16, 2) ,    
    @FanModel NVARCHAR(50),  
    @EnclosureSurfaceInWatts DECIMAL(16,2),  
    @EnclosureSurfaceInBtu DECIMAL(16,2),  
    @EnclosureSurfaceInKcal DECIMAL(16,2),  
    @HeatLoadInBTU decimal(16,2),
    @HeatLoadInKcalHr decimal(16,2),
    @FrontEfficiency decimal(18,4),
	@RearEfficiency decimal(18,4),
    @Status BIT OUTPUT    
AS     
    BEGIN    
        SET NOCOUNT ON     
        
        IF ( ( SELECT   COUNT(*)    
               FROM     [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Configuration]    
               WHERE    [CabinetID] = @CabinetID    
             ) > 0 )     
            BEGIN    
                UPDATE  [dbo].[Tbl_PHT_Cabinet_Configuration]    
                SET     [CabinetID] = @CabinetID ,    
                        [ProjectID] = @ProjectID ,    
                        [CabinetName] = @CabinetName ,    
                        [CabinetDesc] = @CabinetDesc ,    
                        [CabinetTypeID] = @CabinetTypeID ,    
                        [Area] = @Area ,    
                        [Location] = @Location ,    
                        [GeneralNotes] = @GeneralNotes ,    
                        [PSFront] = @PSFront ,    
                        [PSRear] = @PSRear ,    
                        [PSUPSFeeder] = @PSUPSFeeder ,    
                        [CabinetHeight] = @CabinetHeight ,    
                        [CabinetWidth] = @CabinetWidth ,    
                        [CabinetDepth] = @CabinetDepth ,    
                        [FanQuantity] = @FanQuantity,    
                        [HeatLoad] = @HeatLoad,    
                        [FanAirFlow] = @FanAirFlow,    
                        [FanModel] = @FanModel,    
                        [EnclosureSurfaceInWatts] =@EnclosureSurfaceInWatts,  
                        [EnclosureSurfaceInBtu]=@EnclosureSurfaceInBtu,  
                        [EnclosureSurfaceInKcal]=@EnclosureSurfaceInKcal ,
                        [HeatLoadInBTU]=@HeatLoadInBTU,
                        [HeatLoadInKcalHr]=@HeatLoadInKcalHr ,
                        FrontEfficiency=@FrontEfficiency,
                        RearEfficiency=@RearEfficiency
                WHERE   [CabinetID] = @CabinetID    
        
            END    
        ELSE     
            BEGIN    
                INSERT  INTO [dbo].[Tbl_PHT_Cabinet_Configuration]    
                        ( [CabinetID] ,    
                          [ProjectID] ,    
                          [CabinetName] ,    
                          [CabinetDesc] ,    
                          [CabinetTypeID] ,    
                          [Area] ,    
                          [Location] ,    
                          [GeneralNotes] ,    
                          [PSFront] ,    
                          [PSRear] ,    
                          [PSUPSFeeder] ,    
                          [CabinetHeight] ,    
                          [CabinetWidth] ,    
                          [CabinetDepth] ,    
                          [FanQuantity],    
                          [HeatLoad],    
                          [FanAirFlow],    
                          [FanModel] ,  
                          [EnclosureSurfaceInWatts],  
                          [EnclosureSurfaceInBtu],  
                          [EnclosureSurfaceInKcal]  ,
                          [HeatLoadInBTU],
                          [HeatLoadInKcalHr]  ,
                          FrontEfficiency,
                          RearEfficiency
                        )    
                        SELECT  @CabinetID ,    
                                @ProjectID ,    
                                @CabinetName ,    
                                @CabinetDesc ,    
                                @CabinetTypeID ,    
                                @Area ,    
                                @Location ,    
                                @GeneralNotes ,    
                                @PSFront ,    
                                @PSRear ,    
                                @PSUPSFeeder ,    
                                @CabinetHeight ,    
                                @CabinetWidth ,    
                                @CabinetDepth ,    
                                @FanQuantity,    
                                @HeatLoad,    
                                @FanAirFlow,    
                                @FanModel  ,  
                                @EnclosureSurfaceInWatts,  
                                @EnclosureSurfaceInBtu,  
                                @EnclosureSurfaceInKcal,
                                @HeatLoadInBTU,
                                @HeatLoadInKcalHr ,
                                @FrontEfficiency,
                                 @RearEfficiency
            END    
                
 IF ( ( SELECT   COUNT(*)    
               FROM     [PowerHeatCalc].[dbo].Tbl_PHT_Cabinet_Temp    
               WHERE    [CabinetID] = @CabinetID    
             ) > 0 )     
            BEGIN    
               Delete From   Tbl_PHT_Cabinet_Temp                       
                WHERE   [CabinetID] = @CabinetID        
            END    
     
        SET @Status = 1    
  
 
    
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_SetCabinetInUse]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_SetCabinetInUse]
    @CabinetID UNIQUEIDENTIFIER ,
    @Hostname NVARCHAR(255) ,
    @CabStatus BIT
AS 
    BEGIN    	
        IF ( @CabStatus = 0 ) 
            BEGIN
                UPDATE  [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Configuration]
                SET     IsActive = 0 ,
                        hostname = NULL ,
                        EditStartTime = NULL
                WHERE   [CabinetID] = @CabinetID
                        AND hostname = @Hostname  

            END
        ELSE 
            BEGIN
                UPDATE  [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Configuration]
                SET     IsActive = 1 ,
                        hostname = @Hostname ,
                        EditStartTime = CURRENT_TIMESTAMP
                WHERE   [CabinetID] = @CabinetID       

            END

    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Save_Groupdetails]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_PHT_Save_Groupdetails]
@ProjectID uniqueidentifier,
@GroupName varchar(50),
@GroupId int ,
@Group_Type int

as
Begin
--delete from Tbl_PHT_Groups where ProjectID = @ProjectID
	if(@GroupId=0)
	begin
		insert into Tbl_PHT_Groups (Group_Name,ProjectID,Group_Type)
		 Values (@GroupName,@ProjectID,@Group_Type)
	end
	
	else
	begin
		Update Tbl_PHT_Groups set Group_Name=@GroupName,ProjectID=@ProjectID,Group_Type=@Group_Type where ID=@GroupID
	end
End
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_AdvSetting_Fetch_SMCabinet_Temp]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_PHT_AdvSetting_Fetch_SMCabinet_Temp]  
@CabinetID uniqueIDentifier  
as  
--select CabTempID, CabinetID, FanQuantity, Tambient, dT, CabTemp, Fan_AirFlow   
--From Tbl_PHT_Cabinet_Temp   
--where CabinetID = @CabinetID  
select CabinetHeight,CabinetWidth,CabinetDepth,FanQuantity,FanAirFlow
from
Tbl_PHT_Cabinet_Configuration
where CabinetID=@CabinetID
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_CheckGroupExists]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_PHT_CheckGroupExists]  
@Group TYPE_PHT_GROUP READONLY  ,
@Status BIT OUTPUT   
AS   
  
Begin  
 --  CREATE TABLE #GroupID (Item VARCHAR(200))	 
 --INSERT INTO #GroupID SELECT Item FROM dbo.SplitString(@GroupID)
     IF ( ( select Count(GP.ID) from Tbl_PHT_Groups GP,@Group GP1 where GP.ID=GP1.[Group ID] and GP.ID in(select GP.ID from Tbl_PHT_SMCabinet_Module SM,Tbl_PHT_Groups GP where SM.GroupID=GP.ID) and GP.Group_Type<>GP1.[Group Type]
             ) > 0 ) 
            BEGIN
            
            SET @Status = 0
            end
            else
            begin
            SET @Status = 1
            end
 
 End
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_CheckFanModelExists]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_CheckFanModelExists]  
    @ProjectId UNIQUEIDENTIFIER,
    @FanModel VARCHAR(1000)
	AS   
    BEGIN  
	 -- SET NOCOUNT ON added to prevent extra result sets from  
	 -- interfering with SELECT statements.  
        SET NOCOUNT ON ;  
        
		CREATE TABLE #FanModels (Item VARCHAR(200))
		INSERT INTO #FanModels SELECT Item FROM dbo.SplitString(@FanModel)
		
        SELECT  
        COUNT(DISTINCT(FanModel)) AS FanCount 
        FROM    
        Tbl_PHT_Cabinet_Temp A,  dbo.Tbl_PHT_Cabinet_Configuration B
		where A.CabinetId = B.CabinetId AND 
		ProjectId = @ProjectId AND 
		FanModel IN (SELECT Item FROM #FanModels)
		
		DROP TABLE #FanModels
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Delete_Miscelleneous]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Delete_Miscelleneous]     --'b0986182-f391-448e-98c3-31e8f2ec8e84'
 -- Add the parameters for the stored procedure here    
    @CabinetCabID VARCHAR(1500)    
AS     
    BEGIN    
        DECLARE @QRY VARCHAR(1500)  
        
      DELETE FROM [Tbl_PHT_Miscelleneous_Module] WHERE CompID IN (@CabinetCabID )
      DELETE FROM [Tbl_PHT_MiscComponents_Configuration] WHERE CompID IN (@CabinetCabID )
            -- added by mani    
     --      SET @QRY = 'DELETE FROM [Tbl_PHT_Miscelleneous_Module] WHERE '    
     
     --   SET @QRY = @QRY + ' CabinetModuleID IN (' + @CabinetCabID + ')'    
     --print @QRY
     --   EXEC(@QRY)    
            
       --select * from [Tbl_PHT_Miscelleneous_Module]
                   
            
         
    END    
------------------------------------------------------------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Cabinet_Configuration]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_Cabinet_Configuration]
    @CabinetID UNIQUEIDENTIFIER
AS 
    BEGIN
        SET NOCOUNT ON 
  
        SELECT  [CabinetID] ,
                [ProjectID] ,
                [CabinetName] ,
                [CabinetDesc] ,
                [CabinetTypeID] ,
                [Area] ,
                [Location] ,
                [GeneralNotes] ,
                [PSFront] ,
                [PSRear] ,
                [PSUPSFeeder] ,
                [CabinetHeight] ,
                [CabinetWidth] ,
                [CabinetDepth] ,
                [FanModel] ,
                [FanQuantity] ,
                [IsActive] ,
                [HostName]
        FROM    [dbo].[Tbl_PHT_Cabinet_Configuration]
        WHERE   ( [CabinetID] = @CabinetID ) 
    
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Export_MiscelleneousDetails]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Export_MiscelleneousDetails]    --'B0A2F870-0342-425A-8DC9-360240F17285'     
      @ProjectID UNIQUEIDENTIFIER  
AS   
    BEGIN  
     SELECT Tbl_PHT_Project.ProjectName, Tbl_PHT_MiscComponents_Configuration.Name, Tbl_PHT_Miscelleneous_Type.DisplayText as CabinetTypeName,   
                      Tbl_PHT_MiscComponents_Configuration.[Desc], Tbl_PHT_MiscComponents_Configuration.Area, Tbl_PHT_MiscComponents_Configuration.Location,   
						 Tbl_PHT_MiscComponents_Configuration.PSUPSFeeder,   
                       Tbl_PHT_ModuleDef.HoneywellModel, Tbl_PHT_Miscelleneous_Module.ModelDescription, Tbl_PHT_ModuleDef.Heatdissipation, Tbl_PHT_Miscelleneous_Module.Quantity,   
                       
                      Tbl_PHT_Miscelleneous_Module.FeederType,'NA' As GroupName,0.00 as [Load],Tbl_PHT_MiscComponents_Configuration.CompID,-1 as VDC_Type, 0 as UseIn_HeatCalc,Tbl_PHT_Miscelleneous_Module.CabinetModuleID
                      FROM Tbl_PHT_MiscComponents_Configuration INNER JOIN  
                      Tbl_PHT_Miscelleneous_Module ON Tbl_PHT_MiscComponents_Configuration.CompID = Tbl_PHT_Miscelleneous_Module.CompID AND   
                      Tbl_PHT_MiscComponents_Configuration.CompID = Tbl_PHT_Miscelleneous_Module.CompID INNER JOIN  
                      Tbl_PHT_Miscelleneous_Type ON Tbl_PHT_MiscComponents_Configuration.MiscTypeID = Tbl_PHT_Miscelleneous_Type.MiscTypeID INNER JOIN  
                      Tbl_PHT_ModuleDef ON Tbl_PHT_Miscelleneous_Module.ModelID = Tbl_PHT_ModuleDef.ModelID INNER JOIN  
                      Tbl_PHT_Project ON Tbl_PHT_MiscComponents_Configuration.ProjectID = Tbl_PHT_Project.ProjectID   
                      where Tbl_PHT_Project.ProjectID = @ProjectID  
                     
  END  
  --update Tbl_PHT_MiscComponents_Configuration set MiscTypeID=1
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_CabinetInfo_Name]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_CabinetInfo_Name] 
	-- Add the parameters for the stored procedure here
    @CabinetName NVARCHAR(256) ,
    @ProjectID UNIQUEIDENTIFIER ,
    @CabinetID UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

    -- Insert statements for procedure here
        SELECT  [CabinetID] ,
                [ProjectID] ,
                [CabinetName] ,
                [CabinetDesc] ,
                [CabinetTypeID] ,
                [Area] ,
                [Location] ,
                [GeneralNotes] ,
                [PSFront] ,
                [PSRear] ,
                [PSUPSFeeder] ,
                [CabinetHeight] ,
                [CabinetWidth] ,
                [CabinetDepth] ,
                [FanQuantity] ,
                [IsActive] ,
                [HostName]
        FROM    [dbo].[Tbl_PHT_Cabinet_Configuration]
        WHERE   ( [CabinetName] = @CabinetName               
                  AND CabinetID <> @CabinetID AND ProjectID = @ProjectID
                ) 
                ORDER BY CabinetName ASC
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Groupdetails]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_Groupdetails]            
@ProjectID UNIQUEIDENTIFIER            
AS            
BEGIN            
           
--select gp.ID as GroupID, gp.Group_Name as [Group Name],gt.GroupType_Name as Group_Type  from Tbl_PHT_Groups gp   
--inner join tbl_PHT_Group_Type gt on gp.Group_Type=gt.GroupType_ID where ProjectID = @ProjectID   order by [Group_Name]         
     
    
SELECT gp.ID AS GroupID, gp.Group_Name AS [Group Name],gt.GroupType_Name AS Group_Type,  
CASE   
 WHEN  exists(SELECT GroupID FROM Tbl_PHT_SMCabinet_Module WHERE Tbl_PHT_SMCabinet_Module.GroupID = gp.ID)  
  THEN 1  
     ELSE 0  
END AS isUsed,
gt.GroupType_ID     
    
FROM Tbl_PHT_Groups gp inner join tbl_PHT_Group_Type gt ON gp.Group_Type=gt.GroupType_ID  
  
WHERE ProjectID = @ProjectID   ORDER BY [Group_Name]         
            
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_ExistingMiscellaneousMod]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_ExistingMiscellaneousMod]   --'6e04565e-e8c2-4b18-807b-ddfce2b77081'
    @ProjectID UNIQUEIDENTIFIER  
AS   
    BEGIN  
        SET NOCOUNT ON   
    
       SELECT     Tbl_PHT_MiscComponents_Configuration.CompId, Tbl_PHT_MiscComponents_Configuration.Name, Tbl_PHT_ModuleDef.HoneywellModel,Tbl_PHT_MiscComponents_Configuration.Area,Tbl_PHT_MiscComponents_Configuration.Location,Tbl_PHT_MiscComponents_Configuration.[Desc] as Description
         FROM         Tbl_PHT_MiscComponents_Configuration left outer JOIN  
                      Tbl_PHT_Miscelleneous_Module ON Tbl_PHT_MiscComponents_Configuration.CompId = Tbl_PHT_Miscelleneous_Module.CompId AND   
                      Tbl_PHT_MiscComponents_Configuration.CompId = Tbl_PHT_Miscelleneous_Module.CompId left outer JOIN  
                      Tbl_PHT_ModuleDef ON Tbl_PHT_Miscelleneous_Module.ModelID = Tbl_PHT_ModuleDef.ModelID 
         WHERE    Tbl_PHT_MiscComponents_Configuration.ProjectID = @ProjectID  
         
        
      
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Location_Area]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_Location_Area] 
	-- Add the parameters for the stored procedure here
    @ProjectID UNIQUEIDENTIFIER ,
    @SearchCriteria NVARCHAR(100)
AS 
    BEGIN

        IF ( @SearchCriteria = 'Location' ) 
            BEGIN
                --SELECT DISTINCT
                --        Location AS COLUMN1 ,
                --        '' AS COLUMN2
                --FROM    Tbl_PHT_Cabinet_Configuration  where ProjectID = @ProjectID
              SELECT Location AS COLUMN1,''  AS COLUMN2 FROM    Tbl_PHT_Cabinet_Configuration where ProjectID = @ProjectID union
SELECT Location AS COLUMN1,''  AS COLUMN2 FROM Tbl_PHT_MiscComponents_Configuration where ProjectID = @ProjectID
            END
        ELSE 
            IF ( @SearchCriteria = 'Area' ) 
                BEGIN
                    --SELECT DISTINCT
                    --        Area AS COLUMN1 ,
                    --        '' AS COLUMN2
                    --FROM    Tbl_PHT_Cabinet_Configuration where ProjectID = @ProjectID
                    SELECT DISTINCT Area AS COLUMN1 ,'' AS COLUMN2 FROM    Tbl_PHT_Cabinet_Configuration where ProjectID = @ProjectID
                    union
                    SELECT DISTINCT Area AS COLUMN1 ,'' AS COLUMN2 FROM    Tbl_PHT_MiscComponents_Configuration where ProjectID = @ProjectID
                END
            ELSE 
                IF ( @SearchCriteria = 'CabinetType' ) 
                    BEGIN
                        SELECT DISTINCT TBL_CAB_TYP.CabinetTypeName AS COLUMN1 ,TBL_CAB.CabinetTypeID AS COLUMN2
                        FROM    Tbl_PHT_Cabinet_Configuration TBL_CAB ,
                                Tbl_PHT_Cabinet_Type TBL_CAB_TYP
                        WHERE   TBL_CAB.CabinetTypeID = TBL_CAB_TYP.CabinetTypeID  and TBL_CAB.ProjectID = @ProjectID
                        union 
                        SELECT DISTINCT TBL_MISC_TYP.MiscTypeName AS COLUMN1 ,TBL_MISC_TYP.MiscTypeID AS COLUMN2
                        FROM    Tbl_PHT_MiscComponents_Configuration TBL_MISC ,
                                Tbl_PHT_Miscelleneous_Type TBL_MISC_TYP
                        WHERE   TBL_MISC.MiscTypeID = TBL_MISC_TYP.MiscTypeID  and TBL_MISC.ProjectID = @ProjectID
                    END
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Project_Config]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_Project_Config] 
	-- Add the parameters for the stored procedure here
    @PROJECTID UNIQUEIDENTIFIER
AS 
    BEGIN
	--TO GET INFORMATION FROM PROJECT SETTINGS & ADVANCE SETTINGS
	--START---
        DECLARE @PS_OUTPUT_VOLTAGE DECIMAL(10, 2)
	
        SET @PS_OUTPUT_VOLTAGE = 24
	
        SELECT  TBL_PRJ.InputVoltage ,
                TBL_PRJ.InputFrequency ,
                TBL_RPT_SET.AdvPowerSupplyEff ,
                TBL_RPT_SET.AdvPowerFactor ,
                TBL_RPT_SET.AdvInrushCurrent ,
                @PS_OUTPUT_VOLTAGE AS PS_OUTPUT_VOLTAGE,
                  TBL_RPT_SET.AdvIsPowerFactor,
                  TBL_RPT_SET.AdvPowerHeatUnit,
                  TBL_RPT_SET.AdvAdmbientTemp
        FROM    TBL_PHT_PROJECT TBL_PRJ ,
                Tbl_PHT_Report_Setting TBL_RPT_SET
        WHERE   TBL_PRJ.ProjectID = TBL_RPT_SET.ProjectID
                AND TBL_PRJ.ProjectID = @PROJECTID

	--END-----
	

    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FETCH_SMEMPTYCABINETS]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FETCH_SMEMPTYCABINETS]                  
 @PROJECTID uniqueidentifier                 
                   
AS   
 BEGIN                 
   DECLARE @PS_OUTPUT_VOLTAGE DECIMAL(10, 2)                    
                     
        SET @PS_OUTPUT_VOLTAGE = 24                    
                   
  SELECT  CabinetID,@PS_OUTPUT_VOLTAGE AS PS_OUTPUT_VOLTAGE    ,              
     CabinetHeight,CabinetWidth,CabinetDepth,FanQuantity,FanAirFlow          
  FROM   Tbl_PHT_Cabinet_Configuration   
  WHERE PROJECTID=@PROJECTID and CabinetTypeID in (6, 7) 
  and CabinetID not in (SELECT CabinetID FROM  dbo.Tbl_PHT_SMCabinet_Module ) 
   

 END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FETCH_SMCABINETS]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FETCH_SMCABINETS] --'7a0fc75b-329b-4cbd-b36b-2ce3443135bd','446'                 
 @PROJECTID uniqueidentifier,        
 @MODELID VARCHAR(4000)                       
                   
AS                  
   DECLARE @PS_OUTPUT_VOLTAGE DECIMAL(10, 2)                    
                     
        SET @PS_OUTPUT_VOLTAGE = 24                    
                   
                   
    IF(@MODELID<>'')        
    BEGIN               
 --Added by shyamala for FR10        
DECLARE @CABINETID UNIQUEIDENTIFIER        
  CREATE TABLE #Modules (Item VARCHAR(200))          
  INSERT INTO #Modules SELECT Item FROM dbo.SplitString(@MODELID)          
        
--select Item from #Modules        
--drop table #Modules        
 --ends here           
                      
select SMModule.CabinetID,SMModule.CabinetModuleID, SMModule.ModelID,ModelDescription,GroupType_Name,Quantity, Is_RUISO, IS_DO,                  
Load,IS_FTA,UseIn_HeatCalc,VDC_Type,Vdrop,IDC_Pri,IAC_Pri,TotalHeat_Des_Watts,TotalHeat_Des_Btu,InputVoltage,@PS_OUTPUT_VOLTAGE AS PS_OUTPUT_VOLTAGE    ,              
CabinetHeight,CabinetWidth,CabinetDepth,FanQuantity,FanAirFlow,Vdrop  ,OutputVoltage,TotalVA ,PowerDrawTypeID,SMModule.Devices_OnBoards as TotalDevices         
from                   
                  
 Tbl_PHT_Cabinet_Configuration CabConfig                  
inner join dbo.Tbl_PHT_SMCabinet_Module  SMModule                  
on SMModule.CabinetID = CabConfig.CabinetID                  
left outer join tbl_PHT_Groups Grp on Grp.ID=SMModule.GroupID                  
left outer  join tbl_PHT_Group_Type Grp_Type on Grp.Group_Type=Grp_Type.GroupType_ID                  
inner join Tbl_PHT_Project ph on ph.ProjectID=CabConfig.projectid            
inner join Tbl_PHT_ModuleDef MD on MD.ModelID= SMModule.ModelID              
 where CabConfig.projectid=@PROJECTID          
 --Added by shyamala for FR10        
 and        
 SMModule.CabinetId in(select distinct cabinetid from Tbl_PHT_SMCabinet_Module where MODELID IN(SELECT Item FROM #Modules) )          
 --ends here         
 Order by CabConfig.CabinetID   ,VDC_TYPE DESC       
 END        
         
 ELSE IF(@MODELID='')        
 BEGIN        
 select SMModule.CabinetID,SMModule.CabinetModuleID, SMModule.ModelID,ModelDescription,GroupType_Name,Quantity, Is_RUISO, IS_DO,                  
Load,IS_FTA,UseIn_HeatCalc,VDC_Type,Vdrop,IDC_Pri,IAC_Pri,TotalHeat_Des_Watts,TotalHeat_Des_Btu,InputVoltage,@PS_OUTPUT_VOLTAGE AS PS_OUTPUT_VOLTAGE    ,              
CabinetHeight,CabinetWidth,CabinetDepth,FanQuantity,FanAirFlow,Vdrop  ,OutputVoltage,TotalVA,PowerDrawTypeID,SMModule.Devices_OnBoards as TotalDevices         
from                   
                  
 Tbl_PHT_Cabinet_Configuration CabConfig                  
inner join dbo.Tbl_PHT_SMCabinet_Module  SMModule                  
on SMModule.CabinetID = CabConfig.CabinetID                  
left outer join tbl_PHT_Groups Grp on Grp.ID=SMModule.GroupID                  
left outer  join tbl_PHT_Group_Type Grp_Type on Grp.Group_Type=Grp_Type.GroupType_ID                  
inner join Tbl_PHT_Project ph on ph.ProjectID=CabConfig.projectid            
inner join Tbl_PHT_ModuleDef MD on MD.ModelID= SMModule.ModelID              
 where CabConfig.projectid=@PROJECTID          
  Order by CabConfig.CabinetID      
 END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchCabinetDetails]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchCabinetDetails]
 @ProjectID UNIQUEIDENTIFIER 
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

        SELECT  TBL_CAB.CabinetID ,
                TBL_CAB.ProjectID ,
                ProjectName ,
                TBL_CAB_TYP.CabinetTypeID ,
                CabinetTypeName ,
                CabinetName ,
                CabinetDesc
        FROM    Tbl_PHT_Cabinet_Configuration TBL_CAB
                INNER JOIN Tbl_PHT_Project TBL_PRJ ON TBL_CAB.ProjectID = TBL_PRJ.ProjectID
                INNER JOIN Tbl_PHT_Cabinet_Type TBL_CAB_TYP ON TBL_CAB_TYP.CabinetTypeID = TBL_CAB.CabinetTypeID where TBL_CAB.ProjectID=@ProjectID

    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchCabinetConfig]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchCabinetConfig]
    @CabinetID UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

        SELECT  *
        FROM    Tbl_PHT_Cabinet_Configuration
        WHERE   CabinetID = @CabinetID
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchAdvancedSettings]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchAdvancedSettings]
    @ProjectID UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

    -- Insert statements for procedure here
        SELECT  [ReportSettingID] ,
                [ProjectID] ,
                [AdvPowerSupplyEff] ,
                [AdvPowerFactor] ,
                [AdvInrushCurrent] ,
                [AdvAdmbientTemp] ,
                [AdvPowerHeatUnit] ,
                [AdvIsPowerFactor]
        FROM    Tbl_PHT_Report_Setting
        WHERE   ProjectID = @ProjectID ;
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchMiscelleneousConfig]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchMiscelleneousConfig]
    @MiscID UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

        SELECT  *,CompID as CabinetID,Name as CabinetName,[Desc] as CabinetDesc
        FROM    Tbl_PHT_MiscComponents_Configuration
        WHERE   CompId = @MiscID
    END
--select * from Tbl_PHT_Miscelleneous_Module
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchReportSettings]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FetchReportSettings]
    @ProjectID UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

    -- Insert statements for procedure here
        SELECT  [ReportSettingID] ,
                [ProjectID] ,
                [ReportTitle] ,
                [ReportSubTitle1] ,
                [ReportSubTitle2] ,
                [ReportSubTitle3] ,
                [RptTitleReportCover] ,
                [RptTitleReportHeader] ,
                [RptSubTitle1ReportCover] ,
                [RptSubTitle2ReportCover] ,
                [RptSubTitle3ReportCover] ,
                [LatestRevision]
        FROM    Tbl_PHT_Report_Setting
        WHERE   ProjectID = @ProjectID ;
    END
GO
/****** Object:  Table [dbo].[Tbl_PHT_RUSIO_SM]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_PHT_RUSIO_SM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Module_ID] [uniqueidentifier] NULL,
	[Cabinet_ID] [uniqueidentifier] NULL,
	[Description] [varchar](250) NOT NULL,
	[Unit_Heat_Dessipation] [decimal](16, 3) NULL,
	[No_Of_Modules] [int] NOT NULL,
	[No_Of_Config_Channel] [int] NOT NULL,
	[Load] [decimal](16, 2) NULL,
	[Total_Heat_Dessipation] [decimal](16, 2) NULL,
	[Module_Name] [varchar](250) NULL,
	[TotalPower] [decimal](18, 2) NOT NULL,
	[Custom] [bit] NULL,
	[Redundant] [bit] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_PHT_Report_Revision_History]    Script Date: 06/09/2017 21:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_PHT_Report_Revision_History](
	[RRHistoryID] [uniqueidentifier] NOT NULL,
	[ReportSettingID] [uniqueidentifier] NOT NULL,
	[RevisionNbr] [nvarchar](50) NOT NULL,
	[Date] [datetime] NULL,
	[Description] [nvarchar](256) NULL,
	[RevBy] [nvarchar](50) NULL,
	[RevCheck] [nvarchar](50) NULL,
	[RevApprove] [nvarchar](50) NULL,
	[BoxNbr] [int] NOT NULL,
	[CustApprove] [nvarchar](50) NULL,
 CONSTRAINT [PK_Report_Revision_History] PRIMARY KEY CLUSTERED 
(
	[RRHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_UpdateReportSettings]    Script Date: 06/09/2017 21:18:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_UpdateReportSettings]
    @ReportSettingID UNIQUEIDENTIFIER ,
    @ProjectID UNIQUEIDENTIFIER ,
    @ReportTitle NVARCHAR(256) ,
    @ReportSubTitle1 NVARCHAR(256) ,
    @ReportSubTitle2 NVARCHAR(256) ,
    @ReportSubTitle3 NVARCHAR(256) ,
    @RptTitleReportCover BIT ,
    @RptTitleReportHeader BIT ,
    @RptSubTitle1ReportCover BIT ,
    @RptSubTitle2ReportCover BIT ,
    @RptSubTitle3ReportCover BIT ,
    @LatestRevision BIT ,
    @Status BIT OUTPUT
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;
        IF ( ( SELECT   COUNT(*)
               FROM     Tbl_PHT_Report_Setting
               WHERE    ReportSettingID = @ReportSettingID
                        AND ProjectID = @ProjectID
             ) > 0 ) 
            BEGIN
                UPDATE  [PowerHeatCalc].[dbo].[Tbl_PHT_Report_Setting]
                SET     [ReportTitle] = @ReportTitle ,
                        [ReportSubTitle1] = @ReportSubTitle1 ,
                        [ReportSubTitle2] = @ReportSubTitle2 ,
                        [ReportSubTitle3] = @ReportSubTitle3 ,
                        [RptTitleReportCover] = @RptTitleReportCover ,
                        [RptTitleReportHeader] = @RptTitleReportHeader ,
                        [RptSubTitle1ReportCover] = @RptSubTitle1ReportCover ,
                        [RptSubTitle2ReportCover] = @RptSubTitle2ReportCover ,
                        [RptSubTitle3ReportCover] = @RptSubTitle3ReportCover ,
                        [LatestRevision] = @LatestRevision
                WHERE   [ReportSettingID] = @ReportSettingID
                        AND [ProjectID] = @ProjectID
            END
        ELSE 
            BEGIN
                INSERT  INTO [PowerHeatCalc].[dbo].[Tbl_PHT_Report_Setting]
                        ( [ReportSettingID] ,
                          [ProjectID] ,
                          [ReportTitle] ,
                          [ReportSubTitle1] ,
                          [ReportSubTitle2] ,
                          [ReportSubTitle3] ,
                          [RptTitleReportCover] ,
                          [RptTitleReportHeader] ,
                          [RptSubTitle1ReportCover] ,
                          [RptSubTitle2ReportCover] ,
                          [RptSubTitle3ReportCover] ,
                          [LatestRevision] ,
                          [AdvPowerSupplyEff],
                          [AdvPowerFactor],
                          [AdvInrushCurrent],
                          [AdvAdmbientTemp],
                          [AdvPowerHeatUnit],
                          [AdvIsPowerFactor] 
                        )
                VALUES  ( @ReportSettingID ,
                          @ProjectID ,
                          @ReportTitle ,
                          @ReportSubTitle1 ,
                          @ReportSubTitle2 ,
                          @ReportSubTitle3 ,
                          @RptTitleReportCover ,
                          @RptTitleReportHeader ,
                          @RptSubTitle1ReportCover ,
                          @RptSubTitle2ReportCover ,
                          @RptSubTitle3ReportCover ,
                          @LatestRevision,
                          0.8,
                          0.95,
                          0.2,
                          25.00,
                          1,
                          1
                        )
            END	
    
           
        SET @Status = 1
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_MiscParts_Configuration]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Update_MiscParts_Configuration]  --'a658d011-1965-4883-99de-24c147cf4e8b','b0a2f870-0342-425a-8dc9-360240f17285','tyuiow','sdf','sdf','fghfgh','',0,0  
    @CabinetID UNIQUEIDENTIFIER ,    
    @ProjectID UNIQUEIDENTIFIER ,    
    @CabinetName NVARCHAR(256) ,    
    @CabinetDesc NVARCHAR(256) ,     
    @Area NVARCHAR(256) ,    
    @Location NVARCHAR(256) ,    
    @GeneralNotes NVARCHAR(500) ,    
    @PSUPSFeeder INT ,    
    @Status BIT OUTPUT    
AS     
    BEGIN    
        SET NOCOUNT ON     
        
        IF ( ( SELECT   COUNT(*)    
               FROM     [PowerHeatCalc].[dbo].[Tbl_PHT_MiscComponents_Configuration]    
               WHERE    [CompId] = @CabinetID     
             ) > 0 )     
            BEGIN    
            print 1
                UPDATE  [dbo].[Tbl_PHT_MiscComponents_Configuration]    
                SET     [CompId] = @CabinetID ,    
                        [ProjectID] = @ProjectID ,    
                        [Name] = @CabinetName ,    
                        [Desc] = @CabinetDesc ,      
                        [Area] = @Area ,    
                        [Location] = @Location ,    
                        [GeneralNotes] = @GeneralNotes ,
                        [PSUPSFeeder] = @PSUPSFeeder,
                        MiscTypeID=1 
                WHERE   [CompId] = @CabinetID    
        
            END    
        ELSE     
            BEGIN    
            print 2
                INSERT  INTO [dbo].[Tbl_PHT_MiscComponents_Configuration]    
                        ( [CompId] ,    
                          [ProjectID] ,    
                          [Name] ,    
                          [Desc] ,
                          [Area] ,    
                          [Location] ,    
                          [GeneralNotes] ,  
                          [PSUPSFeeder],
                          MiscTypeID
                        )    
                        SELECT  @CabinetID ,    
                                @ProjectID ,    
                                @CabinetName ,    
                                @CabinetDesc ,      
                                @Area ,    
                                @Location ,    
                                @GeneralNotes ,   
                                @PSUPSFeeder,1
            END    
                
 IF ( ( SELECT   COUNT(*)    
               FROM     [PowerHeatCalc].[dbo].Tbl_PHT_Cabinet_Temp    
               WHERE    [CabinetID] = @CabinetID    
             ) > 0 )     
            BEGIN    
               Delete From   Tbl_PHT_Cabinet_Temp                       
                WHERE   [CabinetID] = @CabinetID        
            END    
     
        SET @Status = 1    
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_Powersupply_SMCabinet]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_PHT_Update_Powersupply_SMCabinet]
@ID int,
@Cabinet_ID uniqueidentifier,
@ModelID int,
@PowerSupplyType varchar(50),
@Efficiency decimal(18,2),
@MaxRatePower decimal(18,2),
@IsRedundant bit,
@IsSelected bit,
@Status bit output
As
Begin

	if(@ID=0)
		begin
		
		insert into Tbl_PHT_PowerSupply_SMCabinet(Cabinet_Id,ModelID,PowerSupply_Type,Efficiency,MaxRatePower,IsRedundant,IsSelected) 
		values(@Cabinet_ID,@ModelID, @PowerSupplyType,@Efficiency ,@MaxRatePower ,@IsRedundant,@IsSelected) 
		
		end
	else
		begin
		
		   update Tbl_PHT_PowerSupply_SMCabinet set		 
		   [Cabinet_ID]=@Cabinet_ID
		  ,[ModelID]=@ModelID
		  ,[PowerSupply_Type]=@PowerSupplyType
		  ,[Efficiency]=@Efficiency
		  ,[MaxRatePower]=@MaxRatePower
		  ,[IsRedundant]=@IsRedundant
		   ,IsSelected=@IsSelected
			where ID=@ID
      
		end
		set @Status=1
end
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_UpdateReportRevHistory]    Script Date: 06/09/2017 21:18:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_PHT_UpdateReportRevHistory]
    @RRHistoryID UNIQUEIDENTIFIER ,
    @ReportSettingID UNIQUEIDENTIFIER ,
    @RevisionNbr NVARCHAR(50) ,
    @Date NVARCHAR(50) ,
    @Description NVARCHAR(256) ,
    @RevBy NVARCHAR(50) ,
    @RevCheck NVARCHAR(50) ,
    @RevApprove NVARCHAR(50) ,
    @CustApprove NVARCHAR(50) ,
    @BoxNbr INT ,
    @Status BIT OUTPUT
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;
        IF ( ( SELECT   COUNT(*)
               FROM     Tbl_PHT_Report_Revision_History
               WHERE    RRHistoryID = @RRHistoryID
             ) > 0 ) 
            BEGIN
                UPDATE  [PowerHeatCalc].[dbo].[Tbl_PHT_Report_Revision_History]
                SET     [RevisionNbr] = @RevisionNbr ,
                        [Date] = @Date ,
                        [Description] = @Description ,
                        [RevBy] = @RevBy ,
                        [RevCheck] = @RevCheck ,
                        [RevApprove] = @RevApprove ,
                        [CustApprove] = @CustApprove
                WHERE   [RRHistoryID] = @RRHistoryID
                        AND [ReportSettingID] = @ReportSettingID
                        AND [BoxNbr] = @BoxNbr
            END
        ELSE 
            BEGIN       
                INSERT  INTO [PowerHeatCalc].[dbo].[Tbl_PHT_Report_Revision_History]
                        ( [RRHistoryID] ,
                          [ReportSettingID] ,
                          [RevisionNbr] ,
                          [Date] ,
                          [Description] ,
                          [RevBy] ,
                          [RevCheck] ,
                          [RevApprove] ,
                          [BoxNbr] ,
                          [CustApprove]
                        )
                VALUES  ( @RRHistoryID ,
                          @ReportSettingID ,
                          @RevisionNbr ,
                          @Date ,
                          @Description ,
                          @RevBy ,
                          @RevCheck ,
                          @RevApprove ,
                          @BoxNbr ,
                          @CustApprove
                        )
            END   
        SET @Status = 1
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchReportRevisionHistory]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[SP_PHT_FetchReportRevisionHistory]  
    @ReportSettingID UNIQUEIDENTIFIER  
AS   
    BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
        SET NOCOUNT ON ;  
  
    -- Insert statements for procedure here  
        SELECT  RRHistoryID,ReportSettingID,RevisionNbr, convert(datetime,Date) as Date, Description,RevBy,RevCheck,RevApprove,BoxNbr,CustApprove
        FROM    Tbl_PHT_Report_Revision_History  
        WHERE   ReportSettingID =@ReportSettingID ;  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FETCH_SMPOWER]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FETCH_SMPOWER]
@CabinetID	uniqueidentifier
 
AS

SELECT PowerSupply_Type,Efficiency,IsSelected from Tbl_PHT_PowerSupply_SMCabinet
where Cabinet_ID=@CabinetID
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_RUSIO_Export]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_RUSIO_Export]      
      @ProjectID UNIQUEIDENTIFIER    
AS     
    BEGIN    
  
                select SM.ID,SM.Cabinet_ID,SM.Module_ID,PWR.PowerDrawType,SM.Description,SM.Unit_Heat_Dessipation,SM.No_Of_Modules,SM.No_Of_Config_Channel  
    ,SM.[Load],   Custom, Redundant,
    Case when SM.Module_Name='' then (select Module_Name from Tbl_PHT_RUSIO_SM where Module_ID =SM.Module_ID and Module_Name<> '')   
    Else SM.Module_Name End as Module_Name ,  
      
    config.CabinetName from Tbl_PHT_RUSIO_SM SM  
    inner join Tbl_PHT_Cabinet_Module T1 on T1.CabinetModuleID=sm.Module_ID  
    inner join Tbl_PHT_Cabinet_Configuration config on SM.Cabinet_Id =config.CabinetID 
    inner join Tbl_PHT_Power_Draw_Type PWR on PWR.PowerDrawTypeID=T1.PowerDrawTypeID   
    where config.ProjectID=@ProjectID
      
    UNION  
         select SM.ID,SM.Cabinet_ID,SM.Module_ID,PWR.PowerDrawType,SM.Description,SM.Unit_Heat_Dessipation,SM.No_Of_Modules,SM.No_Of_Config_Channel  
    ,SM.[Load],   Custom, Redundant,
    Case when SM.Module_Name='' then (select Module_Name from Tbl_PHT_RUSIO_SM where Module_ID =SM.Module_ID and Module_Name<> '')   
    Else SM.Module_Name End as Module_Name ,  
      
    config.CabinetName from Tbl_PHT_RUSIO_SM SM   
    inner join Tbl_PHT_SMCabinet_Module T2 on T2.CabinetModuleID=sm.Module_ID  
    inner join Tbl_PHT_Cabinet_Configuration config on SM.Cabinet_Id =config.CabinetID   
    inner join Tbl_PHT_Power_Draw_Type PWR on PWR.PowerDrawTypeID=T2.PowerDrawTypeID   
    where config.ProjectID=@ProjectID order by SM.ID asc
      
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FETCH_RUSIO]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_FETCH_RUSIO]
@ModuleId	uniqueidentifier,
 @CabinetID uniqueIdentifier
AS

Select * from dbo.Tbl_PHT_RUSIO_SM WHERE Module_ID=@ModuleId and Cabinet_Id=@CabinetID
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Powersupply_SMCabinet]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[SP_PHT_Fetch_Powersupply_SMCabinet]
@Cabinet_ID uniqueidentifier
AS
Begin
	select * from Tbl_PHT_PowerSupply_SMCabinet where Cabinet_ID=@Cabinet_ID
End
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_PowerSupply_Export]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Fetch_PowerSupply_Export]        
      @ProjectID UNIQUEIDENTIFIER      
AS       
    BEGIN      
       select p.Cabinet_ID , s.HoneywellModel ,p.PowerSupply_Type, p.Efficiency,p.MaxRatePower,p.IsRedundant from Tbl_PHT_PowerSupply_SMCabinet p     
       Left join Tbl_PHT_ModuleDef s  on p.ModelID = s.ModelID where Cabinet_ID in ( select CabinetID from Tbl_PHT_Cabinet_Configuration where ProjectID = @ProjectID)     
      
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_ExistingCabinetMod]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_ExistingCabinetMod]  --'7c751077-1a24-4750-bbbc-7ffd86a38bd8'
    @ProjectID UNIQUEIDENTIFIER  
AS   
    BEGIN  
        SET NOCOUNT ON   
    
      
       
        select Tbl_PHT_Cabinet_Configuration.CabinetID, Tbl_PHT_Cabinet_Configuration.CabinetName, Tbl_PHT_ModuleDef.HoneywellModel,   
                      Tbl_PHT_Power_Draw_Type.PowerDrawType,Tbl_PHT_Cabinet_Configuration.Area,Tbl_PHT_Cabinet_Configuration.Location,
                      Tbl_PHT_Cabinet_Configuration.CabinetDesc  as Description,case when Tbl_PHT_Cabinet_Module.OpCalc_A is null then Tbl_PHT_SMCabinet_Module.IDC_Pri else Tbl_PHT_Cabinet_Module.OpCalc_A end as OpCalc_A,isnull(Tbl_PHT_SMCabinet_Module.VDC_Type,0) as VDC_Type,0 as PS_Type,Tbl_PHT_Cabinet_Module.ModelDescription,Tbl_PHT_SMCabinet_Module.GroupID,isnull(Tbl_PHT_SMCabinet_Module.Quantity,0) as Quantity,Tbl_PHT_SMCabinet_Module.CabinetModuleID
                      ,case when Tbl_PHT_Cabinet_Configuration.PSUPSFeeder=0 then 'Redundant' else 'Non Redundant' end as UPSFeeder from Tbl_PHT_Cabinet_Configuration left outer JOIN  
                      Tbl_PHT_Cabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_Cabinet_Module.CabinetID left outer JOIN  
                      Tbl_PHT_SMCabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID left outer JOIN  
                      Tbl_PHT_ModuleDef ON (Tbl_PHT_SMCabinet_Module.ModelID = Tbl_PHT_ModuleDef.ModelID or Tbl_PHT_Cabinet_Module.ModelID = Tbl_PHT_ModuleDef.ModelID) left outer JOIN  
                      Tbl_PHT_Power_Draw_Type ON (Tbl_PHT_SMCabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID or Tbl_PHT_Cabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID) 
                      WHERE    Tbl_PHT_Cabinet_Configuration.ProjectID = @ProjectID and Tbl_PHT_Power_Draw_Type.PowerDrawType<>'Power Supply'
                      union all 
                      
        select Tbl_PHT_Cabinet_Configuration.CabinetID, Tbl_PHT_Cabinet_Configuration.CabinetName, Tbl_PHT_PowerSupply_ModuleDef.HoneywellModel,   
                      Tbl_PHT_Power_Draw_Type.PowerDrawType,Tbl_PHT_Cabinet_Configuration.Area,Tbl_PHT_Cabinet_Configuration.Location,
                      Tbl_PHT_Cabinet_Configuration.CabinetDesc  as Description,case when Tbl_PHT_Cabinet_Module.OpCalc_A is null then Tbl_PHT_SMCabinet_Module.IDC_Pri else Tbl_PHT_Cabinet_Module.OpCalc_A end as OpCalc_A,isnull(Tbl_PHT_SMCabinet_Module.VDC_Type,0) as VDC_Type,case when Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage='24VDC' then 
24 when Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage='48VDC' then 48 when Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage='60VDC' then 60 when Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage='110VDC' then 110 else 0 end as PS_Type,Tbl_PHT_Cabinet_Module.ModelDescription,Tbl_PHT_SMCabinet_Module.GroupID,isnull(Tbl_PHT_SMCabinet_Module.Quantity,0) as Quantity,Tbl_PHT_SMCabinet_Module.CabinetModuleID
,case when Tbl_PHT_Cabinet_Configuration.PSUPSFeeder=0 then 'Redundant' else 'Non Redundant' end as UPSFeeder from Tbl_PHT_Cabinet_Configuration left outer JOIN  
                      Tbl_PHT_Cabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_Cabinet_Module.CabinetID left outer JOIN  
                      Tbl_PHT_SMCabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID left outer JOIN  
                      Tbl_PHT_PowerSupply_ModuleDef ON (Tbl_PHT_SMCabinet_Module.ModelID = Tbl_PHT_PowerSupply_ModuleDef.ModelID or Tbl_PHT_Cabinet_Module.ModelID = Tbl_PHT_PowerSupply_ModuleDef.ModelID) left outer JOIN  
                      Tbl_PHT_Power_Draw_Type ON (Tbl_PHT_SMCabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID or Tbl_PHT_Cabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID) 
                      WHERE    Tbl_PHT_Cabinet_Configuration.ProjectID = @ProjectID and Tbl_PHT_Power_Draw_Type.PowerDrawType='Power Supply' --and Tbl_PHT_PowerSupply_ModuleDef.HoneywellModel is not null
      
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_ExcelExistingUIORUSIOMod]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_ExcelExistingUIORUSIOMod]  --'8862e41f-c740-4cca-9bbf-964385feff37'
    @ProjectID UNIQUEIDENTIFIER
    
AS   
    BEGIN  
        SET NOCOUNT ON   
      
       
       select Tbl_PHT_Project.ProjectName, Tbl_PHT_Cabinet_Configuration.CabinetName,Tbl_PHT_ModuleDef.HoneywellModel as ModelName, Tbl_PHT_SMCabinet_Module.ModelDescription  as Description,
       Tbl_PHT_RUSIO_SM.Description as ChannelType,cast(Tbl_PHT_RUSIO_SM.Redundant as nvarchar(10)) as Redundant,
       cast(Tbl_PHT_RUSIO_SM.No_Of_Config_Channel as nvarchar(100)) as ChannelNumber,cast(Tbl_PHT_RUSIO_SM.Unit_Heat_Dessipation as nvarchar(100)) as UnitHeatDissipation,
       cast(Tbl_PHT_RUSIO_SM.Load as nvarchar(100)) as Load,Tbl_PHT_Power_Draw_Type.PowerDrawType as PowerDrawType,
       --cast(DENSE_RANK() OVER(ORDER BY Tbl_PHT_RUSIO_SM.Module_ID) as int) AS ID
       0 as ID,cast('true' as bit) as Existcab,Tbl_PHT_RUSIO_SM.Module_ID as CabinetModuleID
                      from Tbl_PHT_Cabinet_Configuration inner JOIN
					Tbl_PHT_SMCabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID inner JOIN  
					Tbl_PHT_RUSIO_SM ON Tbl_PHT_RUSIO_SM.Module_ID = Tbl_PHT_SMCabinet_Module.CabinetModuleID inner JOIN  
                      Tbl_PHT_ModuleDef ON (Tbl_PHT_SMCabinet_Module.ModelID = Tbl_PHT_ModuleDef.ModelID ) inner JOIN 
                      Tbl_PHT_Power_Draw_Type ON (Tbl_PHT_SMCabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID ) 
                      inner JOIN Tbl_PHT_Project on Tbl_PHT_Project.ProjectID=Tbl_PHT_Cabinet_Configuration.ProjectID                      
                      WHERE    Tbl_PHT_Cabinet_Configuration.ProjectID = @ProjectID and  Tbl_PHT_SMCabinet_Module.Is_RUISO=1 --and Tbl_PHT_Cabinet_Configuration.CabinetTypeID=1
     
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_ExcelExistingCabinetMod]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_ExcelExistingCabinetMod] --'515EE1B1-0059-422E-A300-F8E9F4DD044E'
    @ProjectID UNIQUEIDENTIFIER  
AS   
    BEGIN  
        SET NOCOUNT ON   
    
      
       
       select Tbl_PHT_Project.ProjectName, Tbl_PHT_Cabinet_Configuration.CabinetName,Tbl_PHT_Cabinet_Type.CabinetTypeName as CabinetType,Tbl_PHT_Cabinet_Configuration.CabinetDesc  as CabinetDescription,Tbl_PHT_Cabinet_Configuration.Area,Tbl_PHT_Cabinet_Configuration.Location,case when Tbl_PHT_SMCabinet_Module.Is_Redundant=0 then 'Redundant' else 'Non Redundant' end as UPSFeeder,'' as FeederType,Tbl_PHT_Power_Draw_Type.PowerDrawType as Powerdrawtype, Tbl_PHT_ModuleDef.HoneywellModel,Tbl_PHT_SMCabinet_Module.ModelDescription,   
                  case when Tbl_PHT_SMCabinet_Module.VDC_Type=24 then 
'24VDC' when Tbl_PHT_SMCabinet_Module.VDC_Type=48 then '48VDC' when Tbl_PHT_SMCabinet_Module.VDC_Type=60 then '60VDC' when Tbl_PHT_SMCabinet_Module.VDC_Type=110 then '110VDC' else '0' end as PS_Type,
                      --cast(isnull(Tbl_PHT_SMCabinet_Module.VDC_Type,0) as nvarchar(100)) as PS_Type,
                      cast(isnull(Tbl_PHT_PowerSupply_SMCabinet.Efficiency,0) as nvarchar(100)) as PS_Efficiency,cast(isnull(Tbl_PHT_SMCabinet_Module.Quantity,0) as nvarchar(100)) as Quantity,'' as Heatdissipation,tbl_PHT_Groups.Group_Name as GroupName ,isnull(cast(Tbl_PHT_SMCabinet_Module.[Load] as nvarchar(100)),'0') as Load,cast(Tbl_PHT_SMCabinet_Module.Devices_onBoards as nvarchar(100)) as Noofdevice,cast(Tbl_PHT_PowerSupply_SMCabinet.MaxRatePower as nvarchar(100)) as MaxRatePower,'0' as UseIn_HeatCalc,Tbl_PHT_SMCabinet_Module.CabinetModuleID,cast('true' as bit) as Existcab from Tbl_PHT_Cabinet_Configuration left outer JOIN  
					Tbl_PHT_SMCabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID inner JOIN  
                      Tbl_PHT_ModuleDef ON (Tbl_PHT_SMCabinet_Module.ModelID = Tbl_PHT_ModuleDef.ModelID ) left outer JOIN  
					Tbl_PHT_PowerSupply_SMCabinet ON (Tbl_PHT_PowerSupply_SMCabinet.ModelID = Tbl_PHT_SMCabinet_Module.ModelID and Tbl_PHT_PowerSupply_SMCabinet.Cabinet_ID = Tbl_PHT_SMCabinet_Module.CabinetID) left outer JOIN
                      Tbl_PHT_Power_Draw_Type ON (Tbl_PHT_SMCabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID ) 
                      left outer join Tbl_PHT_Project on Tbl_PHT_Project.ProjectID=Tbl_PHT_Cabinet_Configuration.ProjectID
                      left outer join tbl_PHT_Groups on tbl_PHT_Groups.ID=Tbl_PHT_SMCabinet_Module.GroupID
                      left outer join Tbl_PHT_Cabinet_Type on Tbl_PHT_Cabinet_Type.CabinetTypeID=Tbl_PHT_Cabinet_Configuration.CabinetTypeID
                      WHERE    Tbl_PHT_Cabinet_Configuration.ProjectID = @ProjectID and Tbl_PHT_Power_Draw_Type.PowerDrawType<>'Power Supply'
                      union all 
                      
                      
                      select Tbl_PHT_Project.ProjectName, Tbl_PHT_Cabinet_Configuration.CabinetName,Tbl_PHT_Cabinet_Type.CabinetTypeName as CabinetType,Tbl_PHT_Cabinet_Configuration.CabinetDesc  as CabinetDescription,Tbl_PHT_Cabinet_Configuration.Area,Tbl_PHT_Cabinet_Configuration.Location,case when Tbl_PHT_SMCabinet_Module.Is_Redundant=0 then 'Redundant' else 'Non Redundant' end as UPSFeeder,'' as FeederType,Tbl_PHT_Power_Draw_Type.PowerDrawType as Powerdrawtype, Tbl_PHT_PowerSupply_ModuleDef.HoneywellModel,Tbl_PHT_SMCabinet_Module.ModelDescription,   
                      cast(isnull(Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage,0) as nvarchar(100)) as PS_Type,
                      cast(isnull(Tbl_PHT_PowerSupply_SMCabinet.Efficiency,0) as nvarchar(100)) as PS_Efficiency,cast(isnull(Tbl_PHT_SMCabinet_Module.Quantity,0) as nvarchar(100)) as Quantity,'' as Heatdissipation,tbl_PHT_Groups.Group_Name as GroupName,'0' as Load,'0' as Noofdevice,cast(Tbl_PHT_PowerSupply_SMCabinet.MaxRatePower as nvarchar(100)) as MaxRatePower,'0' as UseIn_HeatCalc,Tbl_PHT_SMCabinet_Module.CabinetModuleID,cast('true' as bit) as Existcab from Tbl_PHT_Cabinet_Configuration left outer JOIN  
					Tbl_PHT_SMCabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID inner JOIN  
                      Tbl_PHT_PowerSupply_ModuleDef ON (Tbl_PHT_SMCabinet_Module.ModelID = Tbl_PHT_PowerSupply_ModuleDef.ModelID ) left outer JOIN  
					Tbl_PHT_PowerSupply_SMCabinet ON (Tbl_PHT_PowerSupply_SMCabinet.ModelID = Tbl_PHT_SMCabinet_Module.ModelID and Tbl_PHT_PowerSupply_SMCabinet.Cabinet_ID = Tbl_PHT_SMCabinet_Module.CabinetID) left outer JOIN
                      Tbl_PHT_Power_Draw_Type ON (Tbl_PHT_SMCabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID ) 
                      left outer join Tbl_PHT_Project on Tbl_PHT_Project.ProjectID=Tbl_PHT_Cabinet_Configuration.ProjectID
                      left outer join tbl_PHT_Groups on tbl_PHT_Groups.ID=Tbl_PHT_SMCabinet_Module.GroupID
                      left outer join Tbl_PHT_Cabinet_Type on Tbl_PHT_Cabinet_Type.CabinetTypeID=Tbl_PHT_Cabinet_Configuration.CabinetTypeID
                      WHERE    Tbl_PHT_Cabinet_Configuration.ProjectID = @ProjectID and Tbl_PHT_Power_Draw_Type.PowerDrawType='Power Supply'
      
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Delete_Project]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_PHT_Delete_Project]     
 -- Add the parameters for the stored procedure here    
    @ProjectId VARCHAR(1500),
     @Status BIT OUTPUT 
AS    

Begin
   set @Status=0
   if not exists (select ProjectId from Tbl_PHT_Cabinet_Configuration where ProjectID=@ProjectId)
   Begin
       delete from Tbl_PHT_Report_Revision_History where ReportSettingID in (select ReportSettingID from Tbl_PHT_Report_Setting where ProjectID=@ProjectId)
       delete from Tbl_PHT_Report_Setting where ProjectID=@ProjectId
       delete from tbl_PHT_Groups where ProjectID=@ProjectId
	   delete from Tbl_PHT_Project where ProjectID=@ProjectId
	   set @Status=1
   end
   else
    set @Status=0

End
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Fetch_Cabinet_RUSIO_Config]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Fetch_Cabinet_RUSIO_Config]
	--@ID int,
    @CabinetID UNIQUEIDENTIFIER 
  
   
AS 
    BEGIN
        SET NOCOUNT ON 			
						select * from Tbl_PHT_RUSIO_SM where Cabinet_ID=@CabinetID 
       
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Export_CabinetDetails]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Export_CabinetDetails]  
      @ProjectID UNIQUEIDENTIFIER  
AS   
    BEGIN  
     SELECT Tbl_PHT_Project.ProjectName, Tbl_PHT_Cabinet_Configuration.CabinetName, Tbl_PHT_Cabinet_Type.CabinetTypeName,   
                      Tbl_PHT_Cabinet_Configuration.CabinetDesc, Tbl_PHT_Cabinet_Configuration.Area, Tbl_PHT_Cabinet_Configuration.Location,  
                      (SELECT     HoneywellModel From Tbl_PHT_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSFront) as PSFront,(Tbl_PHT_Cabinet_Configuration.FrontEfficiency ) as FrontEfficiency,(SELECT     HoneywellModel From Tbl_PHT_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSRear) as PSRear ,(Tbl_PHT_Cabinet_Configuration.RearEfficiency) as RearEfficiency,  Tbl_PHT_Cabinet_Configuration.PSUPSFeeder,   
                      Tbl_PHT_Power_Draw_Type.PowerDrawType, Tbl_PHT_ModuleDef.HoneywellModel, Tbl_PHT_Cabinet_Module.ModelDescription, Tbl_PHT_ModuleDef.Heatdissipation, Tbl_PHT_Cabinet_Module.Quantity,   
                       
                      Tbl_PHT_Cabinet_Module.FeederType,'NA' As GroupName,0.00 as [Load],0 as nChan,Tbl_PHT_Cabinet_Configuration.CabinetID,-1 as VDC_Type, 0 as UseIn_HeatCalc,Tbl_PHT_Cabinet_Module.CabinetModuleID
                      FROM Tbl_PHT_Cabinet_Configuration INNER JOIN  
                      Tbl_PHT_Cabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_Cabinet_Module.CabinetID AND   
                      Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_Cabinet_Module.CabinetID INNER JOIN  
                      Tbl_PHT_Cabinet_Type ON Tbl_PHT_Cabinet_Configuration.CabinetTypeID = Tbl_PHT_Cabinet_Type.CabinetTypeID INNER JOIN  
                      Tbl_PHT_ModuleDef ON Tbl_PHT_Cabinet_Module.ModelID = Tbl_PHT_ModuleDef.ModelID INNER JOIN  
                      Tbl_PHT_Power_Draw_Type ON Tbl_PHT_Cabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID INNER JOIN  
                      Tbl_PHT_Project ON Tbl_PHT_Cabinet_Configuration.ProjectID = Tbl_PHT_Project.ProjectID   
                      where Tbl_PHT_Project.ProjectID = @ProjectID  and Tbl_PHT_Cabinet_Module.PowerDrawTypeID <>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' 
                      --ORDER BY Tbl_PHT_Cabinet_Configuration.CabinetName asc  
                      
                      UNION
                      SELECT Tbl_PHT_Project.ProjectName, Tbl_PHT_Cabinet_Configuration.CabinetName, Tbl_PHT_Cabinet_Type.CabinetTypeName,   
                      Tbl_PHT_Cabinet_Configuration.CabinetDesc, Tbl_PHT_Cabinet_Configuration.Area, Tbl_PHT_Cabinet_Configuration.Location,  
                      (SELECT     HoneywellModel From Tbl_PHT_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSFront) as PSFront,(Tbl_PHT_Cabinet_Configuration.FrontEfficiency ) as FrontEfficiency,(SELECT     HoneywellModel From Tbl_PHT_PowerSupply_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSRear) as PSRear ,(Tbl_PHT_Cabinet_Configuration.RearEfficiency) as RearEfficiency,  Tbl_PHT_Cabinet_Configuration.PSUPSFeeder,   
                      Tbl_PHT_Power_Draw_Type.PowerDrawType, Tbl_PHT_PowerSupply_ModuleDef.HoneywellModel, Tbl_PHT_Cabinet_Module.ModelDescription, Tbl_PHT_PowerSupply_ModuleDef.Heatdissipation, Tbl_PHT_Cabinet_Module.Quantity,   
                       
                      Tbl_PHT_Cabinet_Module.FeederType,'NA' As GroupName,0.00 as [Load],0 as nChan,Tbl_PHT_Cabinet_Configuration.CabinetID,-1 as VDC_Type, 0 as UseIn_HeatCalc,Tbl_PHT_Cabinet_Module.CabinetModuleID
                      FROM Tbl_PHT_Cabinet_Configuration INNER JOIN  
                      Tbl_PHT_Cabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_Cabinet_Module.CabinetID AND   
                      Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_Cabinet_Module.CabinetID INNER JOIN  
                      Tbl_PHT_Cabinet_Type ON Tbl_PHT_Cabinet_Configuration.CabinetTypeID = Tbl_PHT_Cabinet_Type.CabinetTypeID INNER JOIN  
                      Tbl_PHT_PowerSupply_ModuleDef ON Tbl_PHT_Cabinet_Module.ModelID = Tbl_PHT_PowerSupply_ModuleDef.ModelID INNER JOIN  
                      Tbl_PHT_Power_Draw_Type ON Tbl_PHT_Cabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID INNER JOIN  
                      Tbl_PHT_Project ON Tbl_PHT_Cabinet_Configuration.ProjectID = Tbl_PHT_Project.ProjectID   
                      where Tbl_PHT_Project.ProjectID = @ProjectID  and Tbl_PHT_Cabinet_Module.PowerDrawTypeID ='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'    
                      --ORDER BY Tbl_PHT_Cabinet_Configuration.CabinetName asc  
                      
                      UNION
                      
                          SELECT     Tbl_PHT_Project.ProjectName, Tbl_PHT_Cabinet_Configuration.CabinetName, Tbl_PHT_Cabinet_Type.CabinetTypeName,   
                      Tbl_PHT_Cabinet_Configuration.CabinetDesc, Tbl_PHT_Cabinet_Configuration.Area, Tbl_PHT_Cabinet_Configuration.Location,  
                      (SELECT     HoneywellModel From Tbl_PHT_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSFront) as PSFront,(Tbl_PHT_Cabinet_Configuration.FrontEfficiency) as FrontEfficiency,(SELECT HoneywellModel From Tbl_PHT_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSRear) as PSRear ,(Tbl_PHT_Cabinet_Configuration.RearEfficiency) as RearEfficiency,  Tbl_PHT_Cabinet_Configuration.PSUPSFeeder,   
                      Tbl_PHT_Power_Draw_Type.PowerDrawType, Tbl_PHT_ModuleDef.HoneywellModel,Tbl_PHT_SMCabinet_Module.ModelDescription, Tbl_PHT_ModuleDef.Heatdissipation, Tbl_PHT_SMCabinet_Module.Quantity,   
                     Tbl_PHT_SMCabinet_Module.Is_Redundant,tbl_PHT_Groups.Group_Name As GroupName,Tbl_PHT_SMCabinet_Module.[Load] as [Load],Tbl_PHT_SMCabinet_Module.Devices_OnBoards as nChan,Tbl_PHT_Cabinet_Configuration.CabinetID,Tbl_PHT_SMCabinet_Module.VDC_Type as VDC_Type, Tbl_PHT_SMCabinet_Module.UseIn_HeatCalc,Tbl_PHT_SMCabinet_Module.CabinetModuleID
                      
                      FROM Tbl_PHT_Cabinet_Configuration INNER JOIN  
                      Tbl_PHT_SMCabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID AND   
                      Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID INNER JOIN  
                      tbl_PHT_Groups ON Tbl_PHT_SMCabinet_Module.GroupID = tbl_PHT_Groups.ID  INNER JOIN 
                      Tbl_PHT_Cabinet_Type ON Tbl_PHT_Cabinet_Configuration.CabinetTypeID = Tbl_PHT_Cabinet_Type.CabinetTypeID INNER JOIN  
                      Tbl_PHT_ModuleDef ON Tbl_PHT_SMCabinet_Module.ModelID = Tbl_PHT_ModuleDef.ModelID INNER JOIN  
                      Tbl_PHT_Power_Draw_Type ON Tbl_PHT_SMCabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID INNER JOIN   
                      Tbl_PHT_Project ON Tbl_PHT_Cabinet_Configuration.ProjectID = Tbl_PHT_Project.ProjectID   
                      where Tbl_PHT_Project.ProjectID = @ProjectID  and Tbl_PHT_SMCabinet_Module.PowerDrawTypeID <>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
                      
                      Union
                      
                                  SELECT     Tbl_PHT_Project.ProjectName, Tbl_PHT_Cabinet_Configuration.CabinetName, Tbl_PHT_Cabinet_Type.CabinetTypeName,     
                      Tbl_PHT_Cabinet_Configuration.CabinetDesc, Tbl_PHT_Cabinet_Configuration.Area, Tbl_PHT_Cabinet_Configuration.Location,    
                      (SELECT     HoneywellModel From Tbl_PHT_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSFront) as PSFront,(Tbl_PHT_Cabinet_Configuration.FrontEfficiency) as FrontEfficiency, (SELECT HoneywellModel From Tbl_PHT_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSRear) as PSRear ,(Tbl_PHT_Cabinet_Configuration.RearEfficiency) as RearEfficiency, Tbl_PHT_Cabinet_Configuration.PSUPSFeeder,     
                      Tbl_PHT_Power_Draw_Type.PowerDrawType, Tbl_PHT_ModuleDef.HoneywellModel,Tbl_PHT_SMCabinet_Module.ModelDescription, Tbl_PHT_ModuleDef.Heatdissipation, Tbl_PHT_SMCabinet_Module.Quantity,     
                     Tbl_PHT_SMCabinet_Module.Is_Redundant,'' As GroupName,Tbl_PHT_SMCabinet_Module.[Load] as [Load],0 as nChan,Tbl_PHT_Cabinet_Configuration.CabinetID,Tbl_PHT_SMCabinet_Module.VDC_Type as VDC_Type, Tbl_PHT_SMCabinet_Module.UseIn_HeatCalc,Tbl_PHT_SMCabinet_Module.CabinetModuleID  
                        
                      FROM Tbl_PHT_Cabinet_Configuration INNER JOIN    
                      Tbl_PHT_SMCabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID AND     
                      Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID INNER JOIN    
                      --tbl_PHT_Groups ON Tbl_PHT_SMCabinet_Module.GroupID = tbl_PHT_Groups.ID  INNER JOIN   
                      Tbl_PHT_Cabinet_Type ON Tbl_PHT_Cabinet_Configuration.CabinetTypeID = Tbl_PHT_Cabinet_Type.CabinetTypeID INNER JOIN    
                      Tbl_PHT_ModuleDef ON Tbl_PHT_SMCabinet_Module.ModelID = Tbl_PHT_ModuleDef.ModelID INNER JOIN    
                      Tbl_PHT_Power_Draw_Type ON Tbl_PHT_SMCabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID INNER JOIN     
                      Tbl_PHT_Project ON Tbl_PHT_Cabinet_Configuration.ProjectID = Tbl_PHT_Project.ProjectID     
                      where Tbl_PHT_Project.ProjectID = @ProjectID and Tbl_PHT_Power_Draw_Type.PowerDrawType ='Utility / Service-Power Draw' and Tbl_PHT_SMCabinet_Module.PowerDrawTypeID <>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' 
                      
                     
                      
                      
                      --Added by Shyamala for FR10
                      Union
                      
 SELECT     Tbl_PHT_Project.ProjectName, Tbl_PHT_Cabinet_Configuration.CabinetName, Tbl_PHT_Cabinet_Type.CabinetTypeName,     
                      Tbl_PHT_Cabinet_Configuration.CabinetDesc, Tbl_PHT_Cabinet_Configuration.Area, Tbl_PHT_Cabinet_Configuration.Location,    
                      (SELECT     HoneywellModel From Tbl_PHT_PowerSupply_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSFront) as PSFront,(Tbl_PHT_Cabinet_Configuration.FrontEfficiency) as FrontEfficiency, (SELECT HoneywellModel From Tbl_PHT_PowerSupply_ModuleDef where modelid = Tbl_PHT_Cabinet_Configuration.PSRear) as PSRear ,(Tbl_PHT_Cabinet_Configuration.RearEfficiency) as RearEfficiency, Tbl_PHT_Cabinet_Configuration.PSUPSFeeder,     
                      Tbl_PHT_Power_Draw_Type.PowerDrawType, Tbl_PHT_PowerSupply_ModuleDef.HoneywellModel,Tbl_PHT_SMCabinet_Module.ModelDescription, Tbl_PHT_PowerSupply_ModuleDef.Heatdissipation, Tbl_PHT_SMCabinet_Module.Quantity,     
                     Tbl_PHT_SMCabinet_Module.Is_Redundant,'' As GroupName,Tbl_PHT_SMCabinet_Module.[Load] as [Load],Tbl_PHT_SMCabinet_Module.Devices_OnBoards as nChan,Tbl_PHT_Cabinet_Configuration.CabinetID,case when Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage='24VDC' then 24 when Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage='48VDC' then 48 when Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage='60VDC' then 60 when Tbl_PHT_PowerSupply_ModuleDef.OutputVoltage='110VDC' then 110 end as VDC_Type, Tbl_PHT_SMCabinet_Module.UseIn_HeatCalc,Tbl_PHT_SMCabinet_Module.CabinetModuleID  
                        
                      FROM Tbl_PHT_Cabinet_Configuration INNER JOIN    
                      Tbl_PHT_SMCabinet_Module ON Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID AND     
                      Tbl_PHT_Cabinet_Configuration.CabinetID = Tbl_PHT_SMCabinet_Module.CabinetID INNER JOIN    
                      --tbl_PHT_Groups ON Tbl_PHT_SMCabinet_Module.GroupID = tbl_PHT_Groups.ID  INNER JOIN   
                      Tbl_PHT_Cabinet_Type ON Tbl_PHT_Cabinet_Configuration.CabinetTypeID = Tbl_PHT_Cabinet_Type.CabinetTypeID INNER JOIN    
                      Tbl_PHT_PowerSupply_ModuleDef ON Tbl_PHT_SMCabinet_Module.ModelID = Tbl_PHT_PowerSupply_ModuleDef.ModelID INNER JOIN    
                      Tbl_PHT_Power_Draw_Type ON Tbl_PHT_SMCabinet_Module.PowerDrawTypeID = Tbl_PHT_Power_Draw_Type.PowerDrawTypeID INNER JOIN     
                      Tbl_PHT_Project ON Tbl_PHT_Cabinet_Configuration.ProjectID = Tbl_PHT_Project.ProjectID     
                      where Tbl_PHT_Project.ProjectID =@ProjectID   and Tbl_PHT_Power_Draw_Type.PowerDrawType ='Power Supply'
                      
                      ORDER BY Tbl_PHT_Cabinet_Configuration.CabinetName asc 
                     
                       
  END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_ExecuteAdvanceSettingsForProject]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_ExecuteAdvanceSettingsForProject]  
 @ProjID uniqueidentifier,  
@AmbientTemp decimal(10, 2) = NULL  
AS  
BEGIN  
  -- SET NOCOUNT ON added to prevent extra result sets from                    
  -- interfering with SELECT statements.                    
  SET NOCOUNT ON;  
  
  -- Insert statements for procedure here                    
  
  DECLARE @iconfig int = 1,  
          @countconfig int,  
          @imodule int = 1,  
          @countmodule int  
  
  DECLARE @N int  
  DECLARE @J decimal(10, 5)  
  DECLARE @QK decimal(10, 5)  
  DECLARE @PF decimal(10, 5)  
  DECLARE @L decimal(10, 5)  
  DECLARE @O decimal(10, 5)  
  DECLARE @ISBTU_HR bit  
  
  --ADDED BY SHYMALA FOR FR10             
  DECLARE @MODULEGRP varchar(100)  
  DECLARE @PowerDrawType varchar(150)  
  DECLARE @PSFRONT int  
  DECLARE @PSREAR int  
    DECLARE @ConfigType varchar(10)  
       DECLARE @WATTSCONVERSION  DECIMAL(18,10)                 
         DECLARE @REARWATTSCONVERSION DECIMAL(18,10)           
         DECLARE @BTUHR DECIMAL(18,10)               
         DECLARE @KCALHR DECIMAL(18,10)             
         DECLARE @TOTALPOWER DECIMAL(18,10)               
         DECLARE @TOTALWATTS DECIMAL(18,10)                 
         DECLARE @TOTALHEATDISSIPATION DECIMAL(18,10)            
                          
          DECLARE @TOTALREARPOWER DECIMAL(18,10)              
          DECLARE @TOTALREARWATTS DECIMAL(18,10)              
          DECLARE @TOTALREARHEATDISSIPATION DECIMAL(18,10)   
  
  DECLARE @FRONTDESCTEXT nvarchar(50)  
  DECLARE @REARDESCTEXT nvarchar(50)  
  
  DECLARE @FRONTDESC nvarchar(512)  
  DECLARE @REARDESC nvarchar(512)  
  
  SET @BTUHR = 3.413  
  SET @KCALHR = 3.968  
  
  SET @FRONTDESCTEXT = '- Front PS'  
  SET @REARDESCTEXT = '- Rear PS'  
  --ENDS HERE            
  --ADDED BY SHYAMALA FOR P&H_FR25      
  DECLARE @POWERSUPPLYDCVOLTAGE int  
  DECLARE @COMPEFFQUOTIENT decimal(16, 10)  
  
  SET @POWERSUPPLYDCVOLTAGE = 24  
  SET @COMPEFFQUOTIENT = 0.1875  
  --ENDS HERE            
  DECLARE @M decimal(10, 5)  
  SET @M = 24  
  
  SELECT  
    @N = TBL_PRJ.InputVoltage,  
    @J = TBL_RPT_SET.AdvPowerSupplyEff,  
    @PF = TBL_RPT_SET.AdvPowerFactor,  
    @L = TBL_RPT_SET.AdvInrushCurrent,  
    @QK = (CASE  
      WHEN TBL_RPT_SET.AdvIsPowerFactor = 0 THEN 1  
      ELSE TBL_RPT_SET.AdvPowerFactor  
    END),  
    @ISBTU_HR = TBL_RPT_SET.AdvPowerHeatUnit  
  FROM TBL_PHT_PROJECT TBL_PRJ,  
       Tbl_PHT_Report_Setting TBL_RPT_SET,  
       (SELECT ProjectID FROM Tbl_PHT_Cabinet_Configuration  UNION SELECT ProjectID FROM Tbl_PHT_MiscComponents_Configuration) TBL_CAB  
  WHERE TBL_PRJ.ProjectID = TBL_RPT_SET.ProjectID  
  AND TBL_PRJ.ProjectID = TBL_CAB.ProjectID  
  AND TBL_PRJ.ProjectID = @ProjID  
  
  DECLARE @val_CabinetID uniqueidentifier,  
          @val_CabinetName nvarchar(256),  
          @val_CabinetModuleID uniqueidentifier,  
          @val_ModelID int,  
          @P int,  
          @val_IsUIO bit,  
          @val_AI_C int,  
          @val_AO_C int,  
          @val_DI_C int,  
          @val_DO_C int,  
          @val_IOTA_C int,  
          @val_AI_H decimal(10, 2),  
          @val_AO_H decimal(10, 2),  
          @val_DI_H decimal(10, 2),  
          @val_DO_H decimal(10, 2),  
          @val_IOTA_H decimal(10, 2),  
          @val_IsAC bit  ,
		  @FrontEfficiency decimal(18,4),
		  @RearEfficiency decimal(18,4)
  
  DECLARE @A decimal(18, 10),  
          @B decimal(18, 10),  
          @C decimal(18, 10),  
          @D decimal(18, 10),  
          @E decimal(18, 10),  
          @F decimal(18, 10),  
          @G decimal(18, 10),  
          @H decimal(18, 10),  
          @I decimal(18, 10)  
  --Added efficiency by ram prasath for efficiency calculation to front and rear
  DECLARE @TEMP_CabinetConfig TABLE (  
    SNo int IDENTITY (1, 1),  
    [CabinetID] uniqueidentifier NOT NULL,  
    [CabinetName] nvarchar(256) NULL,  
    [PSFront] int NULL,  
    [PSRear] int NULL,  
 ConfigType nvarchar(10) NULL  
 , FrontEfficiency decimal(18,2)
 ,RearEfficiency decimal(18,2)
  )  
  --Added efficiency by ram prasath for efficiency calculation to front and rear
  INSERT INTO @TEMP_CabinetConfig  
    SELECT  
      [CabinetID],  
      [CabinetName],  
      [PSFront],  
      [PSRear],'Cab' as ConfigType
      ,FrontEfficiency
        ,RearEfficiency
    FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Configuration]  
    WHERE ProjectID = @ProjID  
    AND CabinetTypeID <= 4 union select [CompID],  
      [Name],  
      0 as [PSFront],  
      0 as [PSRear],'Misc' as ConfigType
      ,0 as FrontEfficiency 
      ,0 as RearEfficiency
      from Tbl_PHT_MiscComponents_Configuration WHERE ProjectID= @ProjID  
  
  SELECT  
    @countconfig = COUNT([CabinetID])  
  FROM @TEMP_CabinetConfig  
  
  WHILE (@iconfig <= @countconfig)  
  BEGIN  
  
    SET @TOTALPOWER = 0.0  
    SET @TOTALWATTS = 0.0  
    SET @TOTALHEATDISSIPATION = 0.0  
    SET @TOTALREARPOWER = 0.0  
    SET @TOTALREARWATTS = 0.0  
    SET @TOTALREARHEATDISSIPATION = 0.0  
    SET @WATTSCONVERSION = 0.0  
    SET @REARWATTSCONVERSION = 0.0  
  --Added efficiency by ram prasath for efficiency calculation to front and rear
    SELECT  
      @val_CabinetID = [CabinetID],  
      @val_CabinetName = [CabinetName],  
      @PSFRONT = [PSFront],  
      @PSREAR = [PSRear],  
  @ConfigType= [ConfigType]  
  ,  @FrontEfficiency=FrontEfficiency/100
  ,  @RearEfficiency=RearEfficiency/100
    FROM @TEMP_CabinetConfig  
    WHERE SNo = @iconfig  
  print @FrontEfficiency
    DECLARE @TEMP_CabinetModule TABLE (  
      SNo int IDENTITY (1, 1),  
      [CabinetModuleID] uniqueidentifier NOT NULL,  
      [ModelID] int NOT NULL,  
      [Quantity] int NOT NULL,  
      [IsUIO] bit,  
      [AI_UIO_ChannelCount] int,  
      [AO_UIO_ChannelCount] int,  
      [DI_UIO_ChannelCount] int,  
      [DO_UIO_ChannelCount] int,  
      [IOTA_UIO_ChannelCount] int,  
      [PowerDrawType] varchar(150) NOT NULL  
    )  
  
    INSERT INTO @TEMP_CabinetModule  
      SELECT  
        [CabinetModuleID],  
        [ModelID],  
        [Quantity],  
        [IsUIO],  
        [AI_UIO_ChannelCount],  
        [AO_UIO_ChannelCount],  
        [DI_UIO_ChannelCount],  
        [DO_UIO_ChannelCount],  
        [IOTA_UIO_ChannelCount],  
        PDT.PowerDrawType  
      FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Module] CM  
      INNER JOIN dbo.Tbl_PHT_Power_Draw_Type PDT  
        ON CM.[PowerDrawTypeID] = PDT.[PowerDrawTypeID]  
      WHERE CabinetID = @val_CabinetID union   
       SELECT  
        [CabinetModuleID],  
        [ModelID],  
        [Quantity],  
        [IsUIO],  
        [AI_UIO_ChannelCount],  
        [AO_UIO_ChannelCount],  
        [DI_UIO_ChannelCount],  
        [DO_UIO_ChannelCount],  
        [IOTA_UIO_ChannelCount],  
        'Miscellaneous Components' as PowerDrawType  
      FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Miscelleneous_Module]      
        WHERE CompID=@val_CabinetID  
  
    SELECT  
      @countmodule = COUNT([CabinetModuleID])  
    FROM @TEMP_CabinetModule  
  
    WHILE (@imodule <= @countmodule)  
    BEGIN  
  
      SELECT  
        @val_CabinetModuleID = [CabinetModuleID],  
        @val_ModelID = [ModelID],  
        @P = [Quantity],  
        @val_IsUIO = [IsUIO],  
        @val_AI_C = [AI_UIO_ChannelCount],  
        @val_AO_C = [AO_UIO_ChannelCount],  
        @val_DI_C = [DI_UIO_ChannelCount],  
        @val_DO_C = [DO_UIO_ChannelCount],  
        @val_IOTA_C = [IOTA_UIO_ChannelCount],  
        @PowerDrawType = PowerDrawType  
      FROM @TEMP_CabinetModule  
      WHERE SNo = @imodule  
      --Added by ram prasath for efficiency calculation to front and rear
	  if(@PowerDrawType='24VDC PS(Front Side)-Power Draw')
	  begin
  set @J=@FrontEfficiency
  end
  if(@PowerDrawType='24VDC PS(Rear Side)-Power Draw')
	  begin
  set @J=@RearEfficiency
  end
  if exists(SELECT * FROM [PowerHeatCalc].[dbo].[Tbl_PHT_ModuleDef]  
      WHERE ModelID = @val_ModelID )
      begin
      SELECT  
        @O = [Heatdissipation],  
        @val_AO_H = [AO_Heatdissipation],  
        @val_AI_H = [AI_Heatdissipation],  
        @val_DI_H = [DI_Heatdissipation],  
        @val_DO_H = [DO_Heatdissipation],  
        @val_IOTA_H = [IOTA_Heatdissipation],  
        @val_IsAC = [IS_AC_COMPONENT],  
        @MODULEGRP = [Module_Group]  
      FROM [PowerHeatCalc].[dbo].[Tbl_PHT_ModuleDef]  
      WHERE ModelID = @val_ModelID  
  end
  else
  begin
   SELECT  
        @O = [Heatdissipation],  
        @val_AO_H = 0,  
        @val_AI_H = 0,  
        @val_DI_H = 0,  
        @val_DO_H = 0,  
        @val_IOTA_H = 0,  
        @val_IsAC = [IS_AC_COMPONENT],  
        @MODULEGRP = [Module_Group]  
      FROM [PowerHeatCalc].[dbo].[Tbl_PHT_PowerSupply_ModuleDef]  
      WHERE ModelID = @val_ModelID  
  end

      IF @val_IsUIO = 1  
      BEGIN  
        -- SET @O = @val_AI_C * @val_AI_H + @val_AO_C * @val_AO_H + @val_DI_C * @val_DI_H+ @val_DO_C * @val_DO_H+ @val_IOTA_C * @val_IOTA_H                    
       SELECT  
          @O = Total_Heat_Dessipation  
        FROM Tbl_PHT_RUSIO_SM  
        WHERE Module_ID = @val_CabinetModuleID  
        AND Module_Name <> ''  
      END  
  
      --print ' O ' + convert(varchar(10),@O)                  
  
  
      IF @val_IsUIO = 1  
      BEGIN  
        SET @A = (@O / @M);  
      END  
      ELSE  
      BEGIN  
        SET @A = (@O / @M) * @P;  
      END  
      --SET @A = round(@A,3);                       
  
  
  
      SET @B = ((@A * @M) / (@N * @J * @QK));  
      --print ' B1 ' + convert(varchar(10),@B)                                               
      SET @B = @B + (@B * @L);  
      -- print ' B2 ' + convert(varchar(10),@B)                         
  
      -- SET @B = round(@B,3);                    
  
  
  
      SET @C = (@O / @N) * @P;  
      -- SET @C = round(@C,3);                    
      SET @D = (@O / (@N * @QK)) * @P;  
      --SET @D = round(@D,3);                    
      IF @val_IsAC = 1  
      BEGIN  
        SET @B = 0;  
        SET @C = 0;  
      END  
      ELSE  
      BEGIN  
        SET @D = 0;  
        SET @C = 0;  
      END  
      SET @E = @B + @C + @D;  
      -- SET @E = round(@E,3);                    
      --SET @F = @N * @E;                    
      -- SET @F = round(@F,3);                   
      --print 'A ' +  convert(varchar(50),@A)                  
      --print 'B ' +  convert(varchar(10),@B)                   
      -- print 'N ' +  convert(varchar(10),@N)                  
      -- print 'E ' +  convert(varchar(10),@E)                  
      --print 'QK ' +  convert(varchar(10),@QK)                  
  
      --SET @G = @N * @E * @QK * 3.413;                     
      IF @val_IsUIO = 1  
        SET @G = @O * 3.413;  
      --ELSE                
      --SET @G = @N * @E * @QK * 3.413;                      
      --------SET @G = round(@G,3);                    
      --------SET @H = @N * @E * @QK;         
      IF (@val_IsAC = 0)  
      BEGIN  
      if @val_IsUIO = 1
      begin
      SET @H = (@O) + (@A * @POWERSUPPLYDCVOLTAGE * @COMPEFFQUOTIENT);
      end
      else
      begin
        SET @H = (@O*@P) + (@A * @POWERSUPPLYDCVOLTAGE * @COMPEFFQUOTIENT);  
        end
      END  
      ELSE  
      IF (@val_IsAC = 1)  
      BEGIN  
        SET @H = @O * @P  
      END  
      SET @G = @H * 3.413  
      ---- SET @H = round(@H,3);                    
      SET @I = @G / 3.968;  
      -- SET @I = round(@I,3);                                    
      --print ' G ' + convert(varchar(10),@G)         
  
      ---Added for P&H_FR25      
  
      IF (@val_IsAC = 1)  
      BEGIN  
  
  
        SET @F = ((@O * @P) / @QK);  
  
      END  
      ELSE  
      IF (@val_IsAC = 0)  
      BEGIN  
  
        SET @F = @N * @E;  
      END  
  
  
      --Ends here      
  
  
  
      IF @val_IsUIO = 1  
      BEGIN  
        SET @H = @O  
      END  
      IF (@PowerDrawType = '24VDC PS(Front Side)-Power Draw')  
      BEGIN  
  
        SET @TOTALPOWER = @TOTALPOWER + @A  
        SET @TOTALWATTS = @TOTALWATTS + @H  

      END  
  
      ELSE  
      IF (@PowerDrawType = '24VDC PS(Rear Side)-Power Draw')  
      BEGIN  
        SET @TOTALREARPOWER = @TOTALREARPOWER + @A  
        SET @TOTALREARWATTS = @TOTALREARWATTS + @H  
  
      END  
    
  
      IF (@MODULEGRP <> 'Power Supply'  
        AND @MODULEGRP <> 'Power Supply SM')  
      begin  
   IF(@PowerDrawType<>'Miscellaneous Components')  
   begin  
        UPDATE Tbl_PHT_Cabinet_Module  
        --             SET     [OPCalc_A] = Cast (round(@A,3) As Decimal( 16,3)),                    
        --                  [OPCalc_B] = Cast (round(@B,3) As Decimal( 16,3)),                    
        --                  [OPCalc_C] = Cast (round(@C,3) As Decimal( 16,3)),                    
        --                  [OPCalc_D] = Cast (round(@D,3) As Decimal( 16,3)),                    
        --                  [OPCalc_E] = Cast (round(@E,3) As Decimal( 16,3)),                    
        --                  [OPCalc_F] = Cast (round(@F,3) As Decimal( 16,3)),                    
        --                  [OPCalc_G] = Cast (round(@G,3) As Decimal( 16,3)),                    
        --                  --[OPCalc_H] = Cast (round(@H,3) As Decimal( 16,3)),                    
        --                  [OPCalc_H] = CASE WHEN [IsUIO]=1 THEN                 
        -- Cast (round(@O,3) As Decimal( 16,3))                    
        --ELSE                
        -- Cast (round(@H,3) As Decimal( 16,3))                
        --END,                
        --                  [OPCalc_I] = Cast (round(@I,3) As Decimal( 16,3)),                    
        --                  [OPCalc_N] = Cast (round(@N,3) As Decimal( 16,3))                
        SET [OPCalc_A] = CAST(ROUND(@A, 2) AS decimal(16, 3)),  
            [OPCalc_B] = CAST(ROUND(@B, 2) AS decimal(16, 2)),  
            [OPCalc_C] = CAST(ROUND(@C, 2) AS decimal(16, 2)),  
            [OPCalc_D] = CAST(ROUND(@D, 2) AS decimal(16, 2)),  
            [OPCalc_E] = CAST(ROUND(@E, 2) AS decimal(16, 2)),  
            [OPCalc_F] = CAST(ROUND(@F, 2) AS decimal(16, 2)),  
            [OPCalc_G] = CAST(ROUND(@G, 2) AS decimal(16, 2)),  
            --[OPCalc_H] = Cast (round(@H,3) As Decimal( 16,3)),                    
            [OPCalc_H] =  
                        CASE  
                          WHEN [IsUIO] = 1 THEN CAST(ROUND(@O, 2) AS decimal(16, 2))  
                          ELSE CAST(ROUND(@H, 2) AS decimal(16, 2))  
                        END,  
            [OPCalc_I] = CAST(ROUND(@I, 2) AS decimal(16, 2)),  
            [OPCalc_N] = CAST(ROUND(@N, 2) AS decimal(16, 2))  
        -- ,      
        --[OPCalc_VA]=    Cast (round(@VA,2) As Decimal( 16,2))                                        
        WHERE [CabinetModuleID] = @val_CabinetModuleID  
  end  
  ELSE  
  BEGIN  
  UPDATE Tbl_PHT_Miscelleneous_Module  
        --             SET     [OPCalc_A] = Cast (round(@A,3) As Decimal( 16,3)),                    
        --                  [OPCalc_B] = Cast (round(@B,3) As Decimal( 16,3)),                    
        --                  [OPCalc_C] = Cast (round(@C,3) As Decimal( 16,3)),                    
        --                  [OPCalc_D] = Cast (round(@D,3) As Decimal( 16,3)),                    
        --                  [OPCalc_E] = Cast (round(@E,3) As Decimal( 16,3)),                    
        --                  [OPCalc_F] = Cast (round(@F,3) As Decimal( 16,3)),                    
        --                  [OPCalc_G] = Cast (round(@G,3) As Decimal( 16,3)),                    
        --                  --[OPCalc_H] = Cast (round(@H,3) As Decimal( 16,3)),                    
        --                  [OPCalc_H] = CASE WHEN [IsUIO]=1 THEN                 
        -- Cast (round(@O,3) As Decimal( 16,3))                    
        --ELSE                
        -- Cast (round(@H,3) As Decimal( 16,3))                
        --END,                
        --                  [OPCalc_I] = Cast (round(@I,3) As Decimal( 16,3)),                    
        --                  [OPCalc_N] = Cast (round(@N,3) As Decimal( 16,3))                
        SET [OPCalc_A] = CAST(ROUND(@A, 2) AS decimal(16, 3)),  
            [OPCalc_B] = CAST(ROUND(@B, 2) AS decimal(16, 2)),  
            [OPCalc_C] = CAST(ROUND(@C, 2) AS decimal(16, 2)),  
            [OPCalc_D] = CAST(ROUND(@D, 2) AS decimal(16, 2)),  
            [OPCalc_E] = CAST(ROUND(@E, 2) AS decimal(16, 2)),  
            [OPCalc_F] = CAST(ROUND(@F, 2) AS decimal(16, 2)),  
            [OPCalc_G] = CAST(ROUND(@G, 2) AS decimal(16, 2)),  
            --[OPCalc_H] = Cast (round(@H,3) As Decimal( 16,3)),                    
            [OPCalc_H] =  
                        CASE  
                          WHEN [IsUIO] = 1 THEN CAST(ROUND(@O, 2) AS decimal(16, 2))  
                          ELSE CAST(ROUND(@H, 2) AS decimal(16, 2))  
                        END,  
            [OPCalc_I] = CAST(ROUND(@I, 2) AS decimal(16, 2)),  
            [OPCalc_N] = CAST(ROUND(@N, 2) AS decimal(16, 2))  
        -- ,      
        --[OPCalc_VA]=    Cast (round(@VA,2) As Decimal( 16,2))                                        
        WHERE [CabinetModuleID] = @val_CabinetModuleID  
  END  
  
    END  
        SELECT  
    @imodule = @imodule + 1  
    END  
    
  
      SET @TOTALHEATDISSIPATION = ((@TOTALWATTS / @J) - @TOTALWATTS)  
      SET @TOTALREARHEATDISSIPATION = ((@TOTALREARWATTS / @J) - @TOTALREARWATTS)  
  
      IF (@ISBTU_HR = 1)  
      BEGIN  
        SET @WATTSCONVERSION = (@TOTALHEATDISSIPATION * @BTUHR)  
        SET @REARWATTSCONVERSION = (@TOTALREARHEATDISSIPATION * @BTUHR)  
  
    
        SELECT  
          @FRONTDESC = ModelDescription  
        FROM Tbl_PHT_Cabinet_Module  
        WHERE ModelID = @PSFRONT  
        AND ModelDescription LIKE '%' + @FRONTDESCTEXT  
  
        SELECT  
          @REARDESC = ModelDescription  
        FROM Tbl_PHT_Cabinet_Module  
        WHERE ModelID = @PSREAR  
        AND ModelDescription LIKE '%' + @REARDESCTEXT  
  
        UPDATE Tbl_PHT_Cabinet_Module  
        SET OPCalc_A = CAST(ROUND(@TOTALPOWER, 2) AS decimal(16, 2)),  
            OPCalc_H = CAST(ROUND(@TOTALHEATDISSIPATION, 2) AS decimal(16, 2)),  
            OPCalc_G = CAST(ROUND(@WATTSCONVERSION, 2) AS decimal(16, 2))  
        WHERE ModelID = @PSFRONT  
        AND CabinetID = @val_CabinetID  
        AND ModelDescription = @FRONTDESC  
  
        UPDATE Tbl_PHT_Cabinet_Module  
        SET OPCalc_A = CAST(ROUND(@TOTALREARPOWER, 2) AS decimal(16, 2)),  
            OPCalc_H = CAST(ROUND(@TOTALREARHEATDISSIPATION, 2) AS decimal(16, 2)),  
            OPCalc_G = CAST(ROUND(@REARWATTSCONVERSION, 2) AS decimal(16, 2))  
        WHERE ModelID = @PSREAR  
        AND CabinetID = @val_CabinetID  
        AND ModelDescription = @REARDESC  
    
    
      END  
      ELSE  
      BEGIN  
        SET @WATTSCONVERSION = ((@TOTALHEATDISSIPATION * @BTUHR) / @KCALHR)  
        SET @REARWATTSCONVERSION = ((@TOTALREARHEATDISSIPATION * @BTUHR) / @KCALHR)  
  if(@ConfigType<>'Misc')  
  begin  
  print @PSFRONT
        SELECT  
          @FRONTDESC = ModelDescription  
        FROM Tbl_PHT_Cabinet_Module  
        WHERE ModelID = @PSFRONT  
        AND ModelDescription LIKE '%' + @FRONTDESCTEXT  
  
        SELECT  
          @REARDESC = ModelDescription  
        FROM Tbl_PHT_Cabinet_Module  
        WHERE ModelID = @PSREAR  
        AND ModelDescription LIKE '%' + @REARDESCTEXT  
  
        UPDATE Tbl_PHT_Cabinet_Module  
        SET OPCalc_A = CAST(ROUND(@TOTALPOWER, 2) AS decimal(16, 2)),  
            OPCalc_H = CAST(ROUND(@TOTALHEATDISSIPATION, 2) AS decimal(16, 2)),  
            OPCalc_I = CAST(ROUND(@WATTSCONVERSION, 2) AS decimal(16, 2))  
        WHERE ModelID = @PSFRONT  
        AND CabinetID = @val_CabinetID  
        AND ModelDescription = @FRONTDESC  
  
        UPDATE Tbl_PHT_Cabinet_Module  
        SET OPCalc_A = CAST(ROUND(@TOTALREARPOWER, 2) AS decimal(16, 2)),  
            OPCalc_H = CAST(ROUND(@TOTALREARHEATDISSIPATION, 2) AS decimal(16, 2)),  
            OPCalc_I = CAST(ROUND(@REARWATTSCONVERSION, 2) AS decimal(16, 2))  
        WHERE ModelID = @PSREAR  
        AND CabinetID = @val_CabinetID  
        AND ModelDescription = @REARDESC  
  END  
  --ELSE  
  --BEGIN  
  
  --      UPDATE Tbl_PHT_Miscelleneous_Module  
  --      SET OPCalc_A = CAST(ROUND(@TOTALPOWER, 2) AS decimal(16, 2)),  
  --          OPCalc_H = CAST(ROUND(@TOTALHEATDISSIPATION, 2) AS decimal(16, 2)),  
  --          OPCalc_G = CAST(ROUND(@WATTSCONVERSION, 2) AS decimal(16, 2))  
  --      WHERE  CompID = @val_CabinetID  
        
  --      UPDATE Tbl_PHT_Miscelleneous_Module  
  --      SET OPCalc_A = CAST(ROUND(@TOTALREARPOWER, 2) AS decimal(16, 2)),  
  --          OPCalc_H = CAST(ROUND(@TOTALREARHEATDISSIPATION, 2) AS decimal(16, 2)),  
  --          OPCalc_G = CAST(ROUND(@REARWATTSCONVERSION, 2) AS decimal(16, 2))  
  --      WHERE CompID = @val_CabinetID  
       
  --END  
      END  
  
  
  
    SET @TOTALPOWER = 0;  
    SET @TOTALREARPOWER = 0;  
    SET @TOTALWATTS = 0;  
    SET @TOTALREARWATTS = 0;  
    SET @TOTALHEATDISSIPATION = 0;  
    SET @WATTSCONVERSION = 0;  
    SET @TOTALREARHEATDISSIPATION=0.0      
    SET @REARWATTSCONVERSION=0.0  
  
  
             
               
            
    IF (@AmbientTemp is not NULL)  
    BEGIN  
      UPDATE dbo.Tbl_PHT_Cabinet_Temp  
      SET Tambient = @AmbientTemp,  
          CabTemp = @AmbientTemp + dT  
      WHERE CabinetID = @val_CabinetID  
      AND dT != -1  
  
      UPDATE dbo.Tbl_PHT_Cabinet_Temp  
      SET Tambient = @AmbientTemp  
      WHERE CabinetID = @val_CabinetID  
      AND dT = -1  
    END  
  
    --IF (@PowerDrawType = '24VDC PS(Front Side)-Power Draw' or @PowerDrawType = '24VDC PS(Rear Side)-Power Draw')  
    --  begin
      declare @valIDCSum AS decimal(10,2)=0
      declare @valCurrentRating AS decimal(10,2)=0
      declare @IDCErrortxt AS nvarchar(50)=''
      set @PSFront=0
select @PSFront=PSFront from Tbl_PHT_Cabinet_Configuration where CabinetID=@val_CabinetID 
if(@PSFront<>0)
begin
      select @valIDCSum=isnull(sum(case when PHCompChannelWise=1 then Tbl_PHT_Cabinet_Module.OPCalc_A else (Tbl_PHT_ModuleDef.Heatdissipation*Tbl_PHT_Cabinet_Module.Quantity)/@POWERSUPPLYDCVOLTAGE end),0) from Tbl_PHT_Cabinet_Configuration inner join 
      Tbl_PHT_Cabinet_Module on Tbl_PHT_Cabinet_Configuration.CabinetID=Tbl_PHT_Cabinet_Module.CabinetID inner join 
      Tbl_PHT_ModuleDef on Tbl_PHT_Cabinet_Module.ModelID=Tbl_PHT_ModuleDef.ModelID inner join Tbl_PHT_Power_Draw_Type on 
      Tbl_PHT_Power_Draw_Type.PowerDrawTypeID=Tbl_PHT_Cabinet_Module.PowerDrawTypeID  where Tbl_PHT_Cabinet_Module.CabinetID = @val_CabinetID  and Tbl_PHT_Power_Draw_Type.PowerDrawType='24VDC PS(Front Side)-Power Draw' 
      
       select @valCurrentRating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_Cabinet_Configuration inner join 
      Tbl_PHT_Cabinet_Module on Tbl_PHT_Cabinet_Configuration.CabinetID=Tbl_PHT_Cabinet_Module.CabinetID inner join 
      Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_Cabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID inner join Tbl_PHT_Power_Draw_Type on 
      Tbl_PHT_Power_Draw_Type.PowerDrawTypeID=Tbl_PHT_Cabinet_Module.PowerDrawTypeID  where Tbl_PHT_Cabinet_Module.CabinetID = @val_CabinetID  and Tbl_PHT_Power_Draw_Type.PowerDrawType='Power Supply' 
      and Tbl_PHT_Cabinet_Module.ModelDescription like '%'+@FRONTDESCTEXT+'%'
      
       if(@valIDCSum>@valCurrentRating)
       begin
       set @IDCErrortxt+='Front/'
       end
       end
       set @valIDCSum=0
       set @valCurrentRating=0
       
       set @PSRear=0
        select @PSRear=PSRear from Tbl_PHT_Cabinet_Configuration where CabinetID=@val_CabinetID
        if(@PSRear<>0)
begin
        select @valIDCSum=isnull(sum(case when PHCompChannelWise=1 then Tbl_PHT_Cabinet_Module.OPCalc_A else (Tbl_PHT_ModuleDef.Heatdissipation*Tbl_PHT_Cabinet_Module.Quantity)/@POWERSUPPLYDCVOLTAGE end),0) from Tbl_PHT_Cabinet_Configuration inner join 
      Tbl_PHT_Cabinet_Module on Tbl_PHT_Cabinet_Configuration.CabinetID=Tbl_PHT_Cabinet_Module.CabinetID inner join 
      Tbl_PHT_ModuleDef on Tbl_PHT_Cabinet_Module.ModelID=Tbl_PHT_ModuleDef.ModelID inner join Tbl_PHT_Power_Draw_Type on 
      Tbl_PHT_Power_Draw_Type.PowerDrawTypeID=Tbl_PHT_Cabinet_Module.PowerDrawTypeID  where Tbl_PHT_Cabinet_Module.CabinetID = @val_CabinetID  and Tbl_PHT_Power_Draw_Type.PowerDrawType='24VDC PS(Rear Side)-Power Draw' 
      
       select @valCurrentRating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_Cabinet_Configuration inner join 
      Tbl_PHT_Cabinet_Module on Tbl_PHT_Cabinet_Configuration.CabinetID=Tbl_PHT_Cabinet_Module.CabinetID inner join 
      Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_Cabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID inner join Tbl_PHT_Power_Draw_Type on 
      Tbl_PHT_Power_Draw_Type.PowerDrawTypeID=Tbl_PHT_Cabinet_Module.PowerDrawTypeID  where Tbl_PHT_Cabinet_Module.CabinetID = @val_CabinetID  and Tbl_PHT_Power_Draw_Type.PowerDrawType='Power Supply' 
      and Tbl_PHT_Cabinet_Module.ModelDescription like '%'+@REARDESCTEXT+'%'
      if(@valIDCSum>@valCurrentRating)
       begin
       set @IDCErrortxt+='Rear/'
       end
     end
     if(@IDCErrortxt<>'')
     begin
      Update Tbl_PHT_Cabinet_Configuration set  Is_IDCCheck =1,IDCError=LEFT(@IDCErrortxt, LEN(@IDCErrortxt) - 1) where CabinetID = @val_CabinetID
      end
      else
      begin
      Update Tbl_PHT_Cabinet_Configuration set  Is_IDCCheck =0,IDCError='' where CabinetID = @val_CabinetID
      end
      --end
    SELECT  
      @iconfig = @iconfig + 1  
  
  END  
  
  END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Delete_Cabinet_RUSIO_Config]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Delete_Cabinet_RUSIO_Config]  
 --@ID int,  
    @CabinetID UNIQUEIDENTIFIER ,  
    @Status bit output  
     
AS   
    BEGIN  
        SET NOCOUNT ON      
      Delete from Tbl_PHT_RUSIO_SM where Cabinet_ID=@CabinetID   
        SET @Status = 1  
    END
GO
/****** Object:  StoredProcedure [dbo].[sp_GETPHFRONTps]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GETPHFRONTps] --  '',''  
 -- Add the parameters for the stored procedure here    
     @ProjectName VARCHAR(1500)='',
    @CabinetName VARCHAR(1500)='',
    @AreaName VARCHAR(1500)='',
    @LocationName VARCHAR(1500)='',
    @CabinetTypeName VARCHAR(1500)='',
    @ModelView int=0
AS    

Begin
       DECLARE @QRY VARCHAR(1500)
DECLARE @PName VARCHAR(1500)=''
DECLARE @CName VARCHAR(1500)=''
DECLARE @AName VARCHAR(1500)=''
DECLARE @LName VARCHAR(1500)=''
DECLARE @CTName VARCHAR(1500)=''
DECLARE @GroupBy VARCHAR(1500)=' group By ProjectName,CabinetName,HoneywellModel'
DECLARE @GroupBy1 VARCHAR(1500)=' group By ProjectName,CabinetName'
IF ( @ProjectName <> '' ) 
            BEGIN
            SET @PName = ' and TP.ProjectName='''+@ProjectName+''''
            end        
  IF ( @CabinetName <> '' ) 
            BEGIN
            SET @CName = ' and TC.CabinetName='''+@CabinetName+''''
            end      
     IF ( @AreaName <> '' ) 
            BEGIN
            SET @AName = ' and TC.Area='''+@AreaName+''''
            end  
             IF ( @LocationName <> '' ) 
            BEGIN
            SET @LName = ' and TC.Location='''+@LocationName+''''
            end  
             IF ( @CabinetTypeName <> '' ) 
            BEGIN
            SET @CTName = ' and TCT.CabinetTypeName='''+@CabinetTypeName+''''
            end  
            if(@ModelView=-1)
            begin
SET @QRY = 'select '''' as ModuleName,SUM(TM.OPCalc_F) as HeatDiss,TP.ProjectName,TC.CabinetName,SUM(TM.OPCalc_A) as IDC,SUM(TPS.CurrentRating) as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
'+@PName+@CName+@AName+@LName+@CTName+@GroupBy1
end
         else if(@ModelView=0)
            begin
            SET @QRY = 'select '''' as ModuleName,SUM(TM.OPCalc_F) as HeatDiss,TP.ProjectName,TC.CabinetName,SUM(TM.OPCalc_A) as IDC,SUM(TPS.CurrentRating) as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
 and TM.PowerDrawTypeID=''CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy1
--SET @QRY = 'select TPS.HoneywellModel as ModuleName,TM.OPCalc_F as HeatDiss,TP.ProjectName,TC.CabinetName,TM.OPCalc_A as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
-- TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C''
--and TM.PowerDrawTypeID=''CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5'''+@PName+@CName+@AName+@LName+@CTName
end
else if(@ModelView=1)
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,SUM(OPCalc_A) as IDC,SUM(TM.OPCalc_F) as HeatDiss,SUM(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID  and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'' and TM.PowerDrawTypeID=''CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5'''+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
else
begin
SET @QRY = 'select TC.CabinetName as CabinetName,TMD.HoneywellModel as ModuleName,TP.ProjectName,SUM(OPCalc_A) as IDC,SUM(TM.OPCalc_F) as HeatDiss,SUM(0) as CurrentRating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_ModuleDef TMD,Tbl_PHT_Cabinet_Type TCT,
Tbl_PHT_Project TP where TC.CabinetID=TM.CabinetID and TM.ModelID=TMD.ModelID and TC.CabinetTypeID=TCT.CabinetTypeID and
TC.ProjectID=TP.ProjectID  and TM.PowerDrawTypeID<>''5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'' and (TM.PowerDrawTypeID=''CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5'' or TM.PowerDrawTypeID=''8224F746-CFB1-4C67-82EA-FE6B0E420127'')'+@PName+@CName+@AName+@LName+@CTName+@GroupBy
end
EXEC(@QRY)
End
select TPS.HoneywellModel as ModuleName,TM.OPCalc_F as HeatDiss,TP.ProjectName,TC.CabinetName,TM.OPCalc_A as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS,Tbl_PHT_Cabinet_Type TCT where
 TC.CabinetTypeID=TCT.CabinetTypeID and TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
and TM.PowerDrawTypeID='CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5'
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_CalculatePH_ForSMPSU]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_CalculatePH_ForSMPSU]        
    @ProjID UNIQUEIDENTIFIER    
  
 AS  
 BEGIN  
               
         DECLARE @ISBTU_HR BIT     
         DECLARE @PowerDrawType VARCHAR(150)  
          
         DECLARE @BTUHR DECIMAL(16,3)  
         DECLARE @KCALHR DECIMAL(16,3)  
           
         DECLARE @24VDC BIT  
         DECLARE @48VDC BIT  
         DECLARE @60VDC BIT  
         DECLARE @110VDC BIT  
         DECLARE @220VDC BIT  
           
         DECLARE @24VDCPSUID INT  
         DECLARE @48VDCPSUID INT  
         DECLARE @60VDCPSUID INT  
         DECLARE @110VDCPSUID INT  
         DECLARE @220VDCPSUID INT  
           
         DECLARE @24VDCEFF DECIMAL(16,2)  
         DECLARE @48VDCEFF DECIMAL(16,2)  
         DECLARE @60VDCEFF DECIMAL(16,2)  
         DECLARE @110VDCEFF DECIMAL(16,2)  
         DECLARE @220VDCEFF DECIMAL(16,2)  
           
           
         DECLARE @24VDCWATTS DECIMAL(16,10)  
         DECLARE @48VDCWATTS DECIMAL(16,10)  
         DECLARE @60VDCWATTS DECIMAL(16,10)  
         DECLARE @110VDCWATTS DECIMAL(16,10)  
         DECLARE @220VDCWATTS DECIMAL(16,10)  
           
           
         DECLARE @24VDCPOWER DECIMAL(16,10)  
         DECLARE @48VDCPOWER DECIMAL(16,10)  
         DECLARE @60VDCPOWER DECIMAL(16,10)  
         DECLARE @110VDCPOWER DECIMAL(16,10)  
         DECLARE @220VDCPOWER DECIMAL(16,10)  
           
         DECLARE @24VDCHEATDISSIPATION DECIMAL(16,10)  
         DECLARE @48VDCHEATDISSIPATION DECIMAL(16,10)  
         DECLARE @60VDCHEATDISSIPATION DECIMAL(16,10)  
         DECLARE @110VDCHEATDISSIPATION DECIMAL(16,10)  
         DECLARE @220VDCHEATDISSIPATION DECIMAL(16,10)  
           
           
         DECLARE @24VDCPOWERCONSUMPTION DECIMAL(16,10)  
         DECLARE @48VDCPOWERCONSUMPTION DECIMAL(16,10)  
         DECLARE @60VDCPOWERCONSUMPTION DECIMAL(16,10)  
         DECLARE @110VDCPOWERCONSUMPTION DECIMAL(16,10)  
         DECLARE @220VDCPOWERCONSUMPTION DECIMAL(16,10)  
           
           
         DECLARE @24VDCWATTSCONVERSION DECIMAL(16,10)  
         DECLARE @48VDCWATTSCONVERSION DECIMAL(16,10)  
         DECLARE @60VDCWATTSCONVERSION DECIMAL(16,10)  
         DECLARE @110VDCWATTSCONVERSION DECIMAL(16,10)  
         DECLARE @220VDCWATTSCONVERSION DECIMAL(16,10)  
           
           
         DECLARE @MODPOWER DECIMAL(16,10)  
         DECLARE @MODWATTS DECIMAL(16,10)  
         DECLARE @IAC DECIMAL(16,10)
  
         DECLARE @val_CabinetID uniqueidentifier,      
          @val_CabinetName nvarchar(256),  
          @val_CabinetModuleID uniqueidentifier,@val_ModelID int  
            
         DECLARE @ISUSEINPH BIT  
            
          SET @BTUHR=3.413  
          SET @KCALHR=3.968  
   
           
       
            
            
            
         SELECT   
         @ISBTU_HR=TBL_RPT_SET.AdvPowerHeatUnit   
         FROM   
                TBL_PHT_PROJECT TBL_PRJ ,        
                Tbl_PHT_Report_Setting TBL_RPT_SET,        
                Tbl_PHT_Cabinet_Configuration TBL_CAB        
         WHERE  TBL_PRJ.ProjectID = TBL_RPT_SET.ProjectID                
                AND TBL_PRJ.ProjectID = TBL_CAB.ProjectID AND TBL_PRJ.ProjectID = @ProjID   
                  
           DECLARE CabinetConfig_CURSOR CURSOR FOR        
     SELECT [CabinetID],[CabinetName] FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Configuration]  
     where ProjectID = @ProjID and CabinetTypeID IN(6,7)   
           
     OPEN CabinetConfig_CURSOR        
     FETCH NEXT FROM CabinetConfig_CURSOR        
     INTO @val_CabinetID,@val_CabinetName         
                  
                  WHILE @@FETCH_STATUS = 0        
                   BEGIN     
                    
              SELECT @24VDCEFF =(Efficiency/100),@24VDCPSUID =ModelID FROM  
                             Tbl_PHT_PowerSupply_SMCabinet WHERE Cabinet_ID=@val_CabinetID AND PowerSupply_Type='24VDC'  
                     
                             SELECT @48VDCEFF =(Efficiency/100), @48VDCPSUID =ModelID  FROM  
                             Tbl_PHT_PowerSupply_SMCabinet WHERE Cabinet_ID=@val_CabinetID AND PowerSupply_Type='48VDC'  
                               
                             SELECT @60VDCEFF =(Efficiency/100), @60VDCPSUID =ModelID  FROM  
                             Tbl_PHT_PowerSupply_SMCabinet WHERE Cabinet_ID=@val_CabinetID AND PowerSupply_Type='60VDC'  
                               
                             SELECT @110VDCEFF =(Efficiency/100), @110VDCPSUID =ModelID  FROM  
                             Tbl_PHT_PowerSupply_SMCabinet WHERE Cabinet_ID=@val_CabinetID AND PowerSupply_Type='110VDC'  
                               
                             SELECT @220VDCEFF =(Efficiency/100), @220VDCPSUID =ModelID  FROM  
                             Tbl_PHT_PowerSupply_SMCabinet WHERE Cabinet_ID=@val_CabinetID AND PowerSupply_Type='220VDC'  
                               
                                     SET @24VDCWATTS=0.0  
          SET @48VDCWATTS=0.0  
          SET @60VDCWATTS=0.0  
          SET @110VDCWATTS=0.0  
          SET @220VDCWATTS=0.0  
                  
                  
          SET @24VDCPOWER=0.0  
          SET @48VDCPOWER=0.0  
          SET @60VDCPOWER=0.0  
          SET @110VDCPOWER=0.0  
          SET @220VDCPOWER=0.0  
                               
          DECLARE CabinetModule_CURSOR CURSOR FOR        
          SELECT         
         [CabinetModuleID]                    
           ,[ModelID]   
           ,PDT.PowerDrawType  
           ,[IDC_Pri]  
           ,[TotalHeat_Des_Watts]  
           ,[UseIn_HeatCalc] 
           ,[IAC_Pri] 
         
         FROM [PowerHeatCalc].[dbo].[Tbl_PHT_SMCabinet_Module] SM   
         INNER JOIN  
         dbo.Tbl_PHT_Power_Draw_Type PDT ON SM.[PowerDrawTypeID]=PDT.[PowerDrawTypeID]  
         where CabinetID = @val_CabinetID  and   
         ModelID NOT IN(SELECT ModelID FROM Tbl_PHT_PowerSupply_SMCabinet WHERE Cabinet_ID=@val_CabinetID)  
        
        
        OPEN CabinetModule_CURSOR        
        FETCH NEXT FROM CabinetModule_CURSOR        
        INTO @val_CabinetModuleID,@val_ModelID,@PowerDrawType,@MODPOWER,@MODWATTS,@ISUSEINPH,@IAC  
        
              WHILE @@FETCH_STATUS = 0        
                                BEGIN   
                                       
                                     SELECT @24VDC=[24V_IO],@48VDC=[48V_IO],  
                                     @60VDC=[60V_IO],@110VDC=[110V_IO],  
                                     @220VDC=[220V_IO] FROM Tbl_PHT_ModuleDef  
                                     WHERE ModelID=@val_ModelID  
                       
                                        IF(@PowerDrawType='Utility / Service-Power Draw')
                                        BEGIN
                                          SET @MODPOWER= (@IAC*1000)
                                          Print convert(varchar(100),@val_CabinetID) + ' ' + convert(varchar(100),@MODPOWER)  
                                        END
             
                                   IF(@PowerDrawType = 'SM Module' OR @PowerDrawType='Addtional Power' OR @PowerDrawType='Utility / Service-Power Draw' OR (@PowerDrawType = 'SM Marshalling Module' AND @ISUSEINPH=1))  
                                   BEGIN  
                                             Print convert(varchar(100),@val_CabinetID) + ' ' + @PowerDrawType + convert(varchar(100),@MODPOWER)  
                                               
                                              IF (@24VDC=1)  
                                              BEGIN  
              SET @24VDCPOWER = @24VDCPOWER + @MODPOWER  
                  SET @24VDCWATTS = @24VDCWATTS + @MODWATTS  
             END  
                                              ELSE IF(@48VDC =1)  
                                              BEGIN  
                                                   
                                                   SET @48VDCPOWER = @48VDCPOWER + @MODPOWER  
              SET @48VDCWATTS = @48VDCWATTS + @MODWATTS  
                          
                                              END  
                                              ELSE IF(@60VDC =1)  
                                              BEGIN  
                                                  
                                                     SET @60VDCPOWER = @60VDCPOWER + @MODPOWER  
              SET @60VDCWATTS = @60VDCWATTS + @MODWATTS  
                                          
                                              END  
                                              ELSE IF(@110VDC =1)  
                                              BEGIN  
                                                    
                                                     SET @110VDCPOWER = @110VDCPOWER + @MODPOWER  
              SET @110VDCWATTS = @110VDCWATTS + @MODWATTS  
              
                END  
                                              ELSE IF(@220VDC =1)  
                                              BEGIN  
                                                    
                                                     SET @220VDCPOWER = @220VDCPOWER + @MODPOWER  
              SET @220VDCWATTS = @220VDCWATTS + @MODWATTS  
                END  
                   
                         
                                 
                                   END   
             --                      ELSE IF(@PowerDrawType = 'SM Marshalling Module')  
             --                      BEGIN  
             --                              IF(@ISUSEINPH=1)  
             --                              BEGIN  
                                             
             --                                  IF (@24VDC=1)  
             --                                 BEGIN  
             -- SET @24VDCPOWER = @24VDCPOWER + @MODPOWER  
             --     SET @24VDCWATTS = @24VDCWATTS + @MODWATTS  
             --END  
             --                                 ELSE IF(@48VDC =1)  
             --                                 BEGIN  
                                                   
             --                                      SET @48VDCPOWER = @48VDCPOWER + @MODPOWER  
             -- SET @48VDCWATTS = @48VDCWATTS + @MODWATTS  
                                                           
             --                                 END  
             --                                 ELSE IF(@60VDC =1)  
             --                                 BEGIN  
                                                  
             --                                        SET @60VDCPOWER = @60VDCPOWER + @MODPOWER  
             -- SET @60VDCWATTS = @60VDCWATTS + @MODWATTS  
                                          
             --                                 END  
             --                                 ELSE IF(@110VDC =1)  
             --                                 BEGIN  
                                                    
             --                                        SET @110VDCPOWER = @110VDCPOWER + @MODPOWER  
             -- SET @110VDCWATTS = @110VDCWATTS + @MODWATTS  
              
             --   END  
             --                                 ELSE IF(@220VDC =1)  
             --                                 BEGIN  
                                                    
             --                                        SET @220VDCPOWER = @220VDCPOWER + @MODPOWER  
             -- SET @220VDCWATTS = @220VDCWATTS + @MODWATTS  
             --   END  
                                                
             --                              END  
                                             
                                             
             --                      END  
                                   
                                FETCH NEXT FROM CabinetModule_CURSOR        
                                INTO @val_CabinetModuleID,@val_ModelID,@PowerDrawType,@MODPOWER,@MODWATTS,@ISUSEINPH,@IAC  
                                END   
        
              CLOSE CabinetModule_CURSOR        
                                DEALLOCATE CabinetModule_CURSOR     
        
                                       IF(@24VDCEFF=0)  
                   SET @24VDCEFF=1  
                  IF(@48VDCEFF=0)  
                SET @48VDCEFF=1  
               IF(@60VDCEFF=0)  
                SET @60VDCEFF=1  
               IF(@110VDCEFF=0)  
                SET @110VDCEFF=1  
               IF(@220VDCEFF=0)  
                SET @220VDCEFF=1  
                                              
                                             
                                                      SET @24VDCHEATDISSIPATION = ((@24VDCWATTS/@24VDCEFF)-@24VDCWATTS)  
                  SET @48VDCHEATDISSIPATION = ((@48VDCWATTS/@48VDCEFF)-@48VDCWATTS)  
                  SET @60VDCHEATDISSIPATION = ((@60VDCWATTS/@60VDCEFF)-@60VDCWATTS)  
                  SET @110VDCHEATDISSIPATION = ((@110VDCWATTS/@110VDCEFF)-@110VDCWATTS)  
                  SET @220VDCHEATDISSIPATION = ((@220VDCWATTS/@220VDCEFF)-@220VDCWATTS)  
                  
                              
              IF(@ISBTU_HR=1)  
              BEGIN  
              SET @24VDCWATTSCONVERSION= (@24VDCHEATDISSIPATION * @BTUHR)  
                          SET @48VDCWATTSCONVERSION= (@48VDCHEATDISSIPATION * @BTUHR)  
              SET @60VDCWATTSCONVERSION= (@60VDCHEATDISSIPATION * @BTUHR)  
              SET @110VDCWATTSCONVERSION= (@110VDCHEATDISSIPATION * @BTUHR)  
              SET @220VDCWATTSCONVERSION= (@220VDCHEATDISSIPATION * @BTUHR)  
              END     
              ELSE  
              BEGIN  
              SET @24VDCWATTSCONVERSION= ((@24VDCHEATDISSIPATION * @BTUHR)/@KCALHR)  
              SET @48VDCWATTSCONVERSION= ((@48VDCHEATDISSIPATION * @BTUHR)/@KCALHR)  
              SET @60VDCWATTSCONVERSION= ((@60VDCHEATDISSIPATION * @BTUHR)/@KCALHR)  
              SET @110VDCWATTSCONVERSION= ((@110VDCHEATDISSIPATION * @BTUHR)/@KCALHR)  
              SET @220VDCWATTSCONVERSION= ((@220VDCHEATDISSIPATION * @BTUHR)/@KCALHR)    
              END  
                
            
                
                       UPDATE Tbl_PHT_SMCabinet_Module SET IDC_Pri= CAST(ROUND(@24VDCPOWER*0.001,2)AS DECIMAL(16,2)) ,  
                       TotalHeat_Des_Watts= CAST(ROUND(@24VDCHEATDISSIPATION,2)AS DECIMAL(16,2)),  
                       TotalHeat_Des_Btu= CAST(ROUND(@24VDCWATTSCONVERSION,2)AS DECIMAL(16,2))  
                       WHERE   ModelID=  @24VDCPSUID  AND CabinetID=@val_CabinetID  
                         
                                                            
                       UPDATE Tbl_PHT_SMCabinet_Module SET IDC_Pri= CAST(ROUND(@48VDCPOWER*0.001,2)AS DECIMAL(16,2)) ,  
                       TotalHeat_Des_Watts= CAST(ROUND(@48VDCHEATDISSIPATION,2)AS DECIMAL(16,2)),  
                       TotalHeat_Des_Btu= CAST(ROUND(@48VDCWATTSCONVERSION,2)AS DECIMAL(16,2))  
                       WHERE   ModelID=  @48VDCPSUID  AND CabinetID=@val_CabinetID  
                         
                                                
                       UPDATE Tbl_PHT_SMCabinet_Module SET IDC_Pri= CAST(ROUND(@60VDCPOWER*0.001,2)AS DECIMAL(16,2)) ,  
                       TotalHeat_Des_Watts= CAST(ROUND(@60VDCHEATDISSIPATION,2)AS DECIMAL(16,2)),  
                       TotalHeat_Des_Btu= CAST(ROUND(@60VDCWATTSCONVERSION,2)AS DECIMAL(16,2))  
                       WHERE   ModelID=  @60VDCPSUID  AND CabinetID=@val_CabinetID  
                         
                       UPDATE Tbl_PHT_SMCabinet_Module SET IDC_Pri= CAST(ROUND(@110VDCPOWER*0.001,2)AS DECIMAL(16,2)) ,  
                       TotalHeat_Des_Watts= CAST(ROUND(@110VDCHEATDISSIPATION,2)AS DECIMAL(16,2)),  
                       TotalHeat_Des_Btu= CAST(ROUND(@110VDCWATTSCONVERSION,2)AS DECIMAL(16,2))  
                       WHERE   ModelID=  @110VDCPSUID  AND CabinetID=@val_CabinetID  
                         
                         
                       UPDATE Tbl_PHT_SMCabinet_Module SET IDC_Pri= CAST(ROUND(@220VDCPOWER*0.001,2)AS DECIMAL(16,2)) ,  
                       TotalHeat_Des_Watts= CAST(ROUND(@220VDCHEATDISSIPATION,2)AS DECIMAL(16,2)),  
                       TotalHeat_Des_Btu= CAST(ROUND(@220VDCWATTSCONVERSION,2)AS DECIMAL(16,2))  
                       WHERE   ModelID=  @220VDCPSUID  AND CabinetID=@val_CabinetID  
        
          FETCH NEXT FROM CabinetConfig_CURSOR        
                   INTO @val_CabinetID,@val_CabinetName        
                   END  
                     
                     
                     
 CLOSE CabinetConfig_CURSOR        
 DEALLOCATE CabinetConfig_CURSOR                 
 END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_CalculatePH_ForSeriesCPSU]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_CalculatePH_ForSeriesCPSU]      
    @ProjID UNIQUEIDENTIFIER  

 AS
 BEGIN
         DECLARE @J DECIMAL(10, 5)    
         DECLARE @A DECIMAL(16,2)
         DECLARE @H DECIMAL(16,2)
         DECLARE @PSFRONT INT
         DECLARE @PSREAR INT
         DECLARE @ISBTU_HR BIT   
         DECLARE @PowerDrawType VARCHAR(150)
         DECLARE @WATTSCONVERSION  DECIMAL(16,2) 
         DECLARE @REARWATTSCONVERSION DECIMAL(16,2)
         DECLARE @BTUHR DECIMAL(16,3)
         DECLARE @KCALHR DECIMAL(16,3)
         

         DECLARE @val_CabinetID uniqueidentifier,    
          @val_CabinetName nvarchar(256),
          @val_CabinetModuleID uniqueidentifier,@val_ModelID int
          
         DECLARE @TOTALPOWER DECIMAL(16,2)
         DECLARE @TOTALWATTS DECIMAL(16,2) 
         DECLARE @TOTALHEATDISSIPATION DECIMAL(16,2)
          
          DECLARE @TOTALREARPOWER DECIMAL(16,2)
          DECLARE @TOTALREARWATTS DECIMAL(16,2)
          DECLARE @TOTALREARHEATDISSIPATION DECIMAL(16,2)
          
          SET @BTUHR=3.413
          SET @KCALHR=3.968
          SET @TOTALPOWER=0.0
          SET @TOTALWATTS=0.0
          SET @TOTALHEATDISSIPATION=0.0
          SET @TOTALREARPOWER=0.0
          SET @TOTALREARWATTS=0.0
          SET @TOTALREARHEATDISSIPATION=0.0
          SET @WATTSCONVERSION=0.0
          SET @REARWATTSCONVERSION=0.0
          
          
          
         SELECT  @J=TBL_RPT_SET.AdvPowerSupplyEff ,
         @ISBTU_HR=TBL_RPT_SET.AdvPowerHeatUnit 
         FROM 
                TBL_PHT_PROJECT TBL_PRJ ,      
                Tbl_PHT_Report_Setting TBL_RPT_SET,      
                Tbl_PHT_Cabinet_Configuration TBL_CAB      
         WHERE  TBL_PRJ.ProjectID = TBL_RPT_SET.ProjectID              
                AND TBL_PRJ.ProjectID = TBL_CAB.ProjectID AND TBL_PRJ.ProjectID = @ProjID 
                
           DECLARE CabinetConfig_CURSOR CURSOR FOR      
		   SELECT [CabinetID],[CabinetName],[PSFront],[PSRear] FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Configuration]
		   where ProjectID = @ProjID and CabinetTypeID IN(1,4) 
		       
		   OPEN CabinetConfig_CURSOR      
		   FETCH NEXT FROM CabinetConfig_CURSOR      
		   INTO @val_CabinetID,@val_CabinetName,@PSFRONT,@PSREAR         
                
                  WHILE @@FETCH_STATUS = 0      
                   BEGIN   
							   DECLARE CabinetModule_CURSOR CURSOR FOR      
									 SELECT       
									[CabinetModuleID]                  
								   ,[ModelID] 
								   ,PDT.PowerDrawType		           
								   ,[OPCalc_A]
								   ,[OPCalc_H]
									FROM [PowerHeatCalc].[dbo].[Tbl_PHT_Cabinet_Module] CM 
									INNER JOIN
									dbo.Tbl_PHT_Power_Draw_Type PDT ON CM.[PowerDrawTypeID]=PDT.[PowerDrawTypeID]
									where CabinetID = @val_CabinetID  and ModelID NOT IN(@PSFRONT,@PSREAR)
						
						
								OPEN CabinetModule_CURSOR      
								FETCH NEXT FROM CabinetModule_CURSOR      
								INTO @val_CabinetModuleID,@val_ModelID,@PowerDrawType,@A,@H
						
						        WHILE @@FETCH_STATUS = 0      
                                BEGIN 
                                     
                                     --print 'A '+ convert(varchar(100),@A)
                                     --print 'G '+ convert(varchar(100),@G)
                                     --print @PowerDrawType
                                     
                                     	
										 
                                   IF(@PowerDrawType = '24VDC PS(Front Side)-Power Draw')
                                   BEGIN
                                                 
                                         SET @TOTALPOWER = @TOTALPOWER + @A
										 SET @TOTALWATTS = @TOTALWATTS + @H
										 
										 SET @TOTALHEATDISSIPATION = ((@TOTALWATTS/@J)-@TOTALWATTS)
	                                    -- print 'heat '+ convert(varchar(10),@TOTALHEATDISSIPATION)
	                                     
										 IF(@ISBTU_HR=1)
										 BEGIN
											SET @WATTSCONVERSION= (@TOTALHEATDISSIPATION * @BTUHR)
										 END   
										 ELSE
										 BEGIN
											SET @WATTSCONVERSION= ((@TOTALHEATDISSIPATION * @BTUHR)/@KCALHR)
										 END
                                                 
                                            -- print 'Watts ' + convert(varchar(10),@WATTSCONVERSION)  
                                                -- print 'Front ' + Convert(varchar(10),@PSFRONT) + ' ' + Convert(varchar(100),@val_CabinetModuleID)
                                                   
                                                   --print Convert(varchar(10), @TOTALPOWER )+ ' ' +  Convert(varchar(10),@TOTALHEATDISSIPATION )+ ' ' +  Convert(varchar(10),@WATTSCONVERSION )            
										  UPDATE Tbl_PHT_Cabinet_Module SET OPCalc_A= CAST(ROUND(@TOTALPOWER,2)AS DECIMAL(16,2)) ,
										   OPCalc_H= CAST(ROUND(@TOTALHEATDISSIPATION,2)AS DECIMAL(16,2)),
										   OPCalc_G= CAST(ROUND(@WATTSCONVERSION,2)AS DECIMAL(16,2))
										  WHERE   ModelID=  @PSFRONT    
                                          
                                           
                               
                                   END 
                                   ELSE IF(@PowerDrawType ='24VDC PS(Rear Side)-Power Draw')
                                   BEGIN
                                         SET @TOTALREARPOWER = @TOTALREARPOWER + @A
										 SET @TOTALREARWATTS = @TOTALREARWATTS + @H
										 SET @TOTALREARHEATDISSIPATION = ((@TOTALREARWATTS/@J)-@TOTALREARWATTS)
	                                     
										 IF(@ISBTU_HR=1)
										 BEGIN
											SET @REARWATTSCONVERSION= (@TOTALREARHEATDISSIPATION * @BTUHR)
										 END   
										 ELSE
										 BEGIN
											SET @REARWATTSCONVERSION= ((@TOTALREARHEATDISSIPATION * @BTUHR)/@KCALHR)
										 END
                                --print Convert(varchar(10), @TOTALREARPOWER )+ ' ' +  Convert(varchar(10),@TOTALREARHEATDISSIPATION )+ ' ' +  Convert(varchar(10),@REARWATTSCONVERSION )            
                                   
                                             --print 'Rear ' + convert(varchar(10),@PSREAR)+ ' ' + Convert(varchar(100),@val_CabinetModuleID)
                                          UPDATE Tbl_PHT_Cabinet_Module 
                                          SET OPCalc_A=CAST(ROUND( @TOTALREARPOWER,2)AS DECIMAL(16,2)) , 
                                          OPCalc_H= CAST(ROUND(@TOTALREARHEATDISSIPATION,2)AS DECIMAL(16,2)),
										  OPCalc_G= CAST(ROUND(@REARWATTSCONVERSION,2)AS DECIMAL(16,2))
										  WHERE  ModelID=  @PSREAR 
                                   END
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                FETCH NEXT FROM CabinetModule_CURSOR      
                                INTO @val_CabinetModuleID,@val_ModelID,@PowerDrawType,@A,@H
                                END 
						
						        CLOSE CabinetModule_CURSOR      
                                DEALLOCATE CabinetModule_CURSOR   
						
						
						
			       FETCH NEXT FROM CabinetConfig_CURSOR      
                   INTO @val_CabinetID,@val_CabinetName,@PSFRONT,@PSREAR       
                   END
                   
                   
                   
 CLOSE CabinetConfig_CURSOR      
 DEALLOCATE CabinetConfig_CURSOR               
 END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_AdvSetting_Update_RUSIO]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[SP_PHT_AdvSetting_Update_RUSIO]
@RUSIO Type_PHT_AdvSetting_Update_RUSIO Readonly      
as 

--Declare @RUSIO Type_PHT_AdvSetting_Update_RUSIO 
--Insert into @RUSIO (ID, Total_Heat_Dessipation, TotalPower)
--Values ('54', '0.000', '0.000')  ,
--('55', '65.550', '2560.000'), 
--('56', '33.250', '1280.000'), 
--('57', '11.000', '0.000')


Declare @ID varchar(20), @Total_Heat_Dessipation varchar(40), @TotalPower varchar(40)
Declare @UpdateQuery varchar(max) 

Declare Cursor_Rusio cursor FAST_FORWARD FOR SELECT * FROM @RUSIO

Open Cursor_Rusio      
FETCH NEXT FROM Cursor_Rusio INTO @ID, @Total_Heat_Dessipation, @TotalPower

WHILE @@FETCH_STATUS = 0      
BEGIN  

Update Tbl_PHT_RUSIO_SM set  Total_Heat_Dessipation = @Total_Heat_Dessipation, TotalPower = @TotalPower where  ID = @ID;




FETCH NEXT FROM Cursor_Rusio INTO @ID, @Total_Heat_Dessipation, @TotalPower
      
END      
CLOSE Cursor_Rusio      
DEALLOCATE Cursor_Rusio
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_Cabinet_Module]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Update_Cabinet_Module]
    @CabinetModuleID UNIQUEIDENTIFIER ,
    @CabinetID UNIQUEIDENTIFIER ,
    @PowerDrawTypeID UNIQUEIDENTIFIER ,
    @ModelID INT ,
    @ModelDescription NVARCHAR(256) ,
    @Quantity INT ,
    @IsUIO BIT ,
    @AI_UIO_ChannelCount INT ,
    @AO_UIO_ChannelCount INT ,
    @DI_UIO_ChannelCount INT ,
    @DO_UIO_ChannelCount INT ,
    @IOTA_UIO_ChannelCount INT ,
    --@FeederType BIT ,
    @FeederType INT ,
    @OPCalc_A [decimal](16, 3),
    @OPCalc_B [decimal](16, 3),
    @OPCalc_C [decimal](16, 3),
    @OPCalc_D [decimal](16, 3),
    @OPCalc_E [decimal](16, 3),
    @OPCalc_F [decimal](16, 3),
    @OPCalc_G [decimal](16, 3),
    @OPCalc_H [decimal](16, 3),
    @OPCalc_I [decimal](16, 3),
    @OPCalc_N [decimal](16, 3),
    @RowNum int,
    @Status BIT OUTPUT
AS 
    BEGIN
        SET NOCOUNT ON 
        IF ( ( SELECT   COUNT(*)
               FROM     [PowerHeatCalc].[dbo].Tbl_PHT_Cabinet_Module
               WHERE    [CabinetModuleID] = @CabinetModuleID
             ) > 0 ) 
            BEGIN
                UPDATE  [PowerHeatCalc].[dbo].Tbl_PHT_Cabinet_Module
                --     [CabinetModuleID] = @CabinetID , commented by karthik to avoid duplication
                    SET    [PowerDrawTypeID] = @PowerDrawTypeID ,
                        [ModelID] = @ModelID ,
                        [ModelDescription] = @ModelDescription ,
                        [Quantity] = @Quantity ,
                        [IsUIO] = @IsUIO ,
                        [AI_UIO_ChannelCount] = @AI_UIO_ChannelCount ,
                        [AO_UIO_ChannelCount] = @AO_UIO_ChannelCount ,
                        [DI_UIO_ChannelCount] = @DI_UIO_ChannelCount ,
                        [DO_UIO_ChannelCount] = @DO_UIO_ChannelCount ,
                        [IOTA_UIO_ChannelCount] = @IOTA_UIO_ChannelCount ,
                        [FeederType] = @FeederType,
                        [OPCalc_A] = @OPCalc_A,
                        [OPCalc_B] = @OPCalc_B,
                        [OPCalc_C] = @OPCalc_C,
                        [OPCalc_D] = @OPCalc_D,
                        [OPCalc_E] = @OPCalc_E,
                        [OPCalc_F] = @OPCalc_F,
                        [OPCalc_G] = @OPCalc_G,
                        [OPCalc_H] = @OPCalc_H,
                        [OPCalc_I] = @OPCalc_I,
                        [OPCalc_N] = @OPCalc_N,
                        [RowNum]   = @RowNum                        
                WHERE   [CabinetModuleID] = @CabinetModuleID
    
            END
        ELSE 
            BEGIN
                INSERT  INTO [PowerHeatCalc].[dbo].Tbl_PHT_Cabinet_Module
                        ( [CabinetModuleID] ,
                          [CabinetID] ,
                          [PowerDrawTypeID] ,
                          [ModelID] ,
                          [ModelDescription] ,
                          [Quantity] ,
                          [IsUIO] ,
                          [AI_UIO_ChannelCount] ,
                          [AO_UIO_ChannelCount] ,
                          [DI_UIO_ChannelCount] ,
                          [DO_UIO_ChannelCount] ,
                          [IOTA_UIO_ChannelCount] ,
                          [FeederType],
                            [OPCalc_A],
                            [OPCalc_B] ,
                        [OPCalc_C],
                        [OPCalc_D],
                        [OPCalc_E] ,
                        [OPCalc_F],
                        [OPCalc_G],
                        [OPCalc_H],
                        [OPCalc_I],
                        [OPCalc_N],
                        [RowNum]                               
                        )
                        SELECT  @CabinetModuleID ,
                                @CabinetID ,
                                @PowerDrawTypeID ,
                                @ModelID ,
                                @ModelDescription ,
                                @Quantity ,
                                @IsUIO ,
                                @AI_UIO_ChannelCount ,
                                @AO_UIO_ChannelCount ,
                                @DI_UIO_ChannelCount ,
                                @DO_UIO_ChannelCount ,
                                @IOTA_UIO_ChannelCount ,
                                @FeederType,
                                @OPCalc_A,
                                 @OPCalc_B,
                                @OPCalc_C,
                                @OPCalc_D,
                                @OPCalc_E,
                                @OPCalc_F,
                                @OPCalc_G,
                                @OPCalc_H,
                                @OPCalc_I,
                                @OPCalc_N,
                                @RowNum                              
            END
        SET @Status = 1
        declare @PSFront int =0
        declare @PSRear int =0
        if(@PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and @ModelDescription like '%- front ps%')
        begin 
        select @PSFront=PSFront from Tbl_PHT_Cabinet_Configuration where CabinetID=@CabinetID and PSFront=0
        if(@PSFront=0)
        begin
        update Tbl_PHT_Cabinet_Configuration set PSFront=@ModelID where CabinetID=@CabinetID
        end
        end
        else if(@PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C')
        begin 
        select @PSRear=PSRear from Tbl_PHT_Cabinet_Configuration where CabinetID=@CabinetID and PSRear=0
        if(@PSRear=0)
        begin
        update Tbl_PHT_Cabinet_Configuration set PSRear=@ModelID where CabinetID=@CabinetID
        end
        end
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_Cabinet_RUSIO_Config]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Update_Cabinet_RUSIO_Config]  
 --@ID int,  
    @ModuleID UNIQUEIDENTIFIER ,  
    @CabinetID UNIQUEIDENTIFIER ,     
    @Description NVARCHAR(256) ,  
    @UnitHeatDessi decimal(18,3) ,  
    @N_Modules INT ,  
    @N_ConfigChannel INT ,  
    @Load decimal(18,3) ,  
    @TotalHeatDessi  decimal(18,3),
    @TotalPower decimal(18,3),
     
    @ModuleName varchar(250) ,  
    @Custom BIT  = 0, 
    @Redundant BIT  = 0, 
    @Status BIT OUTPUT  
AS   
    BEGIN  
        SET NOCOUNT ON   
      
       -- IF ( ( SELECT   COUNT(*)  
       --        FROM    Tbl_PHT_RUSIO_SM   
       --        WHERE    Module_ID= @ModuleID  
       --      ) > 0 )   
       --     BEGIN  
       --         UPDATE  [dbo].[Tbl_PHT_RUSIO_SM]  
       --         SET    [Module_ID]=@ModuleID  
       --,[Cabinet_ID]=@CabinetID  
       --,[Description]=@Description  
       --,[Unit_Heat_Dessipation]=@UnitHeatDessi  
       --,[No_Of_Modules]=@N_Modules  
       --,[No_Of_Config_Channel]=@N_ConfigChannel  
       --,[Load]=@Load  
       --,[Total_Heat_Dessipation]=@TotalHeatDessi  
       ----,[Type]=@Type  
       --,[Module_Name]=@Status  
       --                 WHERE Module_ID= @ModuleID  
      
       --     END  
       -- ELSE   
            --BEGIN  
                INSERT  INTO [dbo].[Tbl_PHT_RUSIO_SM]  
                        ( [Module_ID]  
        ,[Cabinet_ID]  
        ,[Description]  
        ,[Unit_Heat_Dessipation]  
        ,[No_Of_Modules]  
        ,[No_Of_Config_Channel]  
        ,[Load]  
        ,[Total_Heat_Dessipation]        
        ,[Module_Name]
        ,TotalPower  
        ,[Custom]
        ,[Redundant]
                        )  
                        SELECT  @ModuleID  ,  
        @CabinetID  ,     
        @Description  ,  
        @UnitHeatDessi  ,  
        @N_Modules ,  
        @N_ConfigChannel  ,  
        @Load  ,  
        @TotalHeatDessi ,         
        @ModuleName ,
        @TotalPower, 
        @Custom,
        @Redundant
            --END  
              
  
   
        SET @Status = 1  
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_UpdateMODULEDESCRIPTION]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:  Shyamala         
-- Create date: 09-Sep-2015           
-- Description: To update description in all the cabinets once after updating PSU module description         
-- =============================================    
  
CREATE PROC [dbo].[SP_PHT_UpdateMODULEDESCRIPTION]    
    @MODULEID INT,
    @PREVDESC NVARCHAR(1000),     
    @DESCRIPTION NVARCHAR(100),          
    @ISSMMODULE BIT    
AS          
BEGIN           
     IF(@ISSMMODULE=0)    
     BEGIN    
         
      --UPDATE Tbl_PHT_Cabinet_Module SET ModelDescription=@DESCRIPTION WHERE ModelID=@MODULEID  
      UPDATE Tbl_PHT_Cabinet_Module SET ModelDescription=REPLACE(ModelDescription,@PREVDESC,@DESCRIPTION) WHERE ModelID=@MODULEID    
     END    
     ELSE IF(@ISSMMODULE=1)    
     BEGIN    
      UPDATE Tbl_PHT_SMCabinet_Module SET ModelDescription=@DESCRIPTION WHERE ModelID=@MODULEID    
     END    
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_Rev_History]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Visweswarn Varadarajan
-- Create date: 24-Jun-2013
-- Description:	To Retrieve Revision History for given project
-- =============================================
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_Rev_History] 
	-- Add the parameters for the stored procedure here
    @ProjectID UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;
        SELECT  A.RevisionNbr ,
                A.Date ,
                A.Description ,
                A.RevBy ,
                A.RevCheck ,
                A.RevApprove ,
                A.CustApprove
        FROM    Tbl_PHT_Report_Revision_History A ,
                dbo.Tbl_PHT_Report_Setting B
        WHERE   A.ReportSettingID = B.ReportSettingID
                AND B.ProjectID = @ProjectID
        ORDER BY A.RevisionNbr DESC
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_ModuleInfo]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_ModuleInfo]   --'2EBF2046-8E43-4A13-A802-9F5CF31383B3','c733800d-bcba-413a-979b-11b8e49052d7'              
 -- Add the parameters for the stored procedure here                
 @CABINETID uniqueidentifier,        
  @PROJID uniqueidentifier          
                
AS                
BEGIN                
 -- SET NOCOUNT ON added to prevent extra result sets from                
 -- interfering with SELECT statements.                
 SET NOCOUNT ON;                
                
--================================================GET PROJECT SETTINGS================================================                
                 
 DECLARE @ISBTU_HR BIT                
                 
                      
                 
        SELECT                  
                @ISBTU_HR=TBL_RPT_SET.AdvPowerHeatUnit                
        FROM    TBL_PHT_PROJECT TBL_PRJ ,                
                Tbl_PHT_Report_Setting TBL_RPT_SET,                
                Tbl_PHT_Cabinet_Configuration TBL_CAB                
        WHERE   TBL_PRJ.ProjectID = TBL_RPT_SET.ProjectID                
        AND TBL_CAB.CabinetID=@CABINETID                
                AND TBL_PRJ.ProjectID = TBL_CAB.ProjectID                
                                
                
--================================================GET LIST OF MODULES================================================                
INSERT INTO #MODULE_INFO                
(CABINETNAME,CABINETTYPE,CABDESC,PowerDrawType,Area,Location,GeneralNotes,Is_Secondary,ModelID,HWModel,Module_Group,Mod_Desc,Qty,Heat,IsAC,A,B,C,D,E,F,G,H,I,Vdrop,PF,IsBtu_hr,EnclosureWATTS,EnclosureConversion)                
SELECT               
--ROW_NUMBER() OVER(ORDER BY TBL_CAB.CabinetName,TBL_MOD.PowerDrawTypeID,TBL_MOD.ModelID),                
TBL_CAB.CabinetName,                
(SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=TBL_CAB.CabinetTypeID)                
,TBL_CAB.CabinetDesc                
,(SELECT PowerDrawType FROM Tbl_PHT_Power_Draw_Type WHERE PowerDrawTypeID=TBL_MOD.PowerDrawTypeID)                
      ,TBL_CAB.Area                
      ,TBL_CAB.Location                
      ,TBL_CAB.GeneralNotes                
      ,(CASE               
      WHEN TBL_MOD.PowerDrawTypeID='8B70E2DD-2DA1-46A4-A7FF-4632742F07A1' THEN TBL_MOD.FeederType              
      ELSE              
       (CASE               
       WHEN TBL_MOD.PowerDrawTypeID IN ('CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5','8224F746-CFB1-4C67-82EA-FE6B0E420127','5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C')               
       THEN (CASE WHEN TBL_CAB.PSUPSFeeder=0 THEN 3              
       ELSE 1 END) ELSE 1  END) END)                
      ,TBL_MOD.ModelID                      
      ,TBL_MOD_DEF.HoneywellModel                
      ,TBL_MOD_DEF.Module_Group                
      ,TBL_MOD.ModelDescription                
      ,TBL_MOD.Quantity                
      ,(CASE               
      WHEN TBL_MOD.IsUIO=1               
      THEN ((TBL_MOD.AI_UIO_ChannelCount*TBL_MOD_DEF.AI_Heatdissipation)+(TBL_MOD.AO_UIO_ChannelCount*TBL_MOD_DEF.AO_Heatdissipation)+              
      (TBL_MOD.DI_UIO_ChannelCount*TBL_MOD_DEF.DI_Heatdissipation)+              
      (TBL_MOD.DO_UIO_ChannelCount*TBL_MOD_DEF.DO_Heatdissipation)+(TBL_MOD.IOTA_UIO_ChannelCount*TBL_MOD_DEF.IOTA_Heatdissipation))              
       ELSE TBL_MOD_DEF.Heatdissipation END)                
      ,TBL_MOD_DEF.IS_AC_COMPONENT                  
      ,TBL_MOD.OPCalc_A                
      ,TBL_MOD.OPCalc_B                
      ,TBL_MOD.OPCalc_C                
      ,TBL_MOD.OPCalc_D                
      ,TBL_MOD.OPCalc_E                
      ,TBL_MOD.OPCalc_F                
      ,TBL_MOD.OPCalc_G                
      ,TBL_MOD.OPCalc_H                
      ,TBL_MOD.OPCalc_I         
      ,0 ,        
      0              
     ,@ISBTU_HR     
     , 0 as EnclosureWATTS    
     , 0 as EnclosureConversion              
      FROM Tbl_PHT_Cabinet_Module TBL_MOD,Tbl_PHT_ModuleDef TBL_MOD_DEF,                 
      Tbl_PHT_Cabinet_Configuration TBL_CAB                
 WHERE TBL_MOD.ModelID=TBL_MOD_DEF.ModelID                 
 AND TBL_MOD.CabinetID=TBL_CAB.CabinetID                
 AND TBL_CAB.CabinetID=@CABINETID  and TBL_MOD.PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'  
 
 union all
 SELECT               
--ROW_NUMBER() OVER(ORDER BY TBL_CAB.CabinetName,TBL_MOD.PowerDrawTypeID,TBL_MOD.ModelID),                
TBL_CAB.CabinetName,                
(SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=TBL_CAB.CabinetTypeID)                
,TBL_CAB.CabinetDesc                
,(SELECT PowerDrawType FROM Tbl_PHT_Power_Draw_Type WHERE PowerDrawTypeID=TBL_MOD.PowerDrawTypeID)                
      ,TBL_CAB.Area                
      ,TBL_CAB.Location                
      ,TBL_CAB.GeneralNotes                
      ,(CASE               
      WHEN TBL_MOD.PowerDrawTypeID='8B70E2DD-2DA1-46A4-A7FF-4632742F07A1' THEN TBL_MOD.FeederType              
      ELSE              
       (CASE               
       WHEN TBL_MOD.PowerDrawTypeID IN ('CDC3713D-3F88-4B05-AE4B-5D2BD3DCC7D5','8224F746-CFB1-4C67-82EA-FE6B0E420127','5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C')               
       THEN (CASE WHEN TBL_CAB.PSUPSFeeder=0 THEN 3              
       ELSE 1 END) ELSE 1  END) END)                
      ,TBL_MOD.ModelID                      
      ,TBL_MOD_DEF.HoneywellModel                
      ,TBL_MOD_DEF.Module_Group                
      ,TBL_MOD.ModelDescription                
      ,TBL_MOD.Quantity                
      , TBL_MOD_DEF.Heatdissipation               
      ,TBL_MOD_DEF.IS_AC_COMPONENT                  
      ,TBL_MOD.OPCalc_A                
      ,TBL_MOD.OPCalc_B                
      ,TBL_MOD.OPCalc_C                
      ,TBL_MOD.OPCalc_D                
      ,TBL_MOD.OPCalc_E                
      ,TBL_MOD.OPCalc_F                
      ,TBL_MOD.OPCalc_G                
      ,TBL_MOD.OPCalc_H                
      ,TBL_MOD.OPCalc_I         
      ,0 ,        
      0              
     ,@ISBTU_HR     
     , 0 as EnclosureWATTS    
     , 0 as EnclosureConversion              
      FROM Tbl_PHT_Cabinet_Module TBL_MOD,Tbl_PHT_PowerSupply_ModuleDef TBL_MOD_DEF,                 
      Tbl_PHT_Cabinet_Configuration TBL_CAB                
 WHERE TBL_MOD.ModelID=TBL_MOD_DEF.ModelID                 
 AND TBL_MOD.CabinetID=TBL_CAB.CabinetID                
 AND TBL_CAB.CabinetID=@CABINETID   and TBL_MOD.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'              
                
            union  all
  select CabinetName,                
(SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=CONF.CabinetTypeID),CabinetDesc as CabDesc,'' as powerdrawType,Area,Location,'' as GeneralNotes,    
0 as Is_Secondary,0 as ModelID,''as HWModel,'' as Module_Group,'' as Mod_Desc,    
0 as Qty,0 as Heat,0 as IsAC,0 as A,0as B,0 as C,0 as D,0as E,0 as F,0 as G,0 as H,0 as I,0 as Vdrop,0 as PF,@ISBTU_HR,    
EnclosureSurfaceInWatts as EnclosureWATTS,    
CASE WHEN @ISBTU_HR=1 Then EnclosureSurfaceInBtu else EnclosureSurfaceInKcal end as EnclosureConversion      
from Tbl_PHT_Cabinet_Configuration CONF where ProjectId=@PROJID and CabinetID=@CABINETID    
 and EnclosureSurfaceInWatts>0   
   
   
 DECLARE @PF decimal(4,2)         
--@ProjectId        
DECLARE @AdvIsPowerFactor bit        
  SELECT @AdvIsPowerFactor=AdvIsPowerFactor FROM Tbl_PHT_Report_Setting where projectid=@PROJID         
IF(@AdvIsPowerFactor=1)        
BEGIN        
SELECT @PF=AdvPowerFactor FROM Tbl_PHT_Report_Setting where projectid=@PROJID              
END        
ELSE        
BEGIN        
SET @PF=1        
END          
              
INSERT INTO #SM_MODULE_INFO              
 (CABINETNAME,CABINETTYPE,CABDESC,PowerDrawType,Area,Location,GeneralNotes,Is_Secondary,ModelID,HWModel,Module_Group,Mod_Desc,Qty,Heat,IsAC,A,B,C,D,E,F,G,H,I,Vdrop,PF,IsBtu_hr,EnclosureWATTS,EnclosureConversion)                 
  select              
   TBL_CAB.CabinetName,CabinetTypeName,CabinetDesc,PowerDrawType              
,TBL_CAB.Area,TBL_CAB.Location,TBL_CAB.GeneralNotes,            
--CASE WHEN module_group ='Additional Power' THEN 0 ELSE             
CASE WHEN TBL_CAB.PSUPSFeeder=0 THEN 3 ELSE 1 END             
--END            
,TBL_MOD.ModelID,mod_def.HoneywellModel,mod_def.Module_Group,TBL_MOD.ModelDescription,TBL_MOD.Quantity,TBL_MOD.TotalHeat_Des_Watts,'0' as IS_AC_COMPONENT,             
--CASE WHEN IDC_Pri=0 THEN IAC_Pri            
--     WHEN IAC_Pri=0 THEN IDC_Pri END as OPCalc_A,            
 ----IDC_Pri as OPCalc_A,      
 CASE WHEN TBL_MOD.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' THEN 0       
      ELSE IDC_Pri END AS OPCalc_A,      
 '0' as OPCalc_B,'0' as OPCalc_C,'0' as OPCalc_D,IAC_Pri as OPCalc_E,(TotalHeat_Des_Watts/@PF) as OPCalc_F,TotalHeat_Des_Btu as OPCalc_G,TotalHeat_Des_Watts as OPCalc_H,TotalHeat_Des_Btu as OPCalc_I,        
 Vdrop,CASE WHEN AdvIsPowerFactor=1 THEN AdvPowerFactor ELSE 1 END as PF,  @ISBTU_HR ,    
 0 as   EnclosureWATTS,0 as   EnclosureConversion          
From Tbl_PHT_SMCabinet_Module TBL_MOD inner join Tbl_PHT_Cabinet_Configuration TBL_CAB               
ON TBL_MOD.CabinetID=TBL_CAB.CabinetID AND TBL_MOD.CabinetID=TBL_CAB.CabinetID          
inner join Tbl_PHT_Report_Setting RS on RS.ProjectID=TBL_CAB.ProjectID        
inner join Tbl_PHT_ModuleDef mod_def on mod_def.ModelID=TBL_MOD.ModelID              
inner join Tbl_PHT_Cabinet_Type CAB_TYPE ON CAB_TYPE.CabinetTypeID=TBL_CAB.CabinetTypeID              
inner join Tbl_PHT_Power_Draw_Type DRAW_TYPE ON DRAW_TYPE.PowerDrawTypeID=TBL_MOD.PowerDrawTypeID              
where TBL_MOD.CabinetID=@CABINETID and   RS.ProjectID=@PROJID  and TBL_MOD.PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'          

union all
select              
   TBL_CAB.CabinetName,CabinetTypeName,CabinetDesc,PowerDrawType              
,TBL_CAB.Area,TBL_CAB.Location,TBL_CAB.GeneralNotes,            
--CASE WHEN module_group ='Additional Power' THEN 0 ELSE             
CASE WHEN TBL_CAB.PSUPSFeeder=0 THEN 3 ELSE 1 END             
--END            
,TBL_MOD.ModelID,mod_def.HoneywellModel,mod_def.Module_Group,TBL_MOD.ModelDescription,TBL_MOD.Quantity,TBL_MOD.TotalHeat_Des_Watts,'0' as IS_AC_COMPONENT,             
--CASE WHEN IDC_Pri=0 THEN IAC_Pri            
--     WHEN IAC_Pri=0 THEN IDC_Pri END as OPCalc_A,            
 ----IDC_Pri as OPCalc_A,      
 CASE WHEN TBL_MOD.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' THEN 0       
      ELSE IDC_Pri END AS OPCalc_A,      
 '0' as OPCalc_B,'0' as OPCalc_C,'0' as OPCalc_D,IAC_Pri as OPCalc_E,(TotalHeat_Des_Watts/@PF) as OPCalc_F,TotalHeat_Des_Btu as OPCalc_G,TotalHeat_Des_Watts as OPCalc_H,TotalHeat_Des_Btu as OPCalc_I,        
 Vdrop,CASE WHEN AdvIsPowerFactor=1 THEN AdvPowerFactor ELSE 1 END as PF,  @ISBTU_HR ,    
 0 as   EnclosureWATTS,0 as   EnclosureConversion          
From Tbl_PHT_SMCabinet_Module TBL_MOD inner join Tbl_PHT_Cabinet_Configuration TBL_CAB               
ON TBL_MOD.CabinetID=TBL_CAB.CabinetID AND TBL_MOD.CabinetID=TBL_CAB.CabinetID          
inner join Tbl_PHT_Report_Setting RS on RS.ProjectID=TBL_CAB.ProjectID        
inner join Tbl_PHT_PowerSupply_ModuleDef mod_def on mod_def.ModelID=TBL_MOD.ModelID              
inner join Tbl_PHT_Cabinet_Type CAB_TYPE ON CAB_TYPE.CabinetTypeID=TBL_CAB.CabinetTypeID              
inner join Tbl_PHT_Power_Draw_Type DRAW_TYPE ON DRAW_TYPE.PowerDrawTypeID=TBL_MOD.PowerDrawTypeID              
where TBL_MOD.CabinetID=@CABINETID and   RS.ProjectID=@PROJID  and TBL_MOD.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'          
                
            union  all  
  select CabinetName,                
(SELECT CabinetTypeName FROM Tbl_PHT_Cabinet_Type WHERE CabinetTypeID=CONF.CabinetTypeID),CabinetDesc as CabDesc,'' as powerdrawType,Area,Location,'' as GeneralNotes,    
0 as Is_Secondary,0 as ModelID,''as HWModel,'' as Module_Group,'' as Mod_Desc,    
0 as Qty,0 as Heat,0 as IsAC,0 as A,0as B,0 as C,0 as D,0as E,0 as F,0 as G,0 as H,0 as I,0 as Vdrop,0 as PF,@ISBTU_HR,    
EnclosureSurfaceInWatts as EnclosureWATTS,    
CASE WHEN @ISBTU_HR=1 Then EnclosureSurfaceInBtu else EnclosureSurfaceInKcal end as EnclosureConversion      
from Tbl_PHT_Cabinet_Configuration CONF where ProjectId=@PROJID and CabinetID=@CABINETID    
  and EnclosureSurfaceInWatts>0              
            
                  
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_POC_Project]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_POC_Project]     
 -- Add the parameters for the stored procedure here    
    @ProjectId VARCHAR(1500)
AS    

Begin
       
    select TC.CabinetName,TM.OPCalc_A as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS where
 TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
and ModelDescription like '%- Front PS%' and TC.ProjectID=@ProjectId


select TC.CabinetName,TM.OPCalc_A as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_Cabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS where
 TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
and ModelDescription like '%- Rear PS%'  and TC.ProjectID=@ProjectId


select TC.CabinetName,TM.IDC_Pri as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS where
 TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
and TPS.OUTPUTVOLTAGE='24VDC' and TC.ProjectID=@ProjectId

select TC.CabinetName,TM.IDC_Pri as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS where
 TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
and TPS.OUTPUTVOLTAGE='48VDC' and TC.ProjectID=@ProjectId

select TC.CabinetName,TM.IDC_Pri as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS where
 TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
and TPS.OUTPUTVOLTAGE='60VDC' and TC.ProjectID=@ProjectId

select TC.CabinetName,TM.IDC_Pri as IDC,TPS.CurrentRating as Currentrating from Tbl_PHT_Cabinet_Configuration TC,Tbl_PHT_Project TP,Tbl_PHT_SMCabinet_Module TM,Tbl_PHT_PowerSupply_ModuleDef TPS where
 TC.CabinetID=TM.CabinetID and TP.ProjectID=TC.ProjectID and TM.ModelID=TPS.ModelID and TM.PowerDrawTypeID='5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C'
and TPS.OUTPUTVOLTAGE='110VDC' and TC.ProjectID=@ProjectId

End
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_FetchCabinetModule]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_PHT_FetchCabinetModule]
    @CabinetID UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

        SELECT  *
        FROM    Tbl_PHT_Cabinet_Module
        WHERE   CabinetID = @CabinetID
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_CabinetInfo]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_CabinetInfo]    -- '4dd6a6b5-05db-42f2-a59b-1728b8cac203'     
 -- Add the parameters for the stored procedure here          
 @PROJECTID uniqueidentifier     -- ='6E04565E-E8C2-4B18-807B-DDFCE2B77081'      
AS          
BEGIN          
          
IF 1=0 BEGIN          
    SET FMTONLY OFF          
END          
 -- SET NOCOUNT ON added to prevent extra result sets from          
 -- interfering with SELECT statements.          
 SET NOCOUNT ON;          
          
    CREATE TABLE #MODULE_INFO (ROWNUM INT,CABINETNAME VARCHAR(255),CABINETTYPE VARCHAR(100),CABDESC VARCHAR(256),PowerDrawType VARCHAR(255),Area nvarchar(256),          
 Location nvarchar(256) ,GeneralNotes nvarchar(500) ,Is_Secondary int,ModelID INT,HWModel VARCHAR(150),Module_Group VARCHAR(100),Mod_Desc varchar(500),Qty int,Heat decimal(16,2),IsAC Bit,A decimal(16,2),          
B decimal(16,2),          
C decimal(16,2),          
D decimal(16,2),          
E decimal(16,2),          
F decimal(16,2),          
G decimal(16,2),          
H decimal(16,2),          
I decimal(16,2),    
Vdrop decimal(16,2),     
PF decimal(16,2) ,        
IsBtu_hr bit,          
SIAC decimal(16,2) default 0.00,          
SVA decimal(16,2) default 0.00,          
SWatts decimal(16,2) default 0.00,          
SG decimal(16,2) default 0.00,          
SI decimal(16,2) default 0.00,          
SNDC decimal(16,2) default 0.00
,EnclosureWATTS decimal(16,2)
,EnclosureConversion decimal(16,2)
)      

          
    CREATE TABLE #SM_MODULE_INFO (ROWNUM INT,CABINETNAME VARCHAR(255),CABINETTYPE VARCHAR(100),CABDESC VARCHAR(256),PowerDrawType VARCHAR(255),Area nvarchar(256),          
 Location nvarchar(256) ,GeneralNotes nvarchar(500) ,Is_Secondary int,ModelID INT,HWModel VARCHAR(150),Module_Group VARCHAR(100),Mod_Desc varchar(500),Qty int,Heat decimal(16,2),IsAC Bit,A decimal(16,2),          
B decimal(16,2),          
C decimal(16,2),          
D decimal(16,2),          
E decimal(16,2),          
F decimal(16,2),          
G decimal(16,2),          
H decimal(16,2),          
I decimal(16,2),    
Vdrop decimal(16,2),     
PF decimal(16,2) ,          
IsBtu_hr bit,          
SIAC decimal(16,2) default 0.00,          
SVA decimal(16,2) default 0.00,          
SWatts decimal(16,2) default 0.00,          
SG decimal(16,2)default 0.00,          
SI decimal(16,2)default 0.00,          
SNDC decimal(16,2) default 0.00
,EnclosureWATTS decimal(16,2)
,EnclosureConversion decimal(16,2)
)          
          
          
          
DECLARE @CABID uniqueidentifier          
--ADDED BY SHYAMALA          
DECLARE @CABINET_TYPE AS INT      
      
--DECLARE @PF decimal(4,2)        
    
--SELECT @PF=AdvPowerFactor FROM Tbl_PHT_Report_Setting    
    
        
          
DECLARE @PF decimal(4,2)     
   
DECLARE @AdvIsPowerFactor bit    
  SELECT @AdvIsPowerFactor=AdvIsPowerFactor FROM Tbl_PHT_Report_Setting where projectid=@PROJECTID     
IF(@AdvIsPowerFactor=1)    
BEGIN    
SELECT @PF=AdvPowerFactor FROM Tbl_PHT_Report_Setting   where projectid=@PROJECTID       
END    
ELSE    
BEGIN    
SET @PF=1    
END        
        
        
        
         
          
SELECT @CABINET_TYPE=cab_type.CabinetTypeID from           
dbo.Tbl_PHT_Cabinet_Configuration config inner join Tbl_PHT_Cabinet_Type cab_type           
on config.CabinetTypeID=cab_type.CabinetTypeID where cabinetid=@CABID          
          
--ENDS HERE          
          
DECLARE PHT_CRSR_CABID CURSOR FOR          
SELECT CABINETID FROM Tbl_PHT_Cabinet_Configuration WHERE PROJECTID=@PROJECTID          
  
OPEN PHT_CRSR_CABID          
       
FETCH NEXT FROM PHT_CRSR_CABID INTO  @CABID          
          
WHILE (@@FETCH_STATUS = 0)           
BEGIN          
          
EXEC SP_PHT_RPT_Fetch_ModuleInfo @CABINETID=@CABID,@PROJID=@PROJECTID          
FETCH NEXT FROM PHT_CRSR_CABID INTO @CABID          
          
END           
          
CLOSE PHT_CRSR_CABID          
DEALLOCATE PHT_CRSR_CABID          
          --select * from #MODULE_INFO
          
  UPDATE #MODULE_INFO SET           
  SIAC = E,          
  SVA = F,          
  SWatts = H,          
  SG = G,          
  SI =I,E=0,F=0,H=0,G=0,I=0 where Is_Secondary = 2    
  
    UPDATE #MODULE_INFO SET           
  SIAC = E,          
  SVA = F,          
  SWatts = H,          
  SG = G,          
  SI =I where Is_Secondary = 3
          
  UPDATE #MODULE_INFO SET           
  SNDC = A          
  where IsAC = 0          
          
  UPDATE #MODULE_INFO SET           
  SNDC = 0          
  where IsAC = 1          
          --select * from #MODULE_INFO
  --UPDATE #MODULE_INFO SET           
  --SIAC = 0,          
  --SVA = 0,          
  --SWatts = 0,          
  --SG = 0,          
  --SI = 0 where Is_Secondary = 0          
        
         --end here 
          
    UPDATE #SM_MODULE_INFO SET           
  SIAC = E,          
  --SVA = Round(((Heat)/@PF),3),          
  SVA = Round(((Heat)/@PF),2),          
  SWatts = Heat,          
  --SG = Round((Heat*3.413),3),          
  SG = Round((Heat*3.413),2),          
  --SI =Round(((Heat*3.413)/3.968),3) where Is_Secondary = 1          
  SI =Round(((Heat*3.413)/3.968),2),E=0,F=0,H=0,G=0,I=0 where Is_Secondary = 2 
  
  UPDATE #SM_MODULE_INFO SET           
  SIAC = E,          
  --SVA = Round(((Heat)/@PF),3),          
  SVA = Round(((Heat)/@PF),2),          
  SWatts = Heat,          
  --SG = Round((Heat*3.413),3),          
  SG = Round((Heat*3.413),2),          
  --SI =Round(((Heat*3.413)/3.968),3) where Is_Secondary = 1          
  SI =Round(((Heat*3.413)/3.968),2) ,
  F=Round(((Heat)/@PF),2),H=Heat,G=Round((Heat*3.413),2),I=Round(((Heat*3.413)/3.968),2)
  where Is_Secondary = 3          
            
          
 UPDATE #SM_MODULE_INFO SET           
  SNDC = A          
  where IsAC = 0          
           
 UPDATE #SM_MODULE_INFO SET           
  SNDC = 0          
  where IsAC = 1           
            
 --UPDATE #SM_MODULE_INFO SET           
 -- SIAC = 0,          
 -- SVA = 0,          
 -- SWatts = 0,          
 -- SG = 0,          
 -- SI = 0 where Is_Secondary = 0           
            
            
            
            
 SELECT  CABINETNAME ,          
  CABINETTYPE ,CABDESC,          
 PowerDrawType, Area,          
   Location,          
   GeneralNotes,          
   Is_Secondary,          
   ModelID ,          
   HWModel ,          
   Module_Group,          
   Mod_Desc ,          
   Qty ,          
   Heat ,          
   IsAC ,          
   A ,          
  B ,          
  C,          
  D ,          
  E ,          
  F,          
  G ,          
  H ,          
  I, (CASE WHEN IsBtu_hr=1 THEN 'Btu/Hr' ELSE 'Kcal/Hr' END) as BTU_KCAL_UNIT,          
  SIAC,          
  SVA,          
  SWatts,          
  SG,          
  SI,          
  SNDC,Vdrop,PF,EnclosureWATTS
,EnclosureConversion FROM #MODULE_INFO           
           
  union ALL          
            
            
            
  SELECT  CABINETNAME ,          
  CABINETTYPE ,CABDESC,          
  PowerDrawType ,          
  Area,          
   Location,          
   GeneralNotes,          
   Is_Secondary,          
   ModelID ,          
   HWModel ,          
   Module_Group,          
   Mod_Desc ,          
   Qty ,          
   Heat ,          
   IsAC ,          
   A ,          
  B ,          
  C,          
  D ,          
  E ,          
  F,          
  G ,          
  H  ,          
  I, (CASE WHEN IsBtu_hr=1 THEN 'Btu/Hr' ELSE 'Kcal/Hr' END) as BTU_KCAL_UNIT,          
  SIAC,          
  SVA,          
  SWatts,          
  SG,          
  SI,          
  SNDC,Vdrop,PF,EnclosureWATTS
,EnclosureConversion FROM #SM_MODULE_INFO           
 order by CABINETNAME          
          
           
          
          
     DROP TABLE #MODULE_INFO          
  DROP TABLE #SM_MODULE_INFO           
          
          
END       

--Iteration-0 Scripts Ends---
--P&H3.4 Iteration-1 Scripts Ends---
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_UpdateAdvancedSettings]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_UpdateAdvancedSettings]
    @ReportSettingID UNIQUEIDENTIFIER ,
    @ProjectID UNIQUEIDENTIFIER ,
    @AdvPowerSupplyEff [decimal](10, 2) ,
    @AdvPowerFactor [decimal](10, 2) ,
    @AdvInrushCurrent [decimal](10, 2) ,
    @AdvAdmbientTemp [decimal](10, 2) ,
    @AdvPowerHeatUnit BIT ,
    @AdvIsPowerFactor BIT ,
    @Status BIT OUTPUT
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

        IF ( ( SELECT   COUNT(*)
               FROM     Tbl_PHT_Report_Setting
               WHERE    ReportSettingID = @ReportSettingID
                        AND ProjectID = @ProjectID
             ) > 0 ) 
            BEGIN
                UPDATE  [PowerHeatCalc].[dbo].[Tbl_PHT_Report_Setting]
                SET     [AdvPowerSupplyEff] = @AdvPowerSupplyEff ,
                        [AdvPowerFactor] = @AdvPowerFactor ,
                        [AdvInrushCurrent] = @AdvInrushCurrent ,
                        [AdvAdmbientTemp] = @AdvAdmbientTemp ,
                        [AdvPowerHeatUnit] = @AdvPowerHeatUnit ,
                        [AdvIsPowerFactor] = @AdvIsPowerFactor
                WHERE   ReportSettingID = @ReportSettingID
                        AND ProjectID = @ProjectID
                        
                EXEC SP_PHT_ExecuteAdvanceSettingsForProject @ProjID=@ProjectID ,@AmbientTemp= @AdvAdmbientTemp 
                SET @Status = 1
            END
        ELSE 
            BEGIN
                SET @Status = 0
            END   
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_IDC_Check]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_Update_IDC_Check] --3,'E4DC21A4-ECB9-4EF7-9D55-3EB636C176AF'
    @DCSSMFlag int ,    
    @ValCabinetID UNIQUEIDENTIFIER='00000000-0000-0000-0000-000000000000'
    AS     
    BEGIN    
        SET NOCOUNT ON   
        Declare @CabinetID uniqueidentifier, @IDCValue decimal(10,2)=0, @PSUCurrentrating decimal(10,2)=0,@IDCErrortxt nvarchar(50)='',@MAtoAmp int=1000

if(@ValCabinetID='00000000-0000-0000-0000-000000000000')
begin

declare @tblProject table (ID int, ProjectID uniqueidentifier)
insert into @tblProject(ID,ProjectID) SELECT ROW_NUMBER() OVER(ORDER BY ProjectID DESC) AS Row,ProjectID from Tbl_PHT_Project
declare @icount as int=0
declare @Feedercount as int=0
declare @i as int=1
declare @ProjectID as uniqueidentifier
declare @PSFront int =0
declare @PSRear int =0
select @icount=count(ProjectID) from @tblProject
while(@i<=@icount)
begin
select @ProjectID=ProjectID from @tblProject where ID=@i
if(@DCSSMFlag=1 or @DCSSMFlag=3)
begin
EXEC SP_PHT_ExecuteAdvanceSettingsForProject @ProjID=@ProjectID 
--select * from Tbl_PHT_Cabinet_Configuration where CabinetID='F90555F8-B8DE-4AF2-8276-9DAA968A6C0C'
end
set @i=@i+1
if(@DCSSMFlag=2 or @DCSSMFlag=3)
begin
Declare Cursor_SM cursor FAST_FORWARD FOR select CabinetID from Tbl_PHT_Cabinet_Configuration where ProjectID=@ProjectID

Open Cursor_SM      
FETCH NEXT FROM Cursor_SM INTO @CabinetID

WHILE @@FETCH_STATUS = 0      
BEGIN  
set @IDCErrortxt =''

if exists(select * from Tbl_PHT_SMCabinet_Module where CabinetID = @CabinetID)
begin
set @Feedercount=0
select @Feedercount=Count(Tbl_PHT_SMCabinet_Module.ModelID) from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@CabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='24VDC' and HoneywellModel='Feeder unit 24VDC Red.'
 if(@Feedercount=0)
 begin
select @IDCValue=isnull(sum(IDC_Pri),0)/@MAtoAmp from Tbl_PHT_SMCabinet_Module where CabinetID=@CabinetID and PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and VDC_Type=24
select @PSUCurrentrating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@CabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='24VDC'
   if(@IDCValue>@PSUCurrentrating)
       begin
       set @IDCErrortxt+='24VDC/'
       end
       end
       SET @IDCValue=0
      SET @PSUCurrentrating=0 
      set @Feedercount=0
select @Feedercount=Count(Tbl_PHT_SMCabinet_Module.ModelID) from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@CabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='48VDC' and HoneywellModel='Feeder unit 48VDC Red.'
 if(@Feedercount=0)
 begin
  select @IDCValue=isnull(sum(IDC_Pri),0)/@MAtoAmp from Tbl_PHT_SMCabinet_Module where CabinetID=@CabinetID and PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and VDC_Type=48
select @PSUCurrentrating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@CabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='48VDC'
 if(@IDCValue>@PSUCurrentrating)
       begin
       
       set @IDCErrortxt+='48VDC/'
       end
       end
      SET @IDCValue=0
      SET @PSUCurrentrating=0 
      set @Feedercount=0
select @Feedercount=Count(Tbl_PHT_SMCabinet_Module.ModelID) from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@CabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='60VDC' and HoneywellModel='Feeder unit 60VDC Red.'
 if(@Feedercount=0)
 begin
 select @IDCValue=isnull(sum(IDC_Pri),0)/@MAtoAmp from Tbl_PHT_SMCabinet_Module where CabinetID=@CabinetID and PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and VDC_Type=60
select @PSUCurrentrating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@CabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='60VDC'
 if(@IDCValue>@PSUCurrentrating)
       begin       
       set @IDCErrortxt+='60VDC/'
       end
       end
       SET @IDCValue=0
      SET @PSUCurrentrating=0 
      set @Feedercount=0
select @Feedercount=Count(Tbl_PHT_SMCabinet_Module.ModelID) from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@CabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='110VDC' and HoneywellModel='Feeder unit 110VDC Red.'
 if(@Feedercount=0)
 begin
 select @IDCValue=isnull(sum(IDC_Pri),0)/@MAtoAmp from Tbl_PHT_SMCabinet_Module where CabinetID=@CabinetID and PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and VDC_Type=110
select @PSUCurrentrating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@CabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='110VDC'
  if(@IDCValue>@PSUCurrentrating)
       begin
       set @IDCErrortxt+='110VDC/'
       end
       end
     
if(@IDCErrortxt<>'')
     begin
      Update Tbl_PHT_Cabinet_Configuration set  Is_IDCCheck =1,IDCError=LEFT(@IDCErrortxt, LEN(@IDCErrortxt) - 1) where CabinetID = @CabinetID
      end
    else
      begin
      Update Tbl_PHT_Cabinet_Configuration set  Is_IDCCheck =0,IDCError='' where CabinetID = @CabinetID
      end
      end
FETCH NEXT FROM Cursor_SM INTO @CabinetID
      
END      
CLOSE Cursor_SM      
DEALLOCATE Cursor_SM
end
end
    end
    else
    begin
    Declare @FRONTDESCTEXT nvarchar(50)='- Front PS',@REARDESCTEXT nvarchar(50)='- Rear PS',@POWERSUPPLYDCVOLTAGE int =24,@valIDCSum decimal(10,2)=0, @valCurrentRating decimal(10,2)=0
	set @IDCErrortxt =''
	if(@DCSSMFlag=1 or @DCSSMFlag=3)
begin
if exists(select * from Tbl_PHT_Cabinet_Module where Tbl_PHT_Cabinet_Module.CabinetID = @ValCabinetID)
begin
set @PSFront=0
select @PSFront=PSFront from Tbl_PHT_Cabinet_Configuration where CabinetID=@ValCabinetID and PSFront=0
if(@PSFront<>0)
begin
 select @valIDCSum=isnull(sum(case when PHCompChannelWise=1 then Tbl_PHT_Cabinet_Module.OPCalc_A else (Tbl_PHT_ModuleDef.Heatdissipation*Tbl_PHT_Cabinet_Module.Quantity)/@POWERSUPPLYDCVOLTAGE end),0) from Tbl_PHT_Cabinet_Configuration inner join 
      Tbl_PHT_Cabinet_Module on Tbl_PHT_Cabinet_Configuration.CabinetID=Tbl_PHT_Cabinet_Module.CabinetID inner join 
      Tbl_PHT_ModuleDef on Tbl_PHT_Cabinet_Module.ModelID=Tbl_PHT_ModuleDef.ModelID inner join Tbl_PHT_Power_Draw_Type on 
      Tbl_PHT_Power_Draw_Type.PowerDrawTypeID=Tbl_PHT_Cabinet_Module.PowerDrawTypeID  where Tbl_PHT_Cabinet_Module.CabinetID = @ValCabinetID  and Tbl_PHT_Power_Draw_Type.PowerDrawType='24VDC PS(Front Side)-Power Draw' 
      
       select @valCurrentRating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_Cabinet_Configuration inner join 
      Tbl_PHT_Cabinet_Module on Tbl_PHT_Cabinet_Configuration.CabinetID=Tbl_PHT_Cabinet_Module.CabinetID inner join 
      Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_Cabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID inner join Tbl_PHT_Power_Draw_Type on 
      Tbl_PHT_Power_Draw_Type.PowerDrawTypeID=Tbl_PHT_Cabinet_Module.PowerDrawTypeID  where Tbl_PHT_Cabinet_Module.CabinetID = @ValCabinetID  and Tbl_PHT_Power_Draw_Type.PowerDrawType='Power Supply' 
      and Tbl_PHT_Cabinet_Module.ModelDescription like '%'+@FRONTDESCTEXT+'%'
      
       if(@valIDCSum>@valCurrentRating)
       begin
       set @IDCErrortxt+='Front/'
       end
       end
       
       set @valIDCSum=0
       set @valCurrentRating=0
       set @PSRear=0
        select @PSRear=PSRear from Tbl_PHT_Cabinet_Configuration where CabinetID=@ValCabinetID and PSRear=0
        if(@PSRear<>0)
begin
        select @valIDCSum=isnull(sum(case when PHCompChannelWise=1 then Tbl_PHT_Cabinet_Module.OPCalc_A else (Tbl_PHT_ModuleDef.Heatdissipation*Tbl_PHT_Cabinet_Module.Quantity)/@POWERSUPPLYDCVOLTAGE end),0) from Tbl_PHT_Cabinet_Configuration inner join 
      Tbl_PHT_Cabinet_Module on Tbl_PHT_Cabinet_Configuration.CabinetID=Tbl_PHT_Cabinet_Module.CabinetID inner join 
      Tbl_PHT_ModuleDef on Tbl_PHT_Cabinet_Module.ModelID=Tbl_PHT_ModuleDef.ModelID inner join Tbl_PHT_Power_Draw_Type on 
      Tbl_PHT_Power_Draw_Type.PowerDrawTypeID=Tbl_PHT_Cabinet_Module.PowerDrawTypeID  where Tbl_PHT_Cabinet_Module.CabinetID = @ValCabinetID  and Tbl_PHT_Power_Draw_Type.PowerDrawType='24VDC PS(Rear Side)-Power Draw' 
      
       select @valCurrentRating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_Cabinet_Configuration inner join 
      Tbl_PHT_Cabinet_Module on Tbl_PHT_Cabinet_Configuration.CabinetID=Tbl_PHT_Cabinet_Module.CabinetID inner join 
      Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_Cabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID inner join Tbl_PHT_Power_Draw_Type on 
      Tbl_PHT_Power_Draw_Type.PowerDrawTypeID=Tbl_PHT_Cabinet_Module.PowerDrawTypeID  where Tbl_PHT_Cabinet_Module.CabinetID = @ValCabinetID  and Tbl_PHT_Power_Draw_Type.PowerDrawType='Power Supply' 
      and Tbl_PHT_Cabinet_Module.ModelDescription like '%'+@REARDESCTEXT+'%'
      if(@valIDCSum>@valCurrentRating)
       begin
       set @IDCErrortxt+='Rear/'
       end
     end
     if(@IDCErrortxt<>'')
     begin
      Update Tbl_PHT_Cabinet_Configuration set  Is_IDCCheck =1,IDCError=LEFT(@IDCErrortxt, LEN(@IDCErrortxt) - 1) where CabinetID = @ValCabinetID
      end
      else
         begin
      Update Tbl_PHT_Cabinet_Configuration set  Is_IDCCheck =0,IDCError='' where CabinetID = @ValCabinetID
      end
      end
END
if(@DCSSMFlag=2 or @DCSSMFlag=3)
begin

if exists(select * from Tbl_PHT_SMCabinet_Module where CabinetID = @ValCabinetID)
begin

set @Feedercount=0
select @Feedercount=Count(Tbl_PHT_SMCabinet_Module.ModelID) from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@ValCabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='24VDC' and HoneywellModel='Feeder unit 24VDC Red.'
 if(@Feedercount=0)
 begin
select @valIDCSum=isnull(sum(IDC_Pri),0)/@MAtoAmp from Tbl_PHT_SMCabinet_Module where CabinetID=@ValCabinetID and PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and VDC_Type=24
select @valCurrentRating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@ValCabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='24VDC'
   if(@valIDCSum>@valCurrentRating)
       begin
       set @IDCErrortxt+='24VDC/'
       end
       end
       set @valIDCSum=0
       set @valCurrentRating=0
       set @Feedercount=0
select @Feedercount=Count(Tbl_PHT_SMCabinet_Module.ModelID) from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@ValCabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='48VDC' and HoneywellModel='Feeder unit 48VDC Red.'
 if(@Feedercount=0)
 begin
  select @valIDCSum=isnull(sum(IDC_Pri),0)/@MAtoAmp from Tbl_PHT_SMCabinet_Module where CabinetID=@ValCabinetID and PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and VDC_Type=48
select @valCurrentRating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@ValCabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='48VDC'
 if(@valIDCSum>@valCurrentRating)
       begin
       set @IDCErrortxt+='48VDC/'
       end
       end
       set @valIDCSum=0
       set @valCurrentRating=0
       set @Feedercount=0
select @Feedercount=Count(Tbl_PHT_SMCabinet_Module.ModelID) from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@ValCabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='60VDC' and HoneywellModel='Feeder unit 60VDC Red.'
 if(@Feedercount=0)
 begin
 select @valIDCSum=isnull(sum(IDC_Pri),0)/@MAtoAmp from Tbl_PHT_SMCabinet_Module where CabinetID=@ValCabinetID and PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and VDC_Type=60
select @valCurrentRating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@ValCabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='60VDC'
 if(@valIDCSum>@valCurrentRating)
       begin
       set @IDCErrortxt+='60VDC/'
       end
       end
       set @valIDCSum=0
       set @valCurrentRating=0
       set @Feedercount=0
select @Feedercount=Count(Tbl_PHT_SMCabinet_Module.ModelID) from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@ValCabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='110VDC' and HoneywellModel='Feeder unit 110VDC Red.'
 if(@Feedercount=0)
 begin
 select @valIDCSum=isnull(sum(IDC_Pri),0)/@MAtoAmp from Tbl_PHT_SMCabinet_Module where CabinetID=@ValCabinetID and PowerDrawTypeID<>'5B6D1A10-864D-46BF-A58D-1CAD19ABAA2C' and VDC_Type=110
select @valCurrentRating=Tbl_PHT_PowerSupply_ModuleDef.CurrentRating from Tbl_PHT_SMCabinet_Module inner join Tbl_PHT_PowerSupply_ModuleDef on Tbl_PHT_SMCabinet_Module.ModelID=Tbl_PHT_PowerSupply_ModuleDef.ModelID
 where CabinetID=@ValCabinetID and Tbl_PHT_PowerSupply_ModuleDef.OutPutVoltage='110VDC'
  if(@valIDCSum>@valCurrentRating)
       begin
       set @IDCErrortxt+='110VDC/'
       end
       end
if(@IDCErrortxt<>'')
     begin
      Update Tbl_PHT_Cabinet_Configuration set  Is_IDCCheck =1,IDCError=LEFT(@IDCErrortxt, LEN(@IDCErrortxt) - 1) where CabinetID = @ValCabinetID
      end
    else
         begin
      Update Tbl_PHT_Cabinet_Configuration set  Is_IDCCheck =0,IDCError='' where CabinetID = @ValCabinetID
      end
    end
     end
     end
        end
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_RPT_Fetch_Summary]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PHT_RPT_Fetch_Summary]             
 -- Add the parameters for the stored procedure here            
 @ProjectId uniqueidentifier,            
 @GroupBy varchar(500),            
 @SortBy varchar(500)             
AS            
BEGIN            
 -- SET NOCOUNT ON added to prevent extra result sets from            
 -- interfering with SELECT statements.            
            
IF 1=0 BEGIN            
    SET FMTONLY OFF            
END            
 -- SET NOCOUNT ON added to prevent extra result sets from            
 -- interfering with SELECT statements.            
 SET NOCOUNT ON;            
            
    CREATE TABLE #MODULE_INFO (          
    ROWNUM INT IDENTITY NOT NULL PRIMARY KEY,                   
    CABINETNAME VARCHAR(255),CABINETTYPE VARCHAR(100),CABDESC VARCHAR(256),PowerDrawType VARCHAR(255),Area nvarchar(256),            
 Location nvarchar(256),GeneralNotes nvarchar(500),Is_Secondary bit,ModelID INT,HWModel VARCHAR(150),Module_Group VARCHAR(100),Mod_Desc varchar(500),Qty int,Heat decimal(16,2),IsAC Bit,A decimal(16,2),            
B decimal(16,2),            
C decimal(16,2),            
D decimal(16,2),            
E decimal(16,2),            
F decimal(16,2),            
G decimal(16,2),            
H decimal(16,2),            
I decimal(16,2),       
Vdrop decimal(16,2) ,        
PF decimal(16,2) ,         
IsBtu_hr bit,
EnclosureWATTS decimal(16,2),
EnclosureConversion decimal(16,2)
            
)       

 CREATE TABLE #MISCELLENEOUSMODULE_INFO (          
    ROWNUM INT IDENTITY NOT NULL PRIMARY KEY,                   
    CABINETNAME VARCHAR(255),CABINETTYPE VARCHAR(100),CABDESC VARCHAR(256),Area nvarchar(256),            
 Location nvarchar(256),GeneralNotes nvarchar(500),Is_Secondary bit,ModelID INT,HWModel VARCHAR(150),Module_Group VARCHAR(100),Mod_Desc varchar(500),Qty int,Heat decimal(16,2),IsAC Bit,A decimal(16,2),            
B decimal(16,2),            
C decimal(16,2),            
D decimal(16,2),            
E decimal(16,2),            
F decimal(16,2),            
G decimal(16,2),            
H decimal(16,2),            
I decimal(16,2),       
Vdrop decimal(16,2) ,        
PF decimal(16,2) ,         
IsBtu_hr bit,
EnclosureWATTS decimal(16,2),
EnclosureConversion decimal(16,2)
            
)      
            
            
      CREATE TABLE #SM_MODULE_INFO (          
    ROWNUM INT IDENTITY NOT NULL PRIMARY KEY,                   
    CABINETNAME VARCHAR(255),CABINETTYPE VARCHAR(100),CABDESC VARCHAR(256),PowerDrawType VARCHAR(255),Area nvarchar(256),            
 Location nvarchar(256),GeneralNotes nvarchar(500),Is_Secondary bit,ModelID INT,HWModel VARCHAR(150),Module_Group VARCHAR(100),Mod_Desc varchar(500),Qty int,Heat decimal(16,2),IsAC Bit,A decimal(16,2),            
B decimal(16,2),            
C decimal(16,2),            
D decimal(16,2),            
E decimal(16,2),            
F decimal(16,2),            
G decimal(16,2),            
H decimal(16,2),            
I decimal(16,2),        
Vdrop decimal(16,2)   ,          
PF decimal(16,2) ,       
IsBtu_hr bit  ,
EnclosureWATTS decimal(16,2),
EnclosureConversion decimal(16,2)          
)            
            
            
DECLARE @CABID uniqueidentifier            
            
DECLARE PHT_CRSR_CABID CURSOR FOR            
            
SELECT CABINETID FROM Tbl_PHT_Cabinet_Configuration WHERE PROJECTID=@PROJECTID            
            
OPEN PHT_CRSR_CABID            
            
FETCH NEXT FROM PHT_CRSR_CABID INTO  @CABID            
            
WHILE (@@FETCH_STATUS = 0)             
BEGIN            
            
EXEC SP_PHT_RPT_Fetch_ModuleInfo @CABINETID=@CABID  ,@PROJID=@ProjectId               
            
FETCH NEXT FROM PHT_CRSR_CABID INTO @CABID            
            
END             
            
CLOSE PHT_CRSR_CABID            
DEALLOCATE PHT_CRSR_CABID            
            
DECLARE @QRY NVARCHAR(MAX)            
            
SET @QRY='SELECT DISTINCT CABINETNAME ,CABINETTYPE ,CABDESC,PowerDrawType ,Area,Location ,Is_Secondary,HWModel ,Mod_Desc ,Qty ,          
(CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN  cast(Round(F,2) as Decimal(16,2)) ELSE 0 END) AS VA,          
(CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN  cast(Round(H,2) as Decimal(16,2)) ELSE 0 END)  AS WATTS,          
(CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN (CASE WHEN IsBtu_hr=1 THEN  cast(Round(G,2) as Decimal(16,2)) ELSE  cast(Round(I,2) as Decimal(16,2)) END) ELSE 0 END)  AS BTU_KCAL,          
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'')THEN  cast(Round(F,2) as Decimal(16,2)) ELSE 0 END) AS VA_SEC,          
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN  cast(Round(H,2) as Decimal(16,2)) ELSE 0 END) AS WATTS_SEC,          
(CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN (CASE WHEN IsBtu_hr=1 THEN  cast(Round(G,2) as Decimal(16,2)) ELSE  cast(Round(I,2) as Decimal(16,2)) END) ELSE 0 END) AS BTU_KCAL_SEC,          
(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN  cast(Round(F,2) as Decimal(16,2)) ELSE 0 END) AS VA_UTIL,          
(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN  cast(Round(H,2) as Decimal(16,2)) ELSE 0 END)  AS WATTS_UTIL,          
(CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN (CASE WHEN IsBtu_hr=1 THEN  cast(Round(G,2) as Decimal(16,2)) ELSE  cast(Round(I,2) as Decimal(16,2)) END) ELSE 0 END)  AS BTU_KCAL_UTIL,          
(CASE WHEN IsBtu_hr=1 THEN ''Btu/Hr'' ELSE ''Kcal/Hr'' END) as BTU_KCAL_UNIT,Vdrop,PF,EnclosureWATTS,EnclosureConversion     FROM #MODULE_INFO '          


--SET @QRY=@QRY+ ' union ' + 
--'SELECT DISTINCT CABINETNAME ,CABINETTYPE ,CABDESC,PowerDrawType ,Area,Location ,Is_Secondary,HWModel ,Mod_Desc ,Qty ,          
--(cast(Round(F,2) as Decimal(16,2))) AS VA,          
--(cast(Round(H,2) as Decimal(16,2)))  AS WATTS,          
--(cast(Round(G,2) as Decimal(16,2)))  AS BTU_KCAL,          
--(CASE WHEN (Is_Secondary=1)THEN  cast(Round(F,2) as Decimal(16,2)) ELSE 0 END) AS VA_SEC,          
--(CASE WHEN (Is_Secondary=1) THEN  cast(Round(H,2) as Decimal(16,2)) ELSE 0 END) AS WATTS_SEC,          
--(CASE WHEN (Is_Secondary=1) THEN (CASE WHEN IsBtu_hr=1 THEN  cast(Round(G,2) as Decimal(16,2)) ELSE  cast(Round(I,2) as Decimal(16,2)) END) ELSE 0 END) AS BTU_KCAL_SEC,          
--(cast(Round(F,2) as Decimal(16,2))) AS VA_UTIL,          
--(cast(Round(H,2) as Decimal(16,2)))  AS WATTS_UTIL,          
--(CASE WHEN IsBtu_hr=1 THEN  cast(Round(G,2) as Decimal(16,2)) ELSE 0 END)  AS BTU_KCAL_UTIL,          
--(CASE WHEN IsBtu_hr=1 THEN ''Btu/Hr'' ELSE ''Kcal/Hr'' END) as BTU_KCAL_UNIT,Vdrop,PF,EnclosureWATTS,EnclosureConversion     FROM #MISCELLENEOUSMODULE_INFO '          
            
--SET @GroupBy=' GROUP BY Area'            
            
--Exec (@QRY+@GroupBy)            
DECLARE @PF decimal(4,2)       
--@ProjectId      
DECLARE @AdvIsPowerFactor bit      
  SELECT @AdvIsPowerFactor=AdvIsPowerFactor FROM Tbl_PHT_Report_Setting where projectid=@ProjectId       
IF(@AdvIsPowerFactor=1)      
BEGIN      
SELECT @PF=AdvPowerFactor FROM Tbl_PHT_Report_Setting   where projectid=@ProjectId         
END      
ELSE      
BEGIN      
SET @PF=1      
END      
--print 'PF' + Convert(Decimal(4,2),@PF)          
          
          
SET @QRY=@QRY+ ' union ' +          
          
  'SELECT DISTINCT CABINETNAME ,CABINETTYPE ,CABDESC,PowerDrawType ,Area,Location ,Is_Secondary,HWModel ,Mod_Desc ,Qty,          
  CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN Cast(Round(((Heat)/'+Convert(varchar(50),@PF)+'),2) as Decimal(16,2)) ELSE 0 END AS VA,          
  CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN Heat ELSE 0 END as WATTS,          
  (CASE WHEN PowerDrawType<>''Utility / Service-Power Draw'' THEN (CASE WHEN IsBtu_hr=1 THEN Cast(Round((Heat*3.413),2) as Decimal(16,2)) ELSE Cast(Round(((Heat*3.413)/3.968),2) as Decimal(16,2)) END) ELSE 0 END)  AS BTU_KCAL,          
  (CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN Cast(Round(((Heat)/'+Convert(varchar(50),@PF)+'),2) as Decimal(16,2)) ELSE 0 END) AS VA_SEC,          
  (CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN Heat ELSE 0 END) AS WATTS_SEC,          
  (CASE WHEN (Is_Secondary=1 AND PowerDrawType<>''Utility / Service-Power Draw'') THEN (CASE WHEN IsBtu_hr=1 THEN Cast(Round((Heat*3.413),2) as Decimal(16,2)) ELSE Cast(Round(((Heat*3.413)/3.968),2) as Decimal(16,2)) END) ELSE 0 END) AS BTU_KCAL_SEC,     
  (CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN Cast(Round(((Heat)/'+Convert(varchar(50),@PF)+'),2) as Decimal(16,2)) ELSE 0 END) AS VA_UTIL,          
  (CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN Heat ELSE 0 END)  AS WATTS_UTIL,          
  (CASE WHEN PowerDrawType=''Utility / Service-Power Draw'' THEN (CASE WHEN IsBtu_hr=1 THEN G ELSE I END) ELSE 0 END)  AS BTU_KCAL_UTIL,          
  (CASE WHEN IsBtu_hr=1 THEN ''Btu/Hr'' ELSE ''Kcal/Hr'' END) as BTU_KCAL_UNIT ,Vdrop,PF ,EnclosureWATTS,EnclosureConversion  
   FROM #SM_MODULE_INFO'           
          
        
            
IF(LEN(@SortBy)>0)            
BEGIN            
SET @QRY=@QRY+ ' ORDER BY ' + @SortBy            
END            
            
           
           
           
          
      print @QRY  
           
Exec (@QRY)            
          
          
          
            
DROP TABLE #MODULE_INFO            
            
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_Update_Cabinet_Module_SM]    Script Date: 06/09/2017 21:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PHT_Update_Cabinet_Module_SM]          
      @CabinetModuleID UNIQUEIDENTIFIER ,        
      @CabinetID UNIQUEIDENTIFIER,        
      @GroupID INT,        
      @PowerDrawTypeID UNIQUEIDENTIFIER,        
      @ModelID Int,        
      @ModelDescription  NVARCHAR(256),        
      @Quantity int,        
      @Is_Redundant BIt,        
      @Is_RUISO BIT,        
      @IS_DO BIT,        
      @LOAD decimal(16,3), 
      @nChan int,        
      @IsUse_HeatCalc BIT,        
      @IS_FTA BIT,        
      @AI_RUSIO_ChannelCount int,        
      @AO_RUSIO_ChannelCount int,        
      @DI_RUSIO_ChannelCount int,        
      @DO_RUSIO_ChannelCount int,              
      @IDC_Pri [decimal](16, 3),         
      @IAC_Pri [decimal](16,3),         
      @TotalHeat_Des_Watts [decimal](16, 3),         
      @TotalHeat_Des_Btu [decimal](16, 3),         
      @Total_Current [decimal](16, 3),         
      @IAC_Sec [decimal](16, 3),         
      @RowNum int,        
      @VDC_Type int,      
      @VDrop decimal(18,3), 
      @TOTALVA DECIMAL(16,2),     
      @Status BIT OUTPUT          
AS           
    BEGIN          
        SET NOCOUNT ON   
        DECLARE @POWERDRAW UNIQUEIDENTIFIER  
        DECLARE @24IO BIT  
        DECLARE @48IO BIT  
        DECLARE @60IO BIT  
        DECLARE @110IO BIT  
        DECLARE @220IO BIT  
          
        SELECT @POWERDRAW=PowerDrawTypeID FROM Tbl_PHT_Power_Draw_Type WHERE PowerDrawType='Utility / Service-Power Draw'  
        IF(@POWERDRAW=@PowerDrawTypeID)  
        BEGIN  
                SELECT @24IO=[24V_IO],@48IO=[48V_IO],@60IO=[60V_IO],@110IO=[110V_IO],@220IO=[220V_IO] FROM Tbl_PHT_ModuleDef WHERE MODELID=@ModelID  
                IF(@24IO=1)  
                  SET @VDC_Type=24  
                ELSE IF(@48IO=1)  
                   SET @VDC_Type=48  
                ELSE IF(@60IO=1)  
                   SET @VDC_Type=60  
                ELSE IF(@110IO=1)  
                   SET @VDC_Type=110     
               ELSE IF(@220IO=1)  
                   SET @VDC_Type=220  
        END  
                  
        IF ( ( SELECT   COUNT(*)          
               FROM    [dbo].Tbl_PHT_SMCabinet_Module          
               WHERE    [CabinetModuleID] = @CabinetModuleID          
             ) > 0 )           
            BEGIN          
                UPDATE  [dbo].Tbl_PHT_SMCabinet_Module          
                --     [CabinetModuleID] = @CabinetID , commented by karthik to avoid duplication          
                        
                SET          
       [GroupID] = @GroupID        
      ,[PowerDrawTypeID]=@PowerDrawTypeID        
      ,[ModelID]=@ModelID        
      ,[ModelDescription]=@ModelDescription        
      ,[Quantity]=@Quantity        
      ,[Is_Redundant]=@Is_Redundant        
      ,[Is_RUISO]=@Is_RUISO        
      ,[IS_DO]=@IS_DO        
      ,[Load]=@LOAD     
      ,Devices_OnBoards=@nChan   
      ,[AI_RUSIO_ChannelCount]=@AI_RUSIO_ChannelCount        
      ,[AO_RUSIO_ChannelCount]=@AO_RUSIO_ChannelCount        
      ,[DI_RUSIO_ChannelCount]=@DI_RUSIO_ChannelCount        
      ,[DO_RUSIO_ChannelCount]=@DO_RUSIO_ChannelCount                 
      ,[IDC_Pri]=@IDC_Pri        
      ,[IAC_Pri]=@IAC_Pri        
      ,[TotalHeat_Des_Watts]=@TotalHeat_Des_Watts        
      ,[TotalHeat_Des_Btu]=@TotalHeat_Des_Btu        
      ,[Total_Current]=@Total_Current        
      ,[IAC_Sec]=@IAC_Sec        
      ,UseIn_HeatCalc=@IsUse_HeatCalc        
      ,IS_FTA=@IS_FTA        
      ,VDC_Type=@VDC_Type      
      ,VDrop=@VDrop  
      , TotalVA=@TOTALVA   
      ,[RowNum]=@RowNum        
    WHERE [CabinetModuleID] = @CabinetModuleID          
                          
              
            END          
        ELSE           
            BEGIN          
                INSERT  INTO [dbo].Tbl_PHT_SMCabinet_Module          
                        ([CabinetModuleID]        
        ,[CabinetID]        
        ,[GroupID]        
        ,[PowerDrawTypeID]        
        ,[ModelID]        
        ,[ModelDescription]        
        ,[Quantity]        
        ,[Is_Redundant]        
        ,[Is_RUISO]        
        ,[IS_DO]        
        ,[AI_RUSIO_ChannelCount]        
        ,[AO_RUSIO_ChannelCount]        
        ,[DI_RUSIO_ChannelCount]        
        ,[DO_RUSIO_ChannelCount]               
        ,[IDC_Pri]        
        ,[IAC_Pri]        
        ,[TotalHeat_Des_Watts]        
        ,[TotalHeat_Des_Btu]        
        ,[Total_Current]        
        ,[IAC_Sec]        
        ,[RowNum]            
        ,[Load]    
        ,Devices_OnBoards         
         ,UseIn_HeatCalc        
        ,IS_FTA          
        ,VDC_Type        
          ,VDrop ,TotalVA                  
                        )          
                        SELECT  @CabinetModuleID        
        ,@CabinetID        
        ,@GroupID        
        ,@PowerDrawTypeID        
        ,@ModelID        
        ,@ModelDescription        
        ,@Quantity        
        ,@Is_Redundant        
        ,@Is_RUISO        
        ,@IS_DO        
        ,@AI_RUSIO_ChannelCount        
        ,@AO_RUSIO_ChannelCount        
        ,@DI_RUSIO_ChannelCount        
        ,@DO_RUSIO_ChannelCount              
        ,@IDC_Pri        
        ,@IAC_Pri        
      ,@TotalHeat_Des_Watts        
        ,@TotalHeat_Des_Btu        
        ,@Total_Current        
        ,@IAC_Sec        
        ,@RowNum           
        ,@LOAD     
        ,@nChan      
        ,@IsUse_HeatCalc          
        ,@IS_FTA          
        ,@VDC_Type       
    ,@VDrop,@TOTALVA                       
            END          
        SET @Status = 1    
        EXEC  SP_PHT_Update_IDC_Check @DCSSMFlag=2,@ValCabinetID=@CabinetID      
    END
GO
/****** Object:  StoredProcedure [dbo].[SP_PHT_AdvSetting_Update_SM]    Script Date: 06/09/2017 21:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_PHT_AdvSetting_Update_SM]  
@SMCabinet Type_PHT_AdvSetting_Update_SMCabinet Readonly        
as    
   begin
   
--Declare @SMCabinet Type_PHT_AdvSetting_Update_SMCabinet   
--Insert into @SMCabinet (CabinetModuleID, TotalHeat_Des_Watts, TotalHeat_Des_Btu, IDC_Pri)  
--Values   
--('41D99D94-0A7D-44BF-8150-008471B37878', '0.000', '1999.998', '6478.209')  ,  
--('E6713084-45D0-43C3-9FE6-00A674C748A5', '1009006870.000', '26103110.000', '84635420.000'),   
--('546C5772-3A96-4E28-A193-04C757B172F6', '3840.000', '109.800', '356.010'),   
--('1C11317E-963C-4899-A0A6-06E502E6BF9C', '0.000', '0.000', '0.000')  
  
  
  
--CabinetModuleID, TotalHeat_Des_Watts, TotalHeat_Des_Btu, IDC_Pri  
Declare @CabinetModuleID varchar(40),@CabinetID varchar(40), @TotalHeat_Des_Watts varchar(40), @TotalHeat_Des_Btu varchar(40), @IDC_Pri Varchar(40), @IAC_Pri Varchar(40),
@TotalVA decimal(9,2)  
Declare @UpdateQuery varchar(max)   
  
Declare Cursor_SMCabinet cursor FAST_FORWARD FOR SELECT * FROM @SMCabinet  
  
Open Cursor_SMCabinet        
FETCH NEXT FROM Cursor_SMCabinet INTO @CabinetModuleID, @TotalHeat_Des_Watts, @TotalHeat_Des_Btu, @IDC_Pri,@IAC_Pri,@TotalVA  
  
WHILE @@FETCH_STATUS = 0        
BEGIN    
  
  
Update Tbl_PHT_SMCabinet_Module set  TotalHeat_Des_Watts = @TotalHeat_Des_Watts, TotalHeat_Des_Btu = @TotalHeat_Des_Btu, IDC_Pri = @IDC_Pri,  
IAC_Pri=@IAC_Pri,TotalVA=@TotalVA where  CabinetModuleID = cast(@CabinetModuleID as uniqueidentifier);  
  --select top 1 @CabinetID=CabinetID from Tbl_PHT_SMCabinet_Module where CabinetModuleID=@CabinetModuleID
  

  
FETCH NEXT FROM Cursor_SMCabinet INTO @CabinetModuleID, @TotalHeat_Des_Watts, @TotalHeat_Des_Btu, @IDC_Pri,@IAC_Pri,@TotalVA  
        
END        
CLOSE Cursor_SMCabinet        
DEALLOCATE Cursor_SMCabinet
EXEC  SP_PHT_Update_IDC_Check @DCSSMFlag=2
end
GO
/****** Object:  Default [DF__Tbl_PHT_Mo__nWDG__0F624AF8]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_ModuleDef] ADD  DEFAULT ((0)) FOR [nWDG]
GO
/****** Object:  Default [DF__Tbl_PHT_M__24V_I__10566F31]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_ModuleDef] ADD  DEFAULT ((0)) FOR [24V_IO]
GO
/****** Object:  Default [DF__Tbl_PHT_M__48V_I__114A936A]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_ModuleDef] ADD  DEFAULT ((0)) FOR [48V_IO]
GO
/****** Object:  Default [DF__Tbl_PHT_M__60V_I__123EB7A3]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_ModuleDef] ADD  DEFAULT ((0)) FOR [60V_IO]
GO
/****** Object:  Default [DF__Tbl_PHT_M__110V___1332DBDC]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_ModuleDef] ADD  DEFAULT ((0)) FOR [110V_IO]
GO
/****** Object:  Default [DF__Tbl_PHT_M__220V___14270015]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_ModuleDef] ADD  DEFAULT ((0)) FOR [220V_IO]
GO
/****** Object:  Default [DF__Tbl_PHT_P__Curre__2DB1C7EE]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_PowerSupply_ModuleDef] ADD  CONSTRAINT [DF__Tbl_PHT_P__Curre__2DB1C7EE]  DEFAULT ((0)) FOR [CurrentRating]
GO
/****** Object:  Default [DF__Tbl_PHT_R__Total__160F4887]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_RUSIO_SM] ADD  DEFAULT ((0)) FOR [TotalPower]
GO
/****** Object:  Default [DF__tbl_PHT_S__IsRus__17036CC0]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[tbl_PHT_SM_Units] ADD  DEFAULT ((0)) FOR [IsRusio]
GO
/****** Object:  Default [DF__tbl_PHT_SM__Load__17F790F9]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[tbl_PHT_SM_Units] ADD  DEFAULT ((0)) FOR [Load]
GO
/****** Object:  Default [DF__Tbl_PHT_S__Vdrop__18EBB532]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_SMCabinet_Module] ADD  DEFAULT ((0)) FOR [Vdrop]
GO
/****** Object:  ForeignKey [FK_Tbl_PH_Cabinet_Configuration_Tbl_PH_Cabinet_Type]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Configuration]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PH_Cabinet_Configuration_Tbl_PH_Cabinet_Type] FOREIGN KEY([CabinetTypeID])
REFERENCES [dbo].[Tbl_PHT_Cabinet_Type] ([CabinetTypeID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Configuration] CHECK CONSTRAINT [FK_Tbl_PH_Cabinet_Configuration_Tbl_PH_Cabinet_Type]
GO
/****** Object:  ForeignKey [FK_Tbl_PH_Cabinet_Configuration_Tbl_PH_Project]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Configuration]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PH_Cabinet_Configuration_Tbl_PH_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Tbl_PHT_Project] ([ProjectID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Configuration] CHECK CONSTRAINT [FK_Tbl_PH_Cabinet_Configuration_Tbl_PH_Project]
GO
/****** Object:  ForeignKey [FK_Tbl_PH_Cabinet_Module_Tbl_PH_Cabinet_Configuration]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Module]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PH_Cabinet_Module_Tbl_PH_Cabinet_Configuration] FOREIGN KEY([CabinetID])
REFERENCES [dbo].[Tbl_PHT_Cabinet_Configuration] ([CabinetID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Module] CHECK CONSTRAINT [FK_Tbl_PH_Cabinet_Module_Tbl_PH_Cabinet_Configuration]
GO
/****** Object:  ForeignKey [FK_Tbl_PH_Cabinet_Module_Tbl_PH_Power_Draw_Type]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Module]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PH_Cabinet_Module_Tbl_PH_Power_Draw_Type] FOREIGN KEY([PowerDrawTypeID])
REFERENCES [dbo].[Tbl_PHT_Power_Draw_Type] ([PowerDrawTypeID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Module] CHECK CONSTRAINT [FK_Tbl_PH_Cabinet_Module_Tbl_PH_Power_Draw_Type]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_Cabinet_Temp_Tbl_PH_Cabinet_Configuration]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Module]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_Cabinet_Temp_Tbl_PH_Cabinet_Configuration] FOREIGN KEY([CabinetID])
REFERENCES [dbo].[Tbl_PHT_Cabinet_Configuration] ([CabinetID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Module] CHECK CONSTRAINT [FK_Tbl_PHT_Cabinet_Temp_Tbl_PH_Cabinet_Configuration]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_Cabinet_Temp_Tbl_PHT_Cabinet_Configuration]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Temp]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_Cabinet_Temp_Tbl_PHT_Cabinet_Configuration] FOREIGN KEY([CabTempID])
REFERENCES [dbo].[Tbl_PHT_Cabinet_Temp] ([CabTempID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Temp] CHECK CONSTRAINT [FK_Tbl_PHT_Cabinet_Temp_Tbl_PHT_Cabinet_Configuration]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_Cabinet_Temp_Tbl_PHT_Cabinet_Temp]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Temp]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_Cabinet_Temp_Tbl_PHT_Cabinet_Temp] FOREIGN KEY([CabTempID])
REFERENCES [dbo].[Tbl_PHT_Cabinet_Temp] ([CabTempID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Cabinet_Temp] CHECK CONSTRAINT [FK_Tbl_PHT_Cabinet_Temp_Tbl_PHT_Cabinet_Temp]
GO
/****** Object:  ForeignKey [FK_tbl_PHT_Groups_tbl_PHT_Group_Type]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[tbl_PHT_Groups]  WITH CHECK ADD  CONSTRAINT [FK_tbl_PHT_Groups_tbl_PHT_Group_Type] FOREIGN KEY([Group_Type])
REFERENCES [dbo].[tbl_PHT_Group_Type] ([GroupType_ID])
GO
ALTER TABLE [dbo].[tbl_PHT_Groups] CHECK CONSTRAINT [FK_tbl_PHT_Groups_tbl_PHT_Group_Type]
GO
/****** Object:  ForeignKey [FK_tbl_PHT_Groups_Tbl_PHT_Project]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[tbl_PHT_Groups]  WITH CHECK ADD  CONSTRAINT [FK_tbl_PHT_Groups_Tbl_PHT_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Tbl_PHT_Project] ([ProjectID])
GO
ALTER TABLE [dbo].[tbl_PHT_Groups] CHECK CONSTRAINT [FK_tbl_PHT_Groups_Tbl_PHT_Project]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_MiscComponents_Configuration_Tbl_PH_Project]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_MiscComponents_Configuration]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_MiscComponents_Configuration_Tbl_PH_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Tbl_PHT_Project] ([ProjectID])
GO
ALTER TABLE [dbo].[Tbl_PHT_MiscComponents_Configuration] CHECK CONSTRAINT [FK_Tbl_PHT_MiscComponents_Configuration_Tbl_PH_Project]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_MiscComponents_Configuration_Tbl_PHT_Miscelleneous_Type]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_MiscComponents_Configuration]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_MiscComponents_Configuration_Tbl_PHT_Miscelleneous_Type] FOREIGN KEY([MiscTypeID])
REFERENCES [dbo].[Tbl_PHT_Miscelleneous_Type] ([MiscTypeID])
GO
ALTER TABLE [dbo].[Tbl_PHT_MiscComponents_Configuration] CHECK CONSTRAINT [FK_Tbl_PHT_MiscComponents_Configuration_Tbl_PHT_Miscelleneous_Type]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_PowerSupply_SMCabinet_Tbl_PHT_Cabinet_Configuration]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_PowerSupply_SMCabinet]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_PowerSupply_SMCabinet_Tbl_PHT_Cabinet_Configuration] FOREIGN KEY([Cabinet_ID])
REFERENCES [dbo].[Tbl_PHT_Cabinet_Configuration] ([CabinetID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_PHT_PowerSupply_SMCabinet] CHECK CONSTRAINT [FK_Tbl_PHT_PowerSupply_SMCabinet_Tbl_PHT_Cabinet_Configuration]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_Report_Revision_History_Tbl_PHT_Report_Setting]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Report_Revision_History]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_Report_Revision_History_Tbl_PHT_Report_Setting] FOREIGN KEY([ReportSettingID])
REFERENCES [dbo].[Tbl_PHT_Report_Setting] ([ReportSettingID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Report_Revision_History] CHECK CONSTRAINT [FK_Tbl_PHT_Report_Revision_History_Tbl_PHT_Report_Setting]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_Report_Setting_Tbl_PHT_Project]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_Report_Setting]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_Report_Setting_Tbl_PHT_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Tbl_PHT_Project] ([ProjectID])
GO
ALTER TABLE [dbo].[Tbl_PHT_Report_Setting] CHECK CONSTRAINT [FK_Tbl_PHT_Report_Setting_Tbl_PHT_Project]
GO
/****** Object:  ForeignKey [FK_Tbl_PHT_RUSIO_SM_Tbl_PHT_Cabinet_Configuration]    Script Date: 06/09/2017 21:18:01 ******/
ALTER TABLE [dbo].[Tbl_PHT_RUSIO_SM]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_PHT_RUSIO_SM_Tbl_PHT_Cabinet_Configuration] FOREIGN KEY([Cabinet_ID])
REFERENCES [dbo].[Tbl_PHT_Cabinet_Configuration] ([CabinetID])
GO
ALTER TABLE [dbo].[Tbl_PHT_RUSIO_SM] CHECK CONSTRAINT [FK_Tbl_PHT_RUSIO_SM_Tbl_PHT_Cabinet_Configuration]
GO
/****** Object:  UserDefinedTableType [dbo].[TVP_GroupDetails]    Script Date: 06/09/2017 21:18:26 ******/
CREATE TYPE [dbo].[TVP_GroupDetails] AS TABLE(
	[GroupName] [varchar](50) NOT NULL,
	[Group_Type] [int] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_PHT_Modules_Update_DCS]    Script Date: 06/09/2017 21:18:26 ******/
CREATE TYPE [dbo].[TYPE_PHT_Modules_Update_DCS] AS TABLE(
	[ModelID] [int] NULL,
	[Description] [nvarchar](256) NULL,
	[HeatDissipation] [decimal](10, 3) NULL,
	[FanCapacity] [nvarchar](100) NULL,
	[Category] [nvarchar](100) NULL,
	[HoneywellModel] [nvarchar](50) NULL,
	[ModelSelection] [bit] NULL,
	[IS_AC_COMPONENT] [bit] NULL,
	[Module_Group] [varchar](100) NULL,
	[CurrentRating] [decimal](16, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TYPE_PHT_Modules_Update_SM]    Script Date: 06/09/2017 21:18:26 ******/
CREATE TYPE [dbo].[TYPE_PHT_Modules_Update_SM] AS TABLE(
	[ModelID] [int] NULL,
	[Description] [nvarchar](256) NULL,
	[Category] [nvarchar](100) NULL,
	[HoneywellModel] [nvarchar](50) NULL,
	[nInputLoad] [decimal](10, 2) NULL,
	[nOutputLoad] [decimal](10, 2) NULL,
	[def_OutputLoad] [decimal](10, 2) NULL,
	[nWDG] [int] NULL,
	[nL_5V] [decimal](10, 2) NULL,
	[nV_drop] [decimal](10, 2) NULL,
	[nChan] [int] NULL,
	[CSignalType] [nvarchar](50) NULL,
	[SupplyVoltage] [nvarchar](50) NULL,
	[InternalPower] [decimal](10, 2) NULL,
	[ExternalPower] [decimal](10, 2) NULL,
	[Load] [decimal](10, 3) NULL,
	[FanCapacity] [nvarchar](100) NULL,
	[ModelSelection] [bit] NULL,
	[OutputVoltage] [nvarchar](200) NULL,
	[IS_AC_COMPONENT] [bit] NULL,
	[Module_Group] [varchar](100) NULL,
	[Power_Dissipation_Barrier] [decimal](10, 3) NULL,
	[Devices_OnBoard] [int] NULL,
	[CurrentRating] [decimal](16, 3) NULL
)
GO
