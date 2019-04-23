#!/bin/bash

ELASTIC_HOST="10.0.25.34"
AGENCY_NAME="Zebra Crossing"
AGENCY_NEW_NAME="new Zebra Crossing"

AGENCY_NEW_NAME_LOWER=`echo $AGENCY_NEW_NAME | awk '{print tolower($0)}'`

AGENCY_ID=`mongoexport -d gdam -c group -f _id --query "{\"name\":\"$AGENCY_NAME\"}" | sed -r 's/.+"([0-9a-z]+)".+/\1/g'`
mongo gdam --eval "db.getCollection(\"group\").update({\"name\":\"$AGENCY_NAME\"}, {\$set:{\"name\":\"$AGENCY_NEW_NAME\",\"lo_name\":\"$AGENCY_NEW_NAME_LOWER\"}}); \
                   db.user.update({\"agency._id\":ObjectId(\"$AGENCY_ID\")}, {\$set:{\"agency.name\":\"$AGENCY_NEW_NAME\"}}, false, true);"
curl -XPOST "http://$ELASTIC_HOST:9200/gdam_agency/agency/$AGENCY_ID/_update" -d "{\"script\":\"ctx._source.name=\\\"$AGENCY_NEW_NAME\\\";ctx._source.lo_name=\\\"$AGENCY_NEW_NAME_LOWER\\\"\"}"
