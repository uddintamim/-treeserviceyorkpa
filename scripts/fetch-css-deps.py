#!/usr/bin/env python3
"""Download the fonts/sprites/images that Weebly's CSS files reference, so the site is self-hosted."""
import re, os, sys, urllib.request
from urllib.parse import urljoin, urlparse
BASES = {
  'css/sites.css': 'https://cdn11.editmysite.com/css/sites.css',
  'css/old/fancybox.css': 'https://cdn11.editmysite.com/css/old/fancybox.css',
  'css/social-icons.css': 'https://cdn11.editmysite.com/css/social-icons.css',
}
for n in ('Lato', 'Fjalla_One', 'Lora', 'Questrial'):
    BASES[f'fonts/{n}/font.css'] = f'https://cdn2.editmysite.com/fonts/{n}/font.css'
ROOT = 'public/weebly-cdn'
def fetch(url, dest):
    if os.path.exists(dest): return
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (compatible; site-migration)'})
        open(dest, 'wb').write(urllib.request.urlopen(req, timeout=30).read()); print('ok  ', url)
    except Exception as e:
        print('FAIL', url, e)
for rel, base in BASES.items():
    path = os.path.join(ROOT, rel)
    if not os.path.exists(path): print('FAIL missing css', path); continue
    css = open(path, encoding='utf-8', errors='replace').read()
    for m in set(re.findall(r'url\(\s*["\']?([^"\')]+)["\']?\s*\)', css)):
        if m.startswith('data:'): continue
        ref = m.split('#')[0].split('?')[0]
        full = urljoin(base, ref)
        if ref.startswith('/') and not ref.startswith('//'):       # root-relative: keep same path on our own domain
            dest = os.path.join('public', ref.lstrip('/'))
        else:
            dest = os.path.join(ROOT, urlparse(full).path.lstrip('/'))
        fetch(full, dest)
