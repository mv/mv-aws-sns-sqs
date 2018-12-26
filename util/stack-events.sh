#!/bin/bash
#
# Usage:
#    ./stack-events.sh  file.cloudformation.json
#
# 2018-10     ferreira.mv

file="${1}"
name="${file%%.*}"  # remove ".*.*.ext"
name="${name##*/}"  # remove "/path/*/dir/*"

[ "${1}" == "" ] && {
  echo
  echo "  Usage: $0  filename.ext|stack-name  [count] [sleep]"
  echo
  exit 1
}

counter=${2:-12}
sleeps=${3:-10}

while true
do

  clear
  echo "== File:  [${file}]               $(date +%Y-%m-%d-%H:%M:%S)"
  echo "== Name:  [${name}]"
  echo "== Sleep: ${sleeps}s  Counter: ${counter}"
  echo

  aws cloudformation describe-stack-events \
    --stack-name "${name}" \
    --output text \
    --query 'StackEvents[*].{Resource:ResourceType, Status:ResourceStatus, Timestamp:Timestamp}' \
    | head -12 | column -t

  [ ${counter} -eq 0 ] && exit
  let counter-=1
  sleep ${sleeps}

done

