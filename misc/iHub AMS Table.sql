CREATE TABLE "AMS_ETL"."TETL_SYSTEM_DATA" 
   (	
   "SYSTEM_DATA_CD" VARCHAR2(40 CHAR) NOT NULL ENABLE, 
	"SYSTEM_CD" VARCHAR2(40 CHAR), 
	"SYSTEM_DATA_TYPE_CD" VARCHAR2(40 CHAR) NOT NULL ENABLE, 
	"SYSTEM_DATA_DESC" VARCHAR2(256 CHAR) NOT NULL ENABLE, 
	"UPDTS" TIMESTAMP (6), 
	"UPDBYID" VARCHAR2(120 CHAR), 
	"INSTS" TIMESTAMP (6), 
	"INSBYID" VARCHAR2(120 CHAR), 
	"RETENTION_PERIOD" VARCHAR2(10 CHAR), 
	"RETENTION_TYPE" VARCHAR2(10 CHAR), 
	 CONSTRAINT "PK_TETL_SYSTEM_DATA" PRIMARY KEY ("SYSTEM_DATA_CD") ENABLE, 
	 CONSTRAINT "AK01_TETL_SYSTEM_DATA" UNIQUE ("SYSTEM_DATA_DESC")  ENABLE, 
	 CONSTRAINT "FKC_SYSTEM_DATA_1" FOREIGN KEY ("SYSTEM_CD")
	  REFERENCES "AMS_ETL"."TETL_CONFIG_SYSTEM" ("SYSTEM_CD") ENABLE, 
	 CONSTRAINT "FKC_SYSTEM_DATA_2" FOREIGN KEY ("SYSTEM_DATA_TYPE_CD")
	  REFERENCES "AMS_ETL"."TETL_SYSTEM_DATA_TYPE" ("SYSTEM_DATA_TYPE_CD") ENABLE
   ) 
    ALTER TABLE "AMS_ETL"."TETL_SYSTEM_DATA" MODIFY ("SYSTEM_DATA_DESC" NOT NULL ENABLE);
    ALTER TABLE "AMS_ETL"."TETL_SYSTEM_DATA" MODIFY ("SYSTEM_DATA_TYPE_CD" NOT NULL ENABLE);
    ALTER TABLE "AMS_ETL"."TETL_SYSTEM_DATA" MODIFY ("SYSTEM_DATA_CD" NOT NULL ENABLE);
    COMMENT ON COLUMN "AMS_ETL"."TETL_SYSTEM_DATA"."SYSTEM_DATA_CD" IS 'Code that defines the data consumed by a process. eg ''BL_SRC_TB''';
    COMMENT ON COLUMN "AMS_ETL"."TETL_SYSTEM_DATA"."SYSTEM_CD" IS 'Code representing the source system.eg ''BL''';
    COMMENT ON COLUMN "AMS_ETL"."TETL_SYSTEM_DATA"."SYSTEM_DATA_TYPE_CD" IS 'Type of source data. eg ''Flat File''';
    COMMENT ON COLUMN "AMS_ETL"."TETL_SYSTEM_DATA"."SYSTEM_DATA_DESC" IS 'Description of the system_data_cd. eg ''BL Source File: Trial Balance Detail File''';
    COMMENT ON TABLE "AMS_ETL"."TETL_SYSTEM_DATA"  IS 'Source Data consumed by a process. Supertype for Files and Tables (relational data).';

    
iHub Mainatins TETL_SYSTEM_DATA_HIST of all data audit trail
ARL_SYS1_VIEWS has select privilege on all tables

    ARL SYS MDM > TMAP TABLES
    ARL SYS META > TETL tables
    