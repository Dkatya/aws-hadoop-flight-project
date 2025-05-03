#!/bin/bash
cd "$(dirname "$0")"
your_key=".pem"
aws_dns="ec2.amazonaws.com"

chmod 400 "$your_key"
if [ ! -f "$your_key" ]; then
  echo "Key file $your_key not found!"
  exit 1
fi

# Launch an interactive SSH session with EMR banner
ssh -i "$your_key" -t hadoop@$aws_dns

