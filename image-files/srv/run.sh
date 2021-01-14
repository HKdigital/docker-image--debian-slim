#!/bin/bash

#
# @note
#   This script should be set as "CMD" of "ENTRY_POINT" in your Dockerfile
#
# @note
#   dumb-init is already specified in the Dockerfile as ENTRYPOINT
#   Otherwise use: #!/usr/bin/dumb-init /bin/bash
#

echo
echo "Executing [run.sh] from image [std-docker-debian-slim]"
echo "- $(date)"

CMD="sleep infinity"

echo
echo "= Command: ${CMD}"
echo

# Evaluate command
eval "${CMD}"
