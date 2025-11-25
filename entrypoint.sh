#!/bin/bash
mkdir -p /root/.op/data
chmod -R 700 /root/.op

echo "Starting sync process..."
OP_HTTP_PORT=9090 \
OP_BUS_PORT=11220 \
OP_BUS_PEERS=127.0.0.1:11221 \
/bin/connect-sync &
SYNC_PID=$!

sleep 5

echo "Starting API process..."
OP_HTTP_PORT=8080 \
OP_BUS_PORT=11221 \
OP_BUS_PEERS=127.0.0.1:11220 \
OP_HTTP_HOST=0.0.0.0 \
/bin/connect-api &
API_PID=$!

echo "Sync PID: $SYNC_PID"
echo "API PID: $API_PID"

# Monitor processes
while true; do
    sleep 30
    if ps -p $SYNC_PID > /dev/null 2>&1; then
        echo "Sync process is running"
    else
        echo "WARNING: Sync process died!"
    fi
    
    if ps -p $API_PID > /dev/null 2>&1; then
        echo "API process is running"
    else
        echo "WARNING: API process died!"
    fi
done
