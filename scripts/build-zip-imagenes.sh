#!/usr/bin/env bash
# Genera un .zip con todas las imagenes de productos y del uniforme completo,
# organizadas en carpetas por producto.
#
#   bash scripts/build-zip-imagenes.sh [carpeta_de_salida]
#
# Salida: Textiles_Pelileo_Imagenes_Productos_y_Uniforme.zip

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${1:-$ROOT/dist}"
WEB="$ROOT/web textiles pelileo 1"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

BASE="$STAGE/Textiles Pelileo - Imagenes"
mkdir -p "$BASE"

# Copia un archivo al destino solo si existe y pesa mas de 1 KB
# (el repo tiene varios marcadores de 1-2 bytes que no son imagenes reales).
copy() {
  local src="$1" dest_dir="$2" dest_name="${3:-}"
  if [[ ! -f "$src" ]]; then
    echo "  omitido (no existe): $src" >&2
    return 0
  fi
  if [[ $(stat -c%s "$src") -lt 1024 ]]; then
    echo "  omitido (archivo vacio/placeholder): $src" >&2
    return 0
  fi
  mkdir -p "$dest_dir"
  cp "$src" "$dest_dir/${dest_name:-$(basename "$src")}"
}

P="$BASE/01 Productos"
U="$BASE/02 Uniforme completo"

# ---------------------------------------------------------------- Productos --
copy "$ROOT/Pantalón de 14 onzas 1.png" "$P/Pantalon de 14 onzas"
copy "$ROOT/Pantalón de 14 onzas 2.png" "$P/Pantalon de 14 onzas"
copy "$ROOT/Pantalón de 14 onzas 3.png" "$P/Pantalon de 14 onzas"
copy "$ROOT/Pantalón de 14 onzas 4.png" "$P/Pantalon de 14 onzas"
copy "$ROOT/Pantalón de 14 onzas 5.png" "$P/Pantalon de 14 onzas"

copy "$ROOT/Pantalón de 12 onzas 1.png" "$P/Pantalon de 12 onzas"
copy "$ROOT/Pantalón de 12 onzas 2.png" "$P/Pantalon de 12 onzas"
copy "$ROOT/Pantalón de 12 onzas 3.png" "$P/Pantalon de 12 onzas"
copy "$ROOT/Pantalón de 12 onzas 4.png" "$P/Pantalon de 12 onzas"
copy "$ROOT/Pantalón de 12 onzas 5.png" "$P/Pantalon de 12 onzas"

copy "$ROOT/Pantalón strech 1.png" "$P/Pantalon strech"
copy "$ROOT/Pantalón strech 2.png" "$P/Pantalon strech"
copy "$ROOT/Pantalón strech 3.png" "$P/Pantalon strech"
copy "$ROOT/Pantalón strech 4.png" "$P/Pantalon strech"
copy "$ROOT/Pantalón strech 5.png" "$P/Pantalon strech"
copy "$ROOT/Pantalón strech 6.png" "$P/Pantalon strech"
copy "$WEB/img/img pantalon strech toma principal de portada" \
     "$P/Pantalon strech" "Pantalon strech - portada.png"
copy "$WEB/img/pantalon strech la parte de adelante" \
     "$P/Pantalon strech" "Pantalon strech - adelante.png"
copy "$WEB/img/pantalon strech la parte de atras" \
     "$P/Pantalon strech" "Pantalon strech - atras.png"

copy "$ROOT/camisa jean 1.png" "$P/Camisa jean"
copy "$ROOT/camisa jean 2.png" "$P/Camisa jean"
copy "$ROOT/camisa jean 3.png" "$P/Camisa jean"
copy "$ROOT/camisa jean 4.png" "$P/Camisa jean"
copy "$ROOT/camisa jean 5.png" "$P/Camisa jean"

