-- Drop existing sample tables just in case
DROP TABLE IF EXISTS yekaterina_sample_2015;
DROP TABLE IF EXISTS yekaterina_sample_2016;
DROP TABLE IF EXISTS yekaterina_sample_2017;
DROP TABLE IF EXISTS yekaterina_sample_2018;
DROP TABLE IF EXISTS yekaterina_sample_2019;

-- Create empty sample tables with same structure
CREATE TABLE yekaterina_sample_2015 AS SELECT * FROM flights_2015 WHERE 1=0;
CREATE TABLE yekaterina_sample_2016 AS SELECT * FROM flights_2016 WHERE 1=0;
CREATE TABLE yekaterina_sample_2017 AS SELECT * FROM flights_2017 WHERE 1=0;
CREATE TABLE yekaterina_sample_2018 AS SELECT * FROM flights_2018 WHERE 1=0;
CREATE TABLE yekaterina_sample_2019 AS SELECT * FROM flights_2019 WHERE 1=0;

-- Add Delayed column to each sample table
ALTER TABLE yekaterina_sample_2015 ADD COLUMNS (Delayed STRING);
ALTER TABLE yekaterina_sample_2016 ADD COLUMNS (Delayed STRING);
ALTER TABLE yekaterina_sample_2017 ADD COLUMNS (Delayed STRING);
ALTER TABLE yekaterina_sample_2018 ADD COLUMNS (Delayed STRING);
ALTER TABLE yekaterina_sample_2019 ADD COLUMNS (Delayed STRING);

-- For 2016
INSERT INTO TABLE yekaterina_sample_2016
SELECT * 
FROM flights_2016
WHERE rand() <= 0.0001
DIStribute BY rand() 
SORT BY rand()
LIMIT 30000;

-- For 2017
INSERT INTO TABLE yekaterina_sample_2017
SELECT * 
FROM flights_2017
WHERE rand() <= 0.0001
DIStribute BY rand() 
SORT BY rand()
LIMIT 30000;

