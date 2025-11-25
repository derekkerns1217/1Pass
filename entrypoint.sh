#!/bin/bash
# Create directories
mkdir -p /root/.op/data
mkdir -p /root/.op/config
chmod -R 700 /root/.op

# Start sync first (it needs to be listening)
OP_HTTP_PORT=9090 \
OP_BUS_PORT=11220 \
/bin/connect-sync &

# Give sync a second to start its bus listener
sleep 3

# Start API and tell it where to find sync's bus
OP_HTTP_PORT=8080 \
OP_BUS_PORT=11221 \
OP_BUS_PEERS=localhost:11220 \
/bin/connect-api &

# Wait for either to exit
wait -n
exit $?
