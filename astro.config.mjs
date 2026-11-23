import { defineConfig } from 'astro/config';

// Custom domain on GitHub Pages: set `site` to the domain and do NOT set `base`.
export default defineConfig({
  site: 'https://www.treeserviceyorkpa.org',
  output: 'static',
  // Keep Weebly's URLs: /about.html, /services.html, /blog/<slug> (served from blog/<slug>.html)
  build: { format: 'file' },
  trailingSlash: 'ignore',
  // Keep the original markup byte-for-byte (Weebly's scripts/CSS depend on it)
  compressHTML: false,
  devToolbar: { enabled: false },
});
