USE [GITHUB_HEALTHCARE_ETL_PROJECT]
GO
/****** Object:  Schema [mil]    Script Date: 08/05/2025 15:42:54 ******/
CREATE SCHEMA [mil]
GO
/****** Object:  Table [mil].[Conditions]    Script Date: 08/05/2025 15:42:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mil].[Conditions](
	[ConditionID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [varchar](64) NULL,
	[EncounterID] [varchar](64) NULL,
	[Code] [varchar](20) NULL,
	[Description] [varchar](255) NULL,
	[OnsetDate] [date] NULL,
 CONSTRAINT [PK__Conditio__37F5C0EF6C402726] PRIMARY KEY CLUSTERED 
(
	[ConditionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [mil].[Encounters]    Script Date: 08/05/2025 15:42:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mil].[Encounters](
	[EncounterID] [varchar](64) NOT NULL,
	[PatientID] [varchar](64) NULL,
	[EncounterDate] [datetime] NULL,
	[EncounterType] [varchar](50) NULL,
	[Provider] [varchar](100) NULL,
	[Location] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[EncounterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [mil].[Medications]    Script Date: 08/05/2025 15:42:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mil].[Medications](
	[MedicationID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [varchar](64) NULL,
	[EncounterID] [varchar](64) NULL,
	[MedicationName] [varchar](255) NULL,
	[Dosage] [varchar](50) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
 CONSTRAINT [PK__Medicati__62EC1ADA98478A6B] PRIMARY KEY CLUSTERED 
(
	[MedicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [mil].[Patients]    Script Date: 08/05/2025 15:42:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mil].[Patients](
	[PatientID] [varchar](64) NOT NULL,
	[Gender] [varchar](10) NULL,
	[BirthDate] [date] NULL,
	[Race] [varchar](50) NULL,
	[Ethnicity] [varchar](50) NULL,
	[MaritalStatus] [varchar](20) NULL,
	[Language] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [mil].[Procedures]    Script Date: 08/05/2025 15:42:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mil].[Procedures](
	[ProcedureID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [varchar](64) NULL,
	[EncounterID] [varchar](64) NULL,
	[ProcedureName] [varchar](255) NULL,
	[ProcedureCode] [varchar](50) NULL,
	[ProcedureDate] [date] NULL,
 CONSTRAINT [PK__Procedur__54C2E50D687D82FC] PRIMARY KEY CLUSTERED 
(
	[ProcedureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [mil].[Conditions]  WITH CHECK ADD  CONSTRAINT [FK__Condition__Encou__440B1D61] FOREIGN KEY([EncounterID])
REFERENCES [mil].[Encounters] ([EncounterID])
GO
ALTER TABLE [mil].[Conditions] CHECK CONSTRAINT [FK__Condition__Encou__440B1D61]
GO
ALTER TABLE [mil].[Conditions]  WITH CHECK ADD  CONSTRAINT [FK__Condition__Patie__4316F928] FOREIGN KEY([PatientID])
REFERENCES [mil].[Patients] ([PatientID])
GO
ALTER TABLE [mil].[Conditions] CHECK CONSTRAINT [FK__Condition__Patie__4316F928]
GO
ALTER TABLE [mil].[Encounters]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [mil].[Patients] ([PatientID])
GO
ALTER TABLE [mil].[Medications]  WITH CHECK ADD  CONSTRAINT [FK__Medicatio__Encou__47DBAE45] FOREIGN KEY([EncounterID])
REFERENCES [mil].[Encounters] ([EncounterID])
GO
ALTER TABLE [mil].[Medications] CHECK CONSTRAINT [FK__Medicatio__Encou__47DBAE45]
GO
ALTER TABLE [mil].[Medications]  WITH CHECK ADD  CONSTRAINT [FK__Medicatio__Patie__46E78A0C] FOREIGN KEY([PatientID])
REFERENCES [mil].[Patients] ([PatientID])
GO
ALTER TABLE [mil].[Medications] CHECK CONSTRAINT [FK__Medicatio__Patie__46E78A0C]
GO
ALTER TABLE [mil].[Procedures]  WITH CHECK ADD  CONSTRAINT [FK__Procedure__Encou__4BAC3F29] FOREIGN KEY([EncounterID])
REFERENCES [mil].[Encounters] ([EncounterID])
GO
ALTER TABLE [mil].[Procedures] CHECK CONSTRAINT [FK__Procedure__Encou__4BAC3F29]
GO
ALTER TABLE [mil].[Procedures]  WITH CHECK ADD  CONSTRAINT [FK__Procedure__Patie__4AB81AF0] FOREIGN KEY([PatientID])
REFERENCES [mil].[Patients] ([PatientID])
GO
ALTER TABLE [mil].[Procedures] CHECK CONSTRAINT [FK__Procedure__Patie__4AB81AF0]
GO
