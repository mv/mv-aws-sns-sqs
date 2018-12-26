#!/bin/bash

[ "${1}" == "" ] && {
  echo
  echo "  Usage: $0  stackname  [count]  [sleep]"
  echo
  exit 1
}

topic="$(
  aws cloudformation describe-stack-resources \
      --stack-name ${1}                       \
      --query 'StackResources[*].{Id:PhysicalResourceId}' \
      --output text                           \
      | awk '/arn:aws:sns/ {print $1}'
)"

counter=${2:-100}
sleeps=${3:-0}

while true
do

  # Capture result for the next message...
  res="$(
    aws sns publish                  \
        --topic-arn ${topic}         \
        --message "[$(date)] [$res]" \
        --output text
  )"

  echo "[$(date)]  topic: ${topic}  counter: ${counter}  previous: ${res}"
  sleep ${sleeps}

  let counter-=1
  [ ${counter} -eq 0 ] && exit

done

