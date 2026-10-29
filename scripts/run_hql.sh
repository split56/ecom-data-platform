#!/usr/bin/env bash
# Run an .hql file in the hive4 container.
set -euo pipefail
[[ $# -eq 1 ]] || { echo "Usage: $0 <file.hql>" >&2; exit 1; }
docker cp "$1" hive4:/tmp/run.hql
docker exec hive4 beeline -u 'jdbc:hive2://localhost:10000/' --silent=true -f /tmp/run.hql