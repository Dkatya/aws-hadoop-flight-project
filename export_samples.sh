#!/bin/bash

# List of years and corresponding HDFS directories
declare -A years
years=(
  ["1997"]="/user/hive/warehouse/sample_1997_export"
  ["2002"]="/user/hive/warehouse/sample_2002_export"
  ["2005"]="/user/hive/warehouse/sample_2005_export"
  ["2006"]="/user/hive/warehouse/sample_2006_export"
  ["2007"]="/user/hive/warehouse/sample_2007_export"
)

# Run the export and copy process for each year
for year in "${!years[@]}"; do
  # Step 1: Export the table to HDFS
  echo "Exporting sample_${year} to HDFS"
  hive -e "
    INSERT OVERWRITE DIRECTORY '${years[$year]}'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    SELECT * FROM sample_${year};
  "

  # Step 2: Copy from HDFS to local EC2 directory
  echo "Copying sample_${year} from HDFS to local directory"
  hdfs dfs -get ${years[$year]} ~/sample_${year}_export

done

echo "Export and copy process completed."
#!/bin/bash

# List of years and corresponding local destinations
declare -A years
years=(
  ["1997"]="/path/to/local/destination/sample_1997_export"
  ["2002"]="/path/to/local/destination/sample_2002_export"
  ["2005"]="/path/to/local/destination/sample_2005_export"
  ["2006"]="/path/to/local/destination/sample_2006_export"
  ["2007"]="/path/to/local/destination/sample_2007_export"
)

# Transfer files from EC2 to local machine for each year
for year in "${!years[@]}"; do
  echo "Transferring sample_${year} from EC2 to local machine"
  scp -i your_key.pem -r hadoop@<your-aws-dns>:~/sample_${year}_export ${years[$year]}
done

echo "Transfer completed."
