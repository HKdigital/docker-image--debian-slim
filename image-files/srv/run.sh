#!/bin/bash

#
# Recommended Dockerfile configuration
#
# ENTRYPOINT ["/usr/bin/dumb-init", "--"]
# CMD ["/srv/run.sh"]
#

#
# Expand environment variables that end with _FILE
#
source ./expand-file-environment-vars.sh

echo
echo "Executing [run.sh] from image [hkdigital/debian-slim]"
echo "- $(date)"

CMD="sleep infinity"

echo
echo "= Command: ${CMD}"
echo

# Evaluate command
eval "${CMD}"
