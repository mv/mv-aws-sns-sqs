#!/bin/bash
#
# Usage:
#    ./validate-template.sh  file.cloudformation.json
#
# 2018-10     ferreira.mv

[ "${file}" == "" ] && {
  echo
  echo "  Usage: file=filename $0"
  echo
  exit 1
}

echo "--"
echo "-- File: [${file}]"
echo

aws cloudformation validate-template \
  --template-body file://"${file}" --output json  \
# --query 'Description'

echo