copy "$ROOT/buzo con capucha 1 .png" "$P/Buzo con capucha" "buzo con capucha 1.png"
copy "$ROOT/buzo con capucha 2.png" "$P/Buzo con capucha"
copy "$ROOT/buzo con capucha 3.png" "$P/Buzo con capucha"
copy "$ROOT/buzo con capucha 4.png" "$P/Buzo con capucha"
copy "$ROOT/buzo con capucha 5.png" "$P/Buzo con capucha"
copy "$WEB/img/buzo con capucha" "$P/Buzo con capucha" "Buzo con capucha - portada.png"

copy "$ROOT/buzo jersey 1.png" "$P/Buzo tela jersey"
copy "$ROOT/buzo jersey 2.png" "$P/Buzo tela jersey"
copy "$ROOT/buzo jersey 3.png" "$P/Buzo tela jersey"
copy "$ROOT/buzo jersey 4.png" "$P/Buzo tela jersey"
copy "$ROOT/buzo jersey 5.png" "$P/Buzo tela jersey"
copy "$WEB/img/buzo tela jersey" "$P/Buzo tela jersey" "Buzo tela jersey - portada.png"

copy "$ROOT/Buzo tela pique 1.png" "$P/Buzo tela pique cuello polo"
copy "$ROOT/Buzo tela pique 2.png" "$P/Buzo tela pique cuello polo"
copy "$ROOT/Buzo tela pique 3.png" "$P/Buzo tela pique cuello polo"
copy "$ROOT/Buzo tela pique 4.png" "$P/Buzo tela pique cuello polo"
copy "$ROOT/Buzo tela pique 5.png" "$P/Buzo tela pique cuello polo"
copy "$WEB/img/buzo tela pique cuello polo" \
     "$P/Buzo tela pique cuello polo" "Buzo tela pique cuello polo - portada.png"

copy "$ROOT/Camiseta tela Jersey 1.png" "$P/Camiseta cuello redondo tela jersey"
copy "$ROOT/Camiseta tela Jersey 2.png" "$P/Camiseta cuello redondo tela jersey"
copy "$ROOT/Camiseta tela Jersey 3.png" "$P/Camiseta cuello redondo tela jersey"
copy "$ROOT/Camiseta tela Jersey 4.png" "$P/Camiseta cuello redondo tela jersey"
copy "$ROOT/Camiseta tela Jersey 5.png" "$P/Camiseta cuello redondo tela jersey"
copy "$WEB/img/camiseta cuello redondo tela jersey" \
     "$P/Camiseta cuello redondo tela jersey" "Camiseta cuello redondo tela jersey - portada.png"

copy "$ROOT/Camiseta tela Piqué 1.png" "$P/Camiseta polo tela pique"
copy "$ROOT/Camiseta tela Piqué 2.png" "$P/Camiseta polo tela pique"
copy "$ROOT/Camiseta tela Piqué 3.png" "$P/Camiseta polo tela pique"
copy "$ROOT/Camiseta tela Piqué 4.png" "$P/Camiseta polo tela pique"
copy "$ROOT/Camiseta tela Piqué 5.png" "$P/Camiseta polo tela pique"
copy "$WEB/img/camiseta polo tela pique" \
     "$P/Camiseta polo tela pique" "Camiseta polo tela pique - portada.png"

copy "$ROOT/Chaleco tele anti fluido 1.png" "$P/Chaleco tela anti fluido"
copy "$ROOT/Chaleco tele anti fluido 2.png" "$P/Chaleco tela anti fluido"
copy "$ROOT/Chaleco tele anti fluido 3.png" "$P/Chaleco tela anti fluido"
copy "$ROOT/Chaleco tele anti fluido 4.png" "$P/Chaleco tela anti fluido"
copy "$ROOT/Chaleco tele anti fluido 5.png" "$P/Chaleco tela anti fluido"
copy "$WEB/img/chaleco anti fluidos" \
     "$P/Chaleco tela anti fluido" "Chaleco anti fluidos - portada.png"

