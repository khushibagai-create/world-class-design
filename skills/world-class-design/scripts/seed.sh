#!/usr/bin/env bash
# Random seed string for String Seed of Thought. Variety has to come from outside the model.
# Usage: seed.sh [length]   (default 64)
LEN="${1:-64}"
LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c "$LEN"
echo
