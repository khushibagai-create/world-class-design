#!/usr/bin/env bash
# Headless Chrome screenshot, for feeding the design critic.
# Usage: shot.sh <input.html|url> <out.png> [width] [height] [scale]
#
# Chrome headless clamps its window to a 500px minimum width. Asking for
# --window-size=375 renders a 500px layout and crops the image to 375, which looks
# exactly like a broken mobile layout and produces false bug reports. Below 500 we
# render the page inside an iframe of the true width, on a neutral ground, in a
# wider window. The page then genuinely sees its target viewport.
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

TARGET="$URL"
WIN_W="$W"
WIN_H="$H"
WRAPPER=""

if [ "$W" -lt 500 ]; then
  WRAPPER="$(mktemp -t wcdshot).html"
  PAD=40
  WIN_W=$(( W + PAD * 2 ))
  [ "$WIN_W" -lt 500 ] && WIN_W=500
  WIN_H=$(( H + PAD ))
  cat > "$WRAPPER" <<HTML
<style>
  html,body{margin:0;height:100%;background:#e9e9e9}
  .stage{display:flex;justify-content:center;align-items:flex-start;height:100%;padding-top:${PAD}px;box-sizing:border-box}
  iframe{width:${W}px;height:${H}px;border:0;background:#fff;box-shadow:0 2px 28px rgba(0,0,0,.18)}
</style>
<div class="stage"><iframe src="${URL}"></iframe></div>
HTML
  TARGET="file://$WRAPPER"
fi

"$CHROME" --headless=new --disable-gpu --hide-scrollbars \
  --allow-file-access-from-files \
  --force-device-scale-factor="$S" \
  --virtual-time-budget=4000 \
  --window-size="$WIN_W,$WIN_H" \
  --screenshot="$OUT" "$TARGET" >/dev/null 2>&1

[ -n "$WRAPPER" ] && rm -f "$WRAPPER"
echo "$OUT"
