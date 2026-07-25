#!/usr/bin/env python3
"""Genera una version ligera del ZIP de imagenes (misma estructura de carpetas).

Convierte cada imagen a JPG redimensionado, pensado para enviar por WhatsApp,
correo o subir a catalogos. Las originales en alta resolucion se obtienen con
scripts/build-zip-imagenes.sh.

    python3 scripts/build-zip-imagenes-ligero.py [zip_original] [zip_salida]
"""

import io
import sys
import zipfile
from pathlib import Path

from PIL import Image

MAX_LADO = 1600
CALIDAD = 82
ROOT = Path(__file__).resolve().parent.parent

origen = Path(sys.argv[1]) if len(sys.argv) > 1 else (
    ROOT / "dist" / "Textiles_Pelileo_Imagenes_Productos_y_Uniforme.zip"
)
destino = Path(sys.argv[2]) if len(sys.argv) > 2 else (
    ROOT / "dist" / "Textiles_Pelileo_Imagenes_Productos_y_Uniforme_LIGERO.zip"
)


def optimizar(datos: bytes) -> bytes:
    img = Image.open(io.BytesIO(datos))
    # Fondo blanco: los PNG de producto son transparentes y en JPG saldrian negros.
    if img.mode in ("RGBA", "LA", "P"):
        img = img.convert("RGBA")
        fondo = Image.new("RGB", img.size, (255, 255, 255))
        fondo.paste(img, mask=img.split()[-1])
        img = fondo
    else:
        img = img.convert("RGB")

    if max(img.size) > MAX_LADO:
        escala = MAX_LADO / max(img.size)
        img = img.resize(
            (round(img.width * escala), round(img.height * escala)),
            Image.LANCZOS,
        )

    buf = io.BytesIO()
    img.save(buf, "JPEG", quality=CALIDAD, optimize=True, progressive=True)
    return buf.getvalue()


destino.parent.mkdir(parents=True, exist_ok=True)
convertidas = 0

with zipfile.ZipFile(origen) as zin, zipfile.ZipFile(
    destino, "w", zipfile.ZIP_DEFLATED
) as zout:
    for info in zin.infolist():
        if info.is_dir():
            continue
        datos = zin.read(info)
        if info.filename.lower().endswith(".txt"):
            zout.writestr(info.filename, datos)
            continue
        nombre = str(Path(info.filename).with_suffix(".jpg"))
        zout.writestr(nombre, optimizar(datos))
        convertidas += 1

mb = destino.stat().st_size / 1024 / 1024
print(f"Listo: {destino}")
print(f"Imagenes convertidas: {convertidas} | Tamano: {mb:.1f} MB")
