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
    rm "$file"  # Optional: remove the original .bz2 file
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
    exit 1  # Optional: exit if upload fails
  fi
}

# Flight data (filename => URL)
declare -A flight_files=(
  [flight_1997.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/your_persistent_id_for_1997"
  [flight_2002.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/your_persistent_id_for_2002"
  [flight_2005.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/your_persistent_id_for_2005"
  [flight_2006.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/your_persistent_id_for_2006"
  [flight_2007.csv.bz2]="https://dataverse.harvard.edu/api/access/datafile/your_persistent_id_for_2007"
)

# Download and decompress flight files
for file in "${!flight_files[@]}"; do
  download_and_confirm "${flight_files[$file]}" "$file"
  decompress_and_confirm "$file"
done

# Airport and carrier files
download_and_confirm "https://dataverse.harvard.edu/api/access/datafile/your_persistent_id_for_airports" airports.csv
download_and_confirm "https://dataverse.harvard.edu/api/access/datafile/your_persistent_id_for_carriers" carriers.csv

# Upload all to HDFS
for csv in flight_*.csv airports.csv carriers.csv; do
  upload_to_hdfs "$csv"
done
