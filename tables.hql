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
