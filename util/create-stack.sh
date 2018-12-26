#!/bin/bash
#
# Usage:
#   ./create-stack.sh ...
#
# 2018-10     ferreira.mv

# stack="${file%%.*}"  # remove ".*.*.ext"
# stack="${stack##*/}" # remove "/path/*/dir/*"

usage() {
  echo
  echo "  Usage:"
  echo "    $ file=filename stack=stackname [param=paramfile] $0"
  echo
  exit 1
}

[ "${file}"  == "" ] && usage
[ "${stack}" == "" ] && usage
[ "${param}" != "" ] && paramf="--parameters file://${param}"

echo "--"
echo "-- Env:"
echo "--   file=[${file}]"
echo "--   stack=[${stack}]"
echo "--   param=[${param}]"
echo

set -x
aws cloudformation create-stack \
  --stack-name ${stack}  \
  --template-body file://"${file}" \
  --output json \
  ${paramf}