copy "$ROOT/chalecos gabardina 1.png" "$P/Chaleco tela gabardina"
copy "$ROOT/chalecos gabardina 2.png" "$P/Chaleco tela gabardina"
copy "$ROOT/chalecos gabardina 3.png" "$P/Chaleco tela gabardina"
copy "$ROOT/chalecos gabardina 4.png" "$P/Chaleco tela gabardina"
copy "$ROOT/chalecos gabardina 5.png" "$P/Chaleco tela gabardina"
copy "$WEB/img/chaleco tela gabardina" \
     "$P/Chaleco tela gabardina" "Chaleco tela gabardina - portada.png"

# --------------------------------------------------- Uniforme completo ($31) --
copy "$WEB/uniforme.webp" "$U" "Uniforme completo - conjunto.webp"
copy "$WEB/img/IMG_20260430_134155.jpg" "$U" "Uniforme completo - cuadrilla.jpg"
copy "$WEB/img/IMG-20260423-WA0009.jpg" "$U" "Uniforme completo - en uso 1.jpg"
copy "$WEB/img/IMG-20260507-WA0008.jpg" "$U" "Uniforme completo - en uso 2.jpg"

copy "$WEB/camisa.webp" "$U/Camisa del conjunto"
copy "$WEB/camisa adelante y atras.webp" "$U/Camisa del conjunto"
copy "$ROOT/public_html/img/Pantalon1.webp" "$U/Pantalon del conjunto"
copy "$ROOT/public_html/img/Pantalon2.webp" "$U/Pantalon del conjunto"
copy "$ROOT/public_html/img/pantalon  sin fondo.webp" "$U/Pantalon del conjunto" "pantalon sin fondo.webp"
copy "$ROOT/public_html/img/portada-textiles-pelileo-jeans.webp" "$U/Pantalon del conjunto"

D="$U/Detalles y confeccion"
copy "$WEB/doble bolsillo.webp" "$D"
copy "$WEB/bordado primero plano.webp" "$D"
copy "$WEB/bordado en la espalda.webp" "$D"
copy "$WEB/bordado iamgen amplia.webp" "$D"
copy "$WEB/barios bordados.webp" "$D"
copy "$ROOT/public_html/img/TELA 14 OZ QUE NO DESTIÑE.jpg" "$D"
copy "$ROOT/public_html/img/TRIPLE REFUERZO Y ESTILO..jpg" "$D" "TRIPLE REFUERZO Y ESTILO.jpg"
copy "$ROOT/public_html/img/HERRAJES INOXIDABLES.jpg" "$D"

# ------------------------------------------------------------------- Empaque --
cat > "$BASE/LEEME.txt" <<'TXT'
TEXTILES PELILEO - Imagenes de productos y uniforme completo
============================================================

01 Productos/
   Una carpeta por producto del catalogo, con sus fotos numeradas.
   Las imagenes "- portada" son las tomas principales usadas en la web.

02 Uniforme completo/
   Conjunto Uniforme Industrial ($31.00: pantalon + camisa con cintas
   reflectivas 360 grados).
   - Camisa del conjunto/       fotos de la camisa de trabajo
   - Pantalon del conjunto/     fotos del pantalon / jean de trabajo
   - Detalles y confeccion/     bordados, doble bolsillo, herrajes,
                                triple refuerzo y tela 14 oz

Formatos: .png y .jpg son los originales de alta resolucion;
.webp son las versiones optimizadas que usa el sitio web.

Contacto / pedidos: WhatsApp +593 98 663 4114
TXT

mkdir -p "$OUT_DIR"
ZIP="$OUT_DIR/Textiles_Pelileo_Imagenes_Productos_y_Uniforme.zip"
rm -f "$ZIP"
( cd "$STAGE" && zip -r -q "$ZIP" "Textiles Pelileo - Imagenes" )

echo
echo "Listo: $ZIP"
echo "Imagenes incluidas: $(find "$BASE" -type f ! -name 'LEEME.txt' | wc -l)"
du -h "$ZIP"
