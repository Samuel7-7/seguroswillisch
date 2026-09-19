# Imágenes pendientes — página `/personas.html`

## Cómo usar este archivo

Cada fila de abajo tiene una **ruta exacta**. En el sitio ya hay un archivo en esa ruta
con el patrón de marca (degradado + escudo), del tamaño correcto, así que **la página
no tiene huecos ni imágenes rotas**.

Para poner la foto real:

1. Recorta la foto a la proporción indicada y guárdala como **WebP, calidad 80**.
2. Guarda **dos archivos** con los nombres exactos: `nombre.webp` (tamaño grande) y
   `nombre-800.webp` (la mitad de ancho, para celulares).
3. Reemplaza los archivos existentes en `assets/img/`.
4. Sube el cambio. **No hay que tocar nada de código**: la página los toma tal cual.

> Si solo tienes la foto en JPG o PNG, mándamela y yo hago la conversión y los dos tamaños.

**Criterio para todas:** luz natural cálida, personas latinoamericanas en contextos
colombianos, composición limpia con espacio para el texto, **sin logos ni marcas
visibles**, y sin rostros que puedan leerse como clientes reales de la agencia.

Prompt base si las generas con IA:
`editorial photography, natural warm light, shallow depth of field, Latin American people, Colombian setting, clean composition with negative space, 35mm, cinematic color grading, no logos, no text`

---

## Pendientes (10)

| Ruta | Dónde se ve | Proporción / tamaño mínimo | Qué debe mostrar |
|---|---|---|---|
| `assets/img/hero-vida.webp` | Tríptico del hero, panel derecho | 3:4 · 1200×1600 | Familia en casa, luz cálida de tarde, escena cotidiana y tranquila |
| `assets/img/vehiculo-carretera.webp` | Galería del bloque Vehículo | 16:9 · 1600×900 | Carro recorriendo una vía, tomado desde afuera, hora dorada |
| `assets/img/vehiculo-moto.webp` | Galería del bloque Vehículo | 4:3 · 1600×1200 | Motociclista urbano con casco, luz de mañana |
| `assets/img/vehiculo-grua.webp` | Galería del bloque Vehículo | 4:3 · 1600×1200 | Asistencia en vía o grúa atendiendo un vehículo |
| `assets/img/salud-familia.webp` | Bloque Salud, galería | 4:3 · 1600×1200 | Consulta pediátrica: madre o padre con el niño y el médico |
| `assets/img/salud-clinica.webp` | Bloque Salud, galería | 4:3 · 1600×1200 | Pasillo o sala de espera de clínica moderna y luminosa |
| `assets/img/vida-familia.webp` | Bloque Vida, pieza ancha | 16:9 · 1600×900 | Familia de varias generaciones reunida en casa, luz de ventana |
| `assets/img/vida-hogar.webp` | Bloque Vida, visual lateral | 4:3 · 1600×1200 | Pareja joven con las llaves de su vivienda |
| `assets/img/vida-estudio.webp` | Bloque Vida, galería | 4:3 · 1600×1200 | Adolescente estudiando en su escritorio, luz natural |
| `assets/img/financiacion-calendario.webp` | Banda de financiación | 4:3 · 1600×1200 | Manos con el teléfono y un calendario, café, mañana tranquila |

---

## Ya tienen foto real (4)

Estas funcionan, pero son de banco genérico y se pueden mejorar cuando haya material propio.

| Ruta | Dónde se ve | De dónde salió |
|---|---|---|
| `assets/img/hero-vehiculo.webp` | Tríptico del hero, panel izquierdo | Carretera con vehículos (la del hero anterior) |
| `assets/img/hero-salud.webp` | Tríptico del hero, panel central | Profesional de la salud junto a una ventana |
| `assets/img/vehiculo-taller.webp` | Galería del bloque Vehículo | Técnico revisando el motor de un vehículo |
| `assets/img/salud-consulta.webp` | Bloque Salud, visual principal con el electrocardiograma | Equipo médico conversando |

---

## Fotos del sitio que **no** se deben reutilizar aquí

Las revisé una por una y estas están descartadas:

| Archivo | Motivo |
|---|---|
| `arl/assets/img/sec-transporte.jpg` | Logos de **Maersk**, Hamburg Süd y Evergreen bien visibles |
| `arl/assets/img/serv-especialistas.jpg` | Cascos y credenciales con marcas **USNRC** y **TVA Nuclear** |
| `arl/assets/img/sec-inmobiliario.jpg` | Torre de oficinas estadounidense, no es una vivienda |
| `arl/assets/img/sec-educacion.jpg` | Aula universitaria estadounidense, calidad baja |

---

## Otras imágenes del sitio

| Ruta | Estado |
|---|---|
| `assets/share/og-personas.jpg` | Lista. Composición de marca 1200×630 para la vista previa del enlace |
| `assets/share/qr-personas.png` | Listo. QR de 990 px hacia `/personas.html` |
| `assets/img/hero.jpg` | En uso por la máscara del "10", CIA Formando Conductores y el panel de Movilidad. **No borrar** |
| `assets/img/hero-tecnico.jpg` | En uso por Baterías del Caribe. **No borrar** |
