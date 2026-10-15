#!/usr/bin/env bash
# Run a .sql file against the ecom database in the Docker MySQL container.
set -euo pipefail
[[ $# -eq 1 ]] || { echo "Usage: $0 <file.sql>" >&2; exit 1; }
[[ -f "$1" ]] || { echo "Not found: $1" >&2; exit 2; }
docker compose -f docker/docker-compose.yml exec -T mysql \
  sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" --table ecom' < "$1"
