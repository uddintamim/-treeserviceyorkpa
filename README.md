# Tree Service York PA – Astro rebuild of the Weebly site

139 static pages (37 main pages, 93 blog posts, 9 blog index pages) built with Astro. Content, titles, meta description/keywords,
Open Graph tags, headings, links, image `src`/`alt`, robots.txt and sitemap.xml were taken from the live site
(`live-snapshot/` is the reference copy) and verified identical page by page.

## Upload to SiteGround (no WordPress, no installs)
1. GitHub → **Actions** → latest "Deploy to GitHub Pages" run → **Artifacts** → download **siteground-upload** (a zip).
2. Unzip it. SiteGround → **Site Tools → Site → File Manager → public_html**.
3. Upload the *contents* of the unzipped folder (including the hidden `.htaccess`) into `public_html`.
4. Test on a temporary subdomain first, then point the real domain.

## Layout
- `src/data/pages.json` – per-page title/meta/body class/nav state
- `src/fragments/pages/*` – per-page content (identical to live markup); `src/fragments/_*.html` – shared head/header/footer/scripts
- `src/layouts/Layout.astro`, `src/pages/[...slug].astro` – templates/routing
- `public/` – uploads (images), Weebly CSS/JS/fonts (self-hosted in `weebly-cdn/`), robots.txt, sitemap.xml, `.htaccess`
- `scripts/fetch-live.sh` – re-downloads assets/snapshot from the live site (runs via the "Fetch live assets" workflow)

## Known remaining dependencies on Weebly
- FAQ accordion + Widgetic widget load their scripts from `marketplace.editmysite.com`.
- Weebly's `main.js` can lazy-load extra modules from `cdn*.editmysite.com`.
- Google Analytics tag `UA-135608298-1` is Universal Analytics (no longer collects data) – add a GA4 tag.
