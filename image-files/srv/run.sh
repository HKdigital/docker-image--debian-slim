#!/bin/bash

#
# Recommended Dockerfile configuration
#
# ENTRYPOINT ["/usr/bin/dumb-init", "--"]
# CMD ["/srv/run.sh"]
#

echo
echo "Executing [run.sh] from image [debian-slim-2021a]"
echo "- $(date)"

CMD="sleep infinity"

echo
echo "= Command: ${CMD}"
echo

# Evaluate command
eval "${CMD}"
