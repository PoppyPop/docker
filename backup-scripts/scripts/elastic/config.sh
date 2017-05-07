curl -XPUT 'localhost:9200/_snapshot/backup/' -H 'Content-Type: application/json' -d'
{
    "type": "fs",
    "settings": {
        "location": "/backup",
	"compress": true
    }
}
'
