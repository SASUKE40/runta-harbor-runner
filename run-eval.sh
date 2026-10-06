#!/bin/sh
set -eu

cd "$(dirname "$0")"
export RUNTA_CONFIG="${RUNTA_CONFIG:-$HOME/.config/runta/config.toml}"

# Harbor saves each run's results and logs in a timestamped jobs/ directory.
# Runta requires at least 32 GiB of disk space.
exec uv tool run --from 'harbor[runta]' harbor run \
  --dataset terminal-bench/terminal-bench-2-1 \
  --env runta \
  --agent oracle \
  --n-concurrent 256 \
  --override-storage-mb 32768 \
  --jobs-dir jobs
