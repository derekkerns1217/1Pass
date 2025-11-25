#!/bin/bash
# Create directory as root (no ownership changes needed)
mkdir -p /root/.op/data
mkdir -p /root/.op/config
chmod -R 700 /root/.op

# Run both processes as root
OP_HTTP_PORT=8080 /bin/connect-api &
OP_HTTP_PORT=9090 /bin/connect-sync &
wait -n
exit $?
