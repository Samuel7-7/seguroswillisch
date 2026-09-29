# =========================================================
#  SEGUROS WILLISCH — FOTOS NUEVAS A SU LUGAR
#
#  Uso (desde la raíz del proyecto):
#      python _generador/fotos.py
#      perl _generador/generar.pl
#
#  Toma cada assets/img/nuevas/<número>.<ext>, busca ese número en la tabla
#  de assets/img/PENDIENTES-IMAGENES.md, la recorta por el centro a su
#  proporción, la baja a la medida de la tabla y la guarda en WebP con el
#  nombre final. Después generar.pl cambia el hueco por la foto.
#  Necesita Pillow: pip install pillow
# =========================================================
import re
import sys
from pathlib import Path

from PIL import Image, ImageOps

RAIZ = Path(__file__).resolve().parent.parent
IMG = RAIZ / "assets" / "img"
NUEVAS = IMG / "nuevas"


def tabla():
    md = (IMG / "PENDIENTES-IMAGENES.md").read_text(encoding="utf-8")
    filas = {}
    for m in re.finditer(r"^\| \*\*(\d+)\*\* \|[^|]*\|[^|]*\| (\d+)×(\d+) \|[^|]*\| `([^`]+)` \|$", md, re.M):
        filas[int(m.group(1))] = (int(m.group(2)), int(m.group(3)), m.group(4))
    return filas


def main():
    filas = tabla()
    hechas = 0
    for f in sorted(NUEVAS.iterdir()):
        if not f.stem.isdigit() or f.suffix.lower() not in (".jpg", ".jpeg", ".png", ".webp"):
            continue
        n = int(f.stem)
        if n not in filas:
            print(f"  ! {f.name}: el número {n} no está en la lista")
            continue
        w, h, destino = filas[n]
        im = ImageOps.exif_transpose(Image.open(f)).convert("RGB")
        im = ImageOps.fit(im, (w, h), Image.LANCZOS, centering=(0.5, 0.5))
        salida = IMG / destino
        salida.parent.mkdir(parents=True, exist_ok=True)
        im.save(salida, "WEBP", quality=78, method=6)
        print(f"  + {f.name} -> assets/img/{destino} ({salida.stat().st_size // 1024} KB)")
        hechas += 1
    print(f"{hechas} fotos listas. Ahora corre: perl _generador/generar.pl")


if __name__ == "__main__":
    sys.exit(main())
