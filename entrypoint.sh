#!/bin/bash
# Create directories
mkdir -p /root/.op/data
mkdir -p /root/.op/config
chmod -R 700 /root/.op

# Start sync process
OP_HTTP_PORT=9090 \
OP_BUS_PORT=11220 \
OP_BUS_PEERS=127.0.0.1:11221 \
/bin/connect-sync &

# Give sync time to start
sleep 5

# Start API process  
OP_HTTP_PORT=8080 \
OP_BUS_PORT=11221 \
OP_BUS_PEERS=127.0.0.1:11220 \
/bin/connect-api &

# Wait for either to exit
wait -n
exit $?
