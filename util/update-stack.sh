#!/bin/bash
#
# Usage:
#    ./update-stack.sh ...
#
# 2018-10     ferreira.mv

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
aws cloudformation update-stack \
  --stack-name ${stack}  \
  --template-body file://"${file}" \
  ${paramf}

