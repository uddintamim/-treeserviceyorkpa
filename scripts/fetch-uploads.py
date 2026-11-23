#!/usr/bin/env python3
"""Download every /uploads/... file referenced by the live snapshot that is not in public/ yet."""
import re, os, glob, urllib.request
HOST = os.environ.get('HOST', 'https://www.treeserviceyorkpa.org')
PAT = re.compile(r"(?:https?:)?(?://www\.treeserviceyorkpa\.org)?(/uploads/[^\"'\s)<>?&]+)")
refs = set()
for f in glob.glob('live-snapshot/**/*.html', recursive=True):
    refs.update(PAT.findall(open(f, encoding='utf-8', errors='replace').read()))
ok = fail = 0
for r in sorted(refs):
    dest = 'public' + r
    if os.path.exists(dest): continue
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    try:
        req = urllib.request.Request(HOST + r, headers={'User-Agent': 'Mozilla/5.0 (compatible; site-migration)'})
        open(dest, 'wb').write(urllib.request.urlopen(req, timeout=30).read()); ok += 1
    except Exception as e:
        fail += 1; print('FAIL', r, e)
print(f'uploads: {ok} downloaded, {fail} failed, {len(refs)} referenced')
