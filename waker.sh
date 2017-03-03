#!/usr/bin/bash

HOST=$1
RAW_HOST=$(echo ${HOST} | sed -n 's#\([^:]*\).*#\1#p') #FIXME
echo $RAW_HOST $HOST
TOKEN=$2
NAMESPACE=$3

[[ "${HOST}" =~ ^http:// ]] || HOST="https://"${HOST}
[[ "${HOST}" =~ /$ ]] || HOST=${HOST}"/"

while true; do

  #echo curl -k -H "Authorization: Bearer ${TOKEN}" "${HOST}oapi/v1/namespaces/${NAMESPACE}/builds"
  RESPONSE=$(curl -k -H "Authorization: Bearer ${TOKEN}" "${HOST}oapi/v1/namespaces/${NAMESPACE}/builds" 2> /dev/null)
  PHASE=$(echo $RESPONSE | jq -r .items[-1].status.phase)
  echo $PHASE
  TIMESTAMP=$(echo ${RESPONSE} | jq -r .items[-1].status.startTimestamp)
  echo $TIMESTAMP
  if [ "${PHASE}" == "New" ]; then
    echo $RESPONSE | jq .items[-1].metadata.name
    curl --insecure https://jenkins-${NAMESPACE}.${RAW_HOST}/login
  fi
  
  
  sleep 1 
done