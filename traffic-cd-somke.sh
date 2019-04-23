#!/bin/bash

set -x

RUNNER='packages01-internal.adstream.com/qatools/test-runner:latest'
BROWSER='selenium/standalone-firefox-debug:2.53.0'

${TRAFFIC_VERSION:?TRAFFIC_VERSION is not set}
${TEST_DIR:=$PWD}

STACKNAME="trafficcd-$(echo $TRAFFIC_VERSION | sed -e 's/\./-/g')"

OPTS="$OPTS-e APP_URL=http://$STACKNAME.adstreamdev.com"
OPTS="$OPTS -e CORE_URL=http://$STACKNAME.adstreamdev.com:8080"
OPTS="$OPTS -e DELIVERY_SERVER_URL=http://$STACKNAME.adstreamdev.com:8181"
OPTS="$OPTS -e PAPER_PUSHER_URL=http://$STACKNAME.adstreamdev.com:7272"
OPTS="$OPTS -e MONGO_HOST=$STACKNAME.adstreamdev.com"
OPTS="$OPTS -e GRID_URL=http://selenium:4444"

OPTS="$OPTS -v $TEST_DIR:/tests"
OPTS="$OPTS -v $TEST_DIR/m2:/root/.m2"

OPTS="$OPTS --name trunner"
OPTS="$OPTS --link ffox:selenium"

## prepare cleanup
cleanup() {
	docker rm -fv ffox || echo 0
	docker rm -fv trunner || echo 0
}

cleanup
# run browser
docker run -d -p 4444:4444 -p 5900:5900 --name ffox $BROWSER

# pull runner
docker pull $RUNNER
# run tests
docker run $OPTS $RUNNER

# cleanup after tests
cleanup



