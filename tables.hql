-- Drop and create flight tables
DROP TABLE IF EXISTS flight_1997;
DROP TABLE IF EXISTS flight_2002;
DROP TABLE IF EXISTS flight_2005;
DROP TABLE IF EXISTS flight_2006;
DROP TABLE IF EXISTS flight_2007;

CREATE EXTERNAL TABLE flight_1997 (
  Year INT,
  Month INT,
  DayofMonth INT,
  DayOfWeek INT,
  DepTime INT,
  CRSDepTime INT,
  ArrTime INT,
  CRSArrTime INT,
  UniqueCarrier STRING,
  FlightNum INT,
  TailNum STRING,
  ActualElapsedTime INT,
  CRSElapsedTime INT,
  AirTime INT,
  ArrDelay INT,
  DepDelay INT,
  Origin STRING,
  Dest STRING,
  Distance INT,
  TaxiIn INT,
  TaxiOut INT,
  Cancelled INT,
  CancellationCode STRING,
  Diverted INT,
  CarrierDelay INT,
  WeatherDelay INT,
  NASDelay INT,
  SecurityDelay INT,
  LateAircraftDelay INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"     = "\""
)
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/flight_1997.csv'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Repeat for other years
CREATE EXTERNAL TABLE flight_2002 LIKE flight_1997
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/flight_2002.csv';

CREATE EXTERNAL TABLE flight_2005 LIKE flight_1997
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/flight_2005.csv';

CREATE EXTERNAL TABLE flight_2006 LIKE flight_1997
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/flight_2006.csv';

CREATE EXTERNAL TABLE flight_2007 LIKE flight_1997
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/flight_2007.csv';

-- Airports table
DROP TABLE IF EXISTS airports;
CREATE EXTERNAL TABLE airports (
  IATA STRING,
  airport STRING,
  city STRING,
  state STRING,
  country STRING,
  lat DOUBLE,
  long DOUBLE
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"     = "\""
)
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/airports.csv'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Carriers table
DROP TABLE IF EXISTS carriers;
CREATE EXTERNAL TABLE carriers (
  Code STRING,
  Description STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar"     = "\""
)
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/carriers.csv'
TBLPROPERTIES ("skip.header.line.count"="1");


--Verify Data Load and Print First 5 Rows

-- Flight Data (1997)
SELECT COUNT(*) FROM flight_1997;
SELECT * FROM flight_1997 LIMIT 5;

-- Print confirmation
!echo "Table flight_1997 created and data loaded. Here are the first 5 rows:"
!hive -e "SELECT * FROM flight_1997 LIMIT 5;"

-- Flight Data (2002)
SELECT COUNT(*) FROM flight_2002;
SELECT * FROM flight_2002 LIMIT 5;

-- Print confirmation
!echo "Table flight_2002 created and data loaded. Here are the first 5 rows:"
!hive -e "SELECT * FROM flight_2002 LIMIT 5;"

-- Flight Data (2005)
SELECT COUNT(*) FROM flight_2005;
SELECT * FROM flight_2005 LIMIT 5;

-- Print confirmation
!echo "Table flight_2005 created and data loaded. Here are the first 5 rows:"
!hive -e "SELECT * FROM flight_2005 LIMIT 5;"

-- Flight Data (2006)
SELECT COUNT(*) FROM flight_2006;
SELECT * FROM flight_2006 LIMIT 5;

-- Print confirmation
!echo "Table flight_2006 created and data loaded. Here are the first 5 rows:"
!hive -e "SELECT * FROM flight_2006 LIMIT 5;"

-- Flight Data (2007)
SELECT COUNT(*) FROM flight_2007;
SELECT * FROM flight_2007 LIMIT 5;

-- Print confirmation
!echo "Table flight_2007 created and data loaded. Here are the first 5 rows:"
!hive -e "SELECT * FROM flight_2007 LIMIT 5;"

-- Airports Data
SELECT COUNT(*) FROM airports;
SELECT * FROM airports LIMIT 5;

-- Print confirmation
!echo "Table airports created and data loaded. Here are the first 5 rows:"
!hive -e "SELECT * FROM airports LIMIT 5;"

-- Carriers Data
SELECT COUNT(*) FROM carriers;
SELECT * FROM carriers LIMIT 5;

-- Print confirmation
!echo "Table carriers created and data loaded. Here are the first 5 rows:"
!hive -e "SELECT * FROM carriers LIMIT 5;"



-- Calculate sampling rate by dividing the sample size (30,000) by the total number of rows in the original table
SELECT 
    '1997' AS year,
    (30000 / COUNT(*)) * 100 AS sampling_rate_1997
FROM flight_1997
UNION ALL
SELECT 
    '2002' AS year,
    (30000 / COUNT(*)) * 100 AS sampling_rate_2002
FROM flight_2002
UNION ALL
SELECT 
    '2005' AS year,
    (30000 / COUNT(*)) * 100 AS sampling_rate_2005
FROM flight_2005
UNION ALL
SELECT 
    '2006' AS year,
    (30000 / COUNT(*)) * 100 AS sampling_rate_2006
FROM flight_2006
UNION ALL
SELECT 
    '2007' AS year,
    (30000 / COUNT(*)) * 100 AS sampling_rate_2007
FROM flight_2007;
