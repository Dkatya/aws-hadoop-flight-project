#!/bin/bash

# Create a folder in HDFS
hdfs dfs -mkdir -p /user/hive/warehouse

# Download the flight data files directly into Hadoop
wget -O flight_1997.csv.bz2 "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/RUGDRW"
wget -O flight_2002.csv.bz2 "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/OWJXH3"
wget -O flight_2005.csv.bz2 "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/JTFT25"
wget -O flight_2006.csv.bz2 "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/EPIFFT" 
wget -O flight_2007.csv.bz2 "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/2BHLWK" 

# Decompress the files (without deleting the original .bz2 file)
bzip2 -d flight_1997.csv.bz2
bzip2 -d flight_2002.csv.bz2
bzip2 -d flight_2005.csv.bz2
bzip2 -d flight_2006.csv.bz2
bzip2 -d flight_2007.csv.bz2

# Upload the files to Hadoop's HDFS
hdfs dfs -put -f flight_1997.csv /user/hive/warehouse/
hdfs dfs -put -f flight_2002.csv /user/hive/warehouse/
hdfs dfs -put -f flight_2005.csv /user/hive/warehouse/
hdfs dfs -put -f flight_2006.csv /user/hive/warehouse/
hdfs dfs -put -f flight_2007.csv /user/hive/warehouse/

# Download and upload airport and carrier data
wget -O airports.csv "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/XTPZZY"
wget -O carriers.csv "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/3NOQ6Q"

hdfs dfs -put -f airports.csv /user/hive/warehouse/
hdfs dfs -put -f carriers.csv /user/hive/warehouse/
