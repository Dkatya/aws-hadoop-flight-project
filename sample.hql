SET year=${hivevar:year};
SET rate=${hivevar:rate};

DROP TABLE IF EXISTS sample_${year};

CREATE TABLE sample_${year} (
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
);

INSERT INTO TABLE sample_${year}
SELECT * 
FROM flight_${year}
WHERE rand() <= ${rate}
DISTRIBUTE BY rand()
SORT BY rand()
LIMIT 40000;

ALTER TABLE sample_${year} ADD COLUMNS (Delayed STRING);

INSERT OVERWRITE TABLE sample_${year}
SELECT 
    Year, Month, DayofMonth, DayOfWeek, DepTime, CRSDepTime, ArrTime, CRSArrTime, 
    UniqueCarrier, FlightNum, TailNum, ActualElapsedTime, CRSElapsedTime, AirTime, 
    ArrDelay, DepDelay, Origin, Dest, Distance, TaxiIn, TaxiOut, Cancelled, CancellationCode, 
    Diverted, CarrierDelay, WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay,
    CASE 
        WHEN CAST(ArrDelay AS INT) <= 0 AND CAST(DepDelay AS INT) <= 0 THEN 'N' 
        ELSE 'Y' 
    END AS Delayed
FROM sample_${year};



