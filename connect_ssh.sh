#!/bin/bash
cd "$(dirname "$0")"  # Go to folder where script is
your_key="CS673_Tutorial.pem"
aws_dns="your-emr-public-dns.compute.amazonaws.com"

chmod 400 "$your_key"
if [ ! -f "$your_key" ]; then
  echo "Key file $your_key not found!"
  exit 1
fi

ssh -i "$your_key" hadoop@$aws_dns << EOF
  hdfs dfs -mkdir -p /user/hive/warehouse
EOF



