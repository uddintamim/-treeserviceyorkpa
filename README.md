# Tree Service York PA – Astro rebuild (from Weebly backup)

Static Astro site that reproduces the Weebly pages: same URLs (`/about.html`, `/services.html`, `/blog/<slug>`), titles, meta description/keywords, headings, links, image `src`/`alt` and Weebly markup/CSS classes.

## Before going live
1. `npm install` (creates `package-lock.json`; commit it).
2. While the old Weebly site is still live, run `bash scripts/fetch-missing-assets.sh` (logo, hero/background images and 9 blog posts were not in the backup).
3. `npm run build` and check `dist/`.
4. Push to GitHub `main`; Settings → Pages → Source: **GitHub Actions**.
5. DNS: `www` CNAME → `<user>.github.io`; apex A records → GitHub Pages IPs. `public/CNAME` is `www.treeserviceyorkpa.org`.

## Layout
- `src/data/pages.json` – per-page title/meta/body class/nav state
- `src/fragments/pages/*` – per-page banner + main content (original markup)
- `src/fragments/_*.html` – shared head, header/nav, footer, mobile nav, scripts
- `src/layouts/Layout.astro`, `src/pages/[...slug].astro` – templates/routing
- `public/` – uploads, CSS/JS, sitemap.xml, robots.txt, CNAME

## Known notes
- Weebly CDN CSS/JS (`cdn11.editmysite.com`) is still referenced (switched to https) for identical styling; it works only while Weebly serves it. Plan to self-host.
- Weebly forms/widgets (Leadsnap, Formilla, Widgetic) are external embeds and kept as-is.
- Google Analytics `UA-135608298-1` is kept, but Universal Analytics no longer collects data; add a GA4 tag.
