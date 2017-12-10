#!/bin/bash
#

curl -XPOST 'localhost:9200/_reindex?pretty' -H 'Content-Type: application/json' -d'
{
  "source": {
    "index": "hc2datas2"
  },
  "dest": {
    "index": "hc2datas"
  }
}
'

