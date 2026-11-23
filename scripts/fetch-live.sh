#!/usr/bin/env bash
# Pulls everything the Weebly backup was missing, straight from the LIVE site:
#  - the 24 images (logo, hero/background images)
#  - a snapshot of every live page (real <head> tags incl. Open Graph) in live-snapshot/
#  - Weebly's CDN CSS/JS/fonts, so the site no longer depends on Weebly (public/weebly-cdn/)
# Runs on GitHub Actions (see .github/workflows/fetch-assets.yml) or locally: bash scripts/fetch-live.sh
set -u
HOST="${HOST:-https://www.treeserviceyorkpa.org}"
UA="Mozilla/5.0 (compatible; site-migration)"
get() { mkdir -p "$(dirname "$2")"; if curl -fsSL -A "$UA" --retry 2 "$1" -o "$2"; then echo "ok   $1"; else echo "FAIL $1"; rm -f "$2"; fi; }

# 1. images missing from the backup
get "$HOST/uploads/8/6/7/7/86774124/background-images/1018409514.jpg" "public/uploads/8/6/7/7/86774124/background-images/1018409514.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1135553684.jpg" "public/uploads/8/6/7/7/86774124/background-images/1135553684.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1307305187.jpg" "public/uploads/8/6/7/7/86774124/background-images/1307305187.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1325576166.jpg" "public/uploads/8/6/7/7/86774124/background-images/1325576166.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1394745004.jpg" "public/uploads/8/6/7/7/86774124/background-images/1394745004.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1487323704.jpg" "public/uploads/8/6/7/7/86774124/background-images/1487323704.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1581453171.jpg" "public/uploads/8/6/7/7/86774124/background-images/1581453171.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1633936405.jpg" "public/uploads/8/6/7/7/86774124/background-images/1633936405.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1708783154.jpg" "public/uploads/8/6/7/7/86774124/background-images/1708783154.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1712908625.jpg" "public/uploads/8/6/7/7/86774124/background-images/1712908625.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/1753917157.jpg" "public/uploads/8/6/7/7/86774124/background-images/1753917157.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/2047152931.jpg" "public/uploads/8/6/7/7/86774124/background-images/2047152931.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/218897007.jpg" "public/uploads/8/6/7/7/86774124/background-images/218897007.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/220426886.jpg" "public/uploads/8/6/7/7/86774124/background-images/220426886.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/452033051.jpg" "public/uploads/8/6/7/7/86774124/background-images/452033051.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/483130609.jpg" "public/uploads/8/6/7/7/86774124/background-images/483130609.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/494902892.jpg" "public/uploads/8/6/7/7/86774124/background-images/494902892.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/595030573.jpg" "public/uploads/8/6/7/7/86774124/background-images/595030573.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/62361840.jpg" "public/uploads/8/6/7/7/86774124/background-images/62361840.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/682892185.jpg" "public/uploads/8/6/7/7/86774124/background-images/682892185.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/843612949.jpg" "public/uploads/8/6/7/7/86774124/background-images/843612949.jpg"
get "$HOST/uploads/8/6/7/7/86774124/background-images/95997424.jpg" "public/uploads/8/6/7/7/86774124/background-images/95997424.jpg"
get "$HOST/uploads/8/6/7/7/86774124/editor/add-a-heading-6.png" "public/uploads/8/6/7/7/86774124/editor/add-a-heading-6.png"
get "$HOST/uploads/8/6/7/7/86774124/tree-removal-york-pa.png" "public/uploads/8/6/7/7/86774124/tree-removal-york-pa.png"

# 2. live snapshot of every page + blog post
for slug in $(jq -r 'keys[]' src/data/pages.json); do
  case "$slug" in
    index) get "$HOST/" "live-snapshot/index.html" ;;
    blog/*) get "$HOST/$slug" "live-snapshot/$slug.html" ;;
    *) get "$HOST/$slug.html" "live-snapshot/$slug.html" ;;
  esac
done
for slug in 6-common-mistakes-you-can-make-with-your-trees how-a-harsh-winter-can-damage-your-trees how-can-snow-damage-my-trees how-to-prepare-your-lawn-for-the-fall is-my-lawn-soil-compacted-what-should-i-do tree-bark-is-essential-in-protecting-your-tree when-to-prune-trees why-are-my-trees-cracking-is-it-frost-crack why-you-should-hire-an-arborist-that-is-certified ; do
  get "$HOST/blog/$slug" "live-snapshot/blog/$slug.html"
done
get "$HOST/blog/previous/2" "live-snapshot/blog/previous/2.html"
get "$HOST/robots.txt" "live-snapshot/robots.txt"
get "$HOST/sitemap.xml" "live-snapshot/sitemap.xml"

# 3. Weebly CDN assets referenced by every page
CDN=https://cdn11.editmysite.com
for p in css/sites.css css/old/fancybox.css css/social-icons.css js/jquery-1.8.3.min.js js/site/main.js js/site/main-customer-accounts-site.js; do
  get "$CDN/$p" "public/weebly-cdn/$p"
done
for f in Lato Fjalla_One Lora Questrial; do get "https://cdn2.editmysite.com/fonts/$f/font.css" "public/weebly-cdn/fonts/$f/font.css"; done
get "https://cdn2.editmysite.com/js/lang/en/stl.js" "public/weebly-cdn/js/lang/en/stl.js"

python3 scripts/fetch-css-deps.py

# 4. EVERY blog post listed in the live sitemap (the backup only contained 10), plus blog index pages 2..N
for slug in $(grep -o '<loc>[^<]*/blog/[^<]*' live-snapshot/sitemap.xml | sed 's#.*/blog/##'); do
  [ -f "live-snapshot/blog/$slug.html" ] || get "$HOST/blog/$slug" "live-snapshot/blog/$slug.html"
done
for n in $(seq 2 20); do
  get "$HOST/blog/previous/$n" "live-snapshot/blog/previous/$n.html"
  [ -f "live-snapshot/blog/previous/$n.html" ] || break
done

# 5. every image/file those live pages reference that we do not have yet
python3 scripts/fetch-uploads.py
