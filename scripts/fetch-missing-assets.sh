#!/usr/bin/env bash
# Downloads images the Weebly backup did not include, straight from the live site.
# Run this BEFORE you repoint DNS (while the old Weebly site is still live), from the project root.
set -u
HOST="${1:-http://www.treeserviceyorkpa.org}"
fetch() { mkdir -p "public/$(dirname "$1")"; curl -fsSL "$HOST/$1" -o "public/$1" && echo "ok   $1" || echo "FAIL $1"; }
fetch "uploads/8/6/7/7/86774124/background-images/1018409514.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1135553684.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1307305187.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1325576166.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1394745004.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1487323704.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1581453171.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1633936405.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1708783154.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1712908625.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/1753917157.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/2047152931.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/218897007.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/220426886.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/452033051.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/483130609.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/494902892.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/595030573.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/62361840.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/682892185.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/843612949.jpg"
fetch "uploads/8/6/7/7/86774124/background-images/95997424.jpg"
fetch "uploads/8/6/7/7/86774124/editor/add-a-heading-6.png"
fetch "uploads/8/6/7/7/86774124/tree-removal-york-pa.png"

# Blog posts that are linked from your pages but were NOT in the backup (saved for re-import):
mkdir -p missing-blog-html
for slug in 6-common-mistakes-you-can-make-with-your-trees how-a-harsh-winter-can-damage-your-trees how-can-snow-damage-my-trees how-to-prepare-your-lawn-for-the-fall is-my-lawn-soil-compacted-what-should-i-do tree-bark-is-essential-in-protecting-your-tree when-to-prune-trees why-are-my-trees-cracking-is-it-frost-crack why-you-should-hire-an-arborist-that-is-certified; do
  curl -fsSL "$HOST/blog/$slug" -o "missing-blog-html/$slug.html" && echo "ok   blog/$slug" || echo "FAIL blog/$slug"
done
