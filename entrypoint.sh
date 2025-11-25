#!/bin/bash
mkdir -p /root/.op/data
chmod -R 700 /root/.op

echo "=== Starting Sync Process ==="
OP_HTTP_PORT=9090 \
OP_BUS_PORT=11220 \
OP_BUS_PEERS=127.0.0.1:11221 \
/bin/connect-sync 2>&1 &

sleep 5

echo "=== Starting API Process ==="
OP_HTTP_PORT=8080 \
OP_BUS_PORT=11221 \
OP_BUS_PEERS=127.0.0.1:11220 \
/bin/connect-api 2>&1 &

echo "=== Both processes started, keeping container alive ==="
echo "Sync PID: $!"

# Keep container running indefinitely
while true; do
    sleep 60
    echo "Container still running..."
done
