// Renderiza catalogo-textiles-pelileo.html -> PDF A4 con Chromium headless.
// Requiere: npm i -g playwright   (o usar el Chromium ya instalado)
const path = require('path');
const { chromium } = require('playwright');

(async () => {
  const dir = __dirname;
  const browser = await chromium.launch();
  const page = await browser.newPage();
  await page.goto('file://' + path.join(dir, 'catalogo-textiles-pelileo.html'),
                  { waitUntil: 'networkidle' });
  await page.evaluate(() => document.fonts.ready);
  await page.pdf({
    path: path.join(dir, 'Catalogo-Textiles-Pelileo-2026.pdf'),
    format: 'A4',
    printBackground: true,
    preferCSSPageSize: true,
    margin: { top: '0', right: '0', bottom: '0', left: '0' },
  });
  await browser.close();
})();
