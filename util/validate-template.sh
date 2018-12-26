#!/bin/bash
#
# Usage:
#    ./validate-template.sh  file.cloudformation.json
#
# 2018-10     ferreira.mv

file="${1}"

[ "${1}" == "" ] && {
  echo
  echo "  Usage: $0  filename.ext"
  echo
  exit 1
}

echo "=="
echo "== File: [${file}]"
echo

aws cloudformation validate-template \
  --template-body file://"${file}" --output json  \
# --query 'Description'

echo

