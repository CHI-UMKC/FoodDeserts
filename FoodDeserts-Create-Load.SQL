# MySQL script for loading USDA Food Access data
# http://www.ers.usda.gov/data-products/food-access-research-atlas/download-the-data.aspx

# Download script:       0-USDA-Food-Access-Data-Download.R

# Preprocessing script:  1-USDA-Food-Access-FirstLook.R
# (also extracts data from Excel and writes CSV file used here
# C:/Data/US-Government/USDA-Food/Data/Food-Access-Research-Atlas-Current.csv)

# UMKC Center for Health Insights
# Earl F Glynn, 2014-12-08

DROP DATABASE IF EXISTS TestLoad;

create database TestLoad;
use TestLoad;

CREATE TABLE fooddeserts
(
  CensusTract           CHAR(11),
  State                 CHAR( 2),
  County                CHAR(21),
  LILATracts_1And10     SMALLINT,
  LILATracts_halfAnd10  SMALLINT,
  LILATracts_1And20     SMALLINT,
  LILATracts_Vehicle    SMALLINT,
  Urban                 SMALLINT,
  Rural                 SMALLINT,
  LA1and10              SMALLINT,
  LAhalfand10           SMALLINT,
  LA1and20              SMALLINT,
  LATracts_half         SMALLINT,
  LATracts1             SMALLINT,
  LATracts10            SMALLINT,
  LATracts20            SMALLINT,
  HUNVFlag              SMALLINT,
  GroupQuartersFlag     SMALLINT,
  OHU2010               SMALLINT,
  NUMGQTRS              INT,
  PCTGQTRS              DOUBLE,
  LowIncomeTracts       SMALLINT,
  POP2010               INT,
  UATYP10               CHAR( 1),
  lapophalf             DOUBLE,
  lapophalfshare        DOUBLE,
  lalowihalf            DOUBLE,
  lalowihalfshare       DOUBLE,
  lakidshalf            DOUBLE,
  lakidshalfshare       DOUBLE,
  laseniorshalf         DOUBLE,
  laseniorshalfshare    DOUBLE,
  lahunvhalf            DOUBLE,
  lahunvhalfshare       DOUBLE,
  lapop1                DOUBLE,
  lapop1share           DOUBLE,
  lalowi1               DOUBLE,
  lalowi1share          DOUBLE,
  lakids1               DOUBLE,
  lakids1share          DOUBLE,
  laseniors1            DOUBLE,
  laseniors1share       DOUBLE,
  lahunv1               DOUBLE,
  lahunv1share          DOUBLE,
  lapop10               DOUBLE,
  lapop10share          DOUBLE,
  lalowi10              DOUBLE,
  lalowi10share         DOUBLE,
  lakids10              DOUBLE,
  lakids10share         DOUBLE,
  laseniors10           DOUBLE,
  laseniors10share      DOUBLE,
  lahunv10              DOUBLE,
  lahunv10share         DOUBLE,
  lapop20               DOUBLE,
  lapop20share          DOUBLE,
  lalowi20              DOUBLE,
  lalowi20share         DOUBLE,
  lakids20              DOUBLE,
  lakids20share         DOUBLE,
  laseniors20           DOUBLE,
  laseniors20share      DOUBLE,
  lahunv20              DOUBLE,
  lahunv20share         DOUBLE
);

LOAD DATA LOCAL INFILE 'C:/Data/US-Government/USDA-Food/Data/Food-Access-Research-Atlas-Current.csv'
INTO TABLE fooddeserts
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES    # ignore headers
 (CensusTract,State,County,LILATracts_1And10,LILATracts_halfAnd10,
  LILATracts_1And20,LILATracts_Vehicle,Urban,Rural,LA1and10,LAhalfand10,
  LA1and20,LATracts_half,LATracts1,LATracts10,LATracts20,HUNVFlag,
  GroupQuartersFlag,OHU2010,@NA_NUMGQTRS,@NA_PCTGQTRS,LowIncomeTracts,
  POP2010,UATYP10,lapophalf,lapophalfshare,lalowihalf,lalowihalfshare,
  lakidshalf,lakidshalfshare,laseniorshalf,laseniorshalfshare,lahunvhalf,
  lahunvhalfshare,lapop1,lapop1share,lalowi1,lalowi1share,lakids1,
  lakids1share,laseniors1,laseniors1share,lahunv1,lahunv1share,lapop10,
  lapop10share,lalowi10,lalowi10share,lakids10,lakids10share,laseniors10,
  laseniors10share,lahunv10,lahunv10share,lapop20,lapop20share,lalowi20,
  lalowi20share,lakids20,lakids20share,laseniors20,laseniors20share,
  lahunv20,lahunv20share)
SET
  # Special processing for 'NA's created via R extraction of Excel values.
  NUMGQTRS = IF(@NA_NUMGQTRS = 'NA', NULL, CONVERT(@NA_NUMGQTRS, UNSIGNED) ),
  # Unclear why MySQL requires DECIMAL here instead of DOUBLE
  PCTGQTRS = IF(@NA_PCTGQTRS = 'NA', NULL, CONVERT(@NA_PCTGQTRS, DECIMAL(10,8)) );

SHOW WARNINGS;

