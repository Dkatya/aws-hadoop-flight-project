#!/bin/bash

cd ~/Desktop

chmod 400 CS673_Tutorial.pem

# Set your variables
your_key="CS673_Tutorial.pem"
aws_dns="your-emr-public-dns.compute.amazonaws.com"

# SSH into your EMR master node and run HDFS command
ssh -i "$your_key" hadoop@$aws_dns << EOF
  hdfs dfs -mkdir -p /user/hive/warehouse
EOF



