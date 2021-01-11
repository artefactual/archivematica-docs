#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

es_url="http://localhost:9200"

index_list='aips aipfiles transfers transferfiles'

echo -e "\nIndex list before reindexing:\n"
curl -s -X GET "${es_url}/_cat/indices/%2A?v=&s=index:desc"
echo -e "\n"

# Clone indices with _reindex API call:
for index in $index_list; do
    echo "Reindex ${index} in ${index}_new..."
    curl -s -X POST \
      ${es_url}/_reindex \
      -H 'Content-Type: application/json' \
      -d '{
      "source": {
        "index": "'"${index}"'"
      },
      "dest": {
        "index": "'"${index}_new"'"
      }
    }' > /dev/null
done

echo -e "\n\n"

echo -e "Index list after tmp indices creation\n"
indices_output=$(curl -s -X GET "${es_url}/_cat/indices/%2A?v=&s=index:desc")
curl -s -X GET "${es_url}/_cat/indices/%2A?v=&s=index:desc"
echo -e "\n"

# Delete old indices
for index in $index_list; do
  echo "Deleting ${index}..."
  curl -s -X DELETE ${es_url}/${index} > /dev/null
done

# Restart archivematica-dashboard to create indices with new mappings
echo -e "\nRestarting archivematica-dashboard"
sudo service archivematica-dashboard restart

# Wait 30 seconds
echo "Wait 30 seconds to ensure dashboard has created the empty indices with new mapping"
sleep 30
echo -e "\n"

# When index has no docs the reindex doesn't create the new index (typically transferfiles index)
# There's a check to ensure the new index has been create before reindexing.
# Reindex from *_new indices:
for index in $index_list; do
  if echo "$indices_output" | grep ${index}_new >/dev/null; then
    echo "Indexing ${index} using ${index}_new ..."
    curl -s -X POST \
      ${es_url}/_reindex \
      -H 'Content-Type: application/json' \
      -d '{
      "source": {
        "index": "'"${index}_new"'"
      },
      "dest": {
        "index": "'"${index}"'"
      }
    }' > /dev/null
  fi
done

echo -e "\n"

# Delete temporary indices
for index in $index_list; do
  if echo "$indices_output" | grep ${index}_new >/dev/null; then
     echo "Deleting ${index}_new..."
     curl -s -X DELETE ${es_url}/${index}_new > /dev/null
  fi
done

echo -e "\n\nReindexing done:\n"
curl -s -X GET "${es_url}/_cat/indices/%2A?v=&s=index:desc"
echo -e "\n"
