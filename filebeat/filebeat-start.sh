##!/bin/bash/

echo "Waiting for Kibana..."
while ! curl -s -f -I "${KIBANA_HOST}:5601/api/status" > /dev/null ; do sleep 10; done

#echo "Setting up filebeat"
#filebeat setup -E setup.kibana.host=kibana:5601

indexPattern="${INDEX_PATTERN:-filebeat}-*"
echo "Creating index pattern"
indexJson="{
  \"attributes\": {
    \"title\": \"$indexPattern\",
    \"timeFieldName\": \"@timestamp\"
  }
}"
curl -s -X POST "${KIBANA_HOST}:5601/api/saved_objects/index-pattern/${indexPattern}" \
   -H 'kbn-xsrf: true' \
   -H 'Content-Type: application/json' \
   -d "$indexJson"

echo
echo "Running filebeat"
filebeat -e
