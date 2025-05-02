#!/bin/bash

#wget -O flight.csv.bz2 https://example.com/flight_1987.csv.bz2

#1997
wget -O flight_1997.csv.bz2 https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/RUGDRW
#2002
wget -O flight_2002.csv.bz2 https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/OWJXH3
#2005
wget -O flight_2005.csv.bz2 https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/JTFT25
#2006
wget -O flight_2006.csv.bz2 https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/EPIFFT
#2007
wget -O flight_2007.csv.bz2 https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/2BHLWK

# airports
wget -O airports.csv https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/XTPZZY
#carriers
wget -O carriers.csv https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/3NOQ6Q

# Upload the flight data files to HDFS
hdfs dfs -put flight_1997.csv /user/hive/warehouse
hdfs dfs -put flight_2002.csv /user/hive/warehouse
hdfs dfs -put flight_2005.csv /user/hive/warehouse
hdfs dfs -put flight_2006.csv /user/hive/warehouse
hdfs dfs -put flight_2007.csv /user/hive/warehouse

# Upload the airports and carriers files to HDFS
hdfs dfs -put airports.csv /user/hive/warehouse
hdfs dfs -put carriers.csv /user/hive/warehouse