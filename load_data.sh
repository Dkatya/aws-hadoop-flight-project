#!/bin/bash

# Helper functions
download_and_confirm() {
  url=$1
  output=$2
  if wget -O "$output" "$url"; then
    echo "[✔] Downloaded $output"
  else
    echo "[✘] Failed to download $output"
  fi
}

decompress_and_confirm() {
  file=$1
  if bzip2 -d "$file"; then
    echo "[✔] Decompressed $file"
  else
    echo "[✘] Failed to decompress $file"
  fi
}

upload_to_hdfs() {
  file=$1
  if hdfs dfs -put "$file" /user/hive/warehouse; then
    echo "[✔] Uploaded $file to HDFS"
  else
    echo "[✘] Failed to upload $file to HDFS"
  fi
}

# Flight data (filename => URL)
declare -A flight_files=(
  [flight_1997.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/RUGDRW"
  [flight_2002.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/OWJXH3"
  [flight_2005.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/JTFT25"
  [flight_2006.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/EPIFFT"
  [flight_2007.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/2BHLWK"
)

# Download and decompress flight files
for file in "${!flight_files[@]}"; do
  download_and_confirm "${flight_files[$file]}" "$file"
  decompress_and_confirm "$file"
done

# Airport and carrier files
download_and_confirm "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/XTPZZY" airports.csv
download_and_confirm "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7/3NOQ6Q" carriers.csv

# Upload all to HDFS
for csv in flight_*.csv airports.csv carriers.csv; do
  upload_to_hdfs "$csv"
done
