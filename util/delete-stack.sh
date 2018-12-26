#!/bin/bash
#
# Usage:
#    ./delete-stack.sh  ...
#
# 2018-10     ferreira.mv


usage() {
  echo
  echo "  Usage: stack=stackname force=y $0"
  echo
  exit 1
}

[ "${stack}" == ""  ] && usage
[ "${force}" != "y" ] && usage

echo "--"
echo "-- Env:"
echo "--   stack=${stack}"
echo "--   force=${force}"
echo

set -e
aws cloudformation describe-stacks \
  --stack-name ${stack}  \
  --query 'Stacks[0].Description' \
  --output json

echo "Deleting..."
aws cloudformation delete-stack \
  --stack-name ${stack}  \
  --output json

