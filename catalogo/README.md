# Catálogo digital — Textiles Pelileo

Catálogo editorial de 10 páginas, A4 vertical, para departamentos de compras.

- **PDF final:** `Catalogo-Textiles-Pelileo-2026.pdf` (10 páginas · 2,7 MB)
- **Fuente:** `catalogo-textiles-pelileo.html` + `assets/`

## Regenerar el PDF

```bash
node render.js          # Chromium headless -> PDF, A4, sin márgenes
```

Tipografías: Barlow Condensed (títulos) y Archivo (texto), ambas OFL.
Paleta: azul marino `#0B1F3A`, dorado `#E8A93A`, crema `#F4EFE6`.

## Procedencia de las imágenes

Todas las imágenes provienen del material propio del repositorio. Los `assets`
se generaron normalizando el fondo de las fotos de producto a un mismo tono
(`#EAE7E3`) y recortando los detalles.

| Asset | Origen | Tipo |
|---|---|---|
| `cover-trabajador`, `cierre` | `public_html/img/uniforme.webp` | render |
| `taller` | `web textiles pelileo 1/img/IMG_20260430_134155.jpg` | **foto real** |
| `pantalon-hero`, `pantalon-detalle` | `Pantalón de 12 onzas 1.png` / `3.png` | render |
| `camisa-hero` | `camisa jean 1.png` | render |
| `camisa-detalle` | `public_html/img/doble bolsillo.webp` | **foto real** |
| `polo-hero`, `polo-detalle` | `Camiseta tela Piqué 1.png` / `4.png` | render |
| `buzo-hero`, `buzo-detalle` | `buzo con capucha 1 .png` / `4.png` | render |
| `bordado-hero` | `public_html/img/barios bordados.webp` | **foto real** |
| `bordado-cerca`, `bordado-espalda` | `public_html/img/bordado *.webp` | **foto real** |
| `logo`, `logo-light` | `public_html/img/logo-w.webp` | logo de marca |

## Imágenes descartadas — importante

Las siguientes imágenes del repositorio **no se usaron** porque muestran marcas
registradas de terceros (etiqueta de cuero Levi Strauss & Co., *red tab*,
costura arqueada del bolsillo trasero y un holograma "LIVAI'S / 550"):

- `Pantalón de 12 onzas 2/4/5.png` y todo `Pantalón de 14 onzas *.png`
  (son duplicados byte a byte de los de 12 onzas)
- `Pantalón strech 1–6.png`
- `public_html/img/TRIPLE REFUERZO Y ESTILO..jpg`
- `public_html/img/HERRAJES INOXIDABLES.jpg`
- `public_html/img/TELA 14 OZ QUE NO DESTIÑE.jpg`
- `public_html/img/pantalon  sin fondo.webp`, `Pantalon2.webp`
- `public_html/img/testimonio 1–4.jpg`
- `public_html/img/portada-textiles-pelileo-jeans.webp` (además incluye una
  menor y una marca de agua de IA)
- `public_html/img/PELILEO-2-scaled.webp` (marca de agua "WorkForce Pro®")

Del pantalón sólo se pudieron usar **dos tomas frontales** (`1` y `3`), que son
las únicas sin marcas visibles.

Las fotos de bordado muestran logos de clientes reales (CUBITECK, Taller
Industrial Asimbaya) y un número de teléfono. Conviene contar con su
autorización por escrito antes de distribuir el catálogo.
