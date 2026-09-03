#!/usr/bin/env bash
# Headless Chrome screenshot, for feeding the design critic.
# Usage: shot.sh <input.html|url> <out.png> [width] [height] [scale]
set -euo pipefail
IN="${1:?usage: shot.sh <input.html|url> <out.png> [width] [height] [scale]}"
OUT="${2:?missing output png}"
W="${3:-1440}"
H="${4:-1200}"
S="${5:-2}"

case "$IN" in
  http://*|https://*|file://*) URL="$IN" ;;
  *) URL="file://$(cd "$(dirname "$IN")" && pwd)/$(basename "$IN")" ;;
esac

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -x "$CHROME" ] || CHROME="$(command -v google-chrome || command -v chromium || true)"
[ -n "$CHROME" ] || { echo "No Chrome found" >&2; exit 1; }

"$CHROME" --headless=new --disable-gpu --hide-scrollbars \
  --force-device-scale-factor="$S" \
  --virtual-time-budget=4000 \
  --window-size="$W,$H" \
  --screenshot="$OUT" "$URL" >/dev/null 2>&1

echo "$OUT"
