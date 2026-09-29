# Seguros Willisch — guía del sitio

Sitio estático (HTML, CSS y JavaScript, sin programas que instalar). Se publica solo:
al guardar los cambios en GitHub, la página queda en línea en un par de minutos.

---

## 1. Lo que se cambia más seguido

Todo lo que cambia con el tiempo vive en **un solo archivo**: `assets/js/config.js`.
Ábrelo con el Bloc de notas o cualquier editor y edita solo lo que está entre comillas.

| Qué | Dónde |
|---|---|
| Número de WhatsApp | `WHATSAPP_NUMBER` (solo dígitos, con el 57 adelante) |
| Correo | `EMAIL` |
| Dirección | `DIRECCION` |
| Horario | `HORARIO` |
| Redes sociales | lista `REDES` |
| Aseguradoras aliadas | lista `ALIADAS` |

### Agregar o quitar una red social

En la lista `REDES`, agrega una línea:

```js
{ red: "linkedin", url: "https://www.linkedin.com/company/tu-empresa" }
```

Redes admitidas: `instagram`, `facebook`, `linkedin`, `tiktok`, `youtube`.
Si una red no está en la lista, su ícono simplemente no aparece. No quedan enlaces rotos.

### Agregar una aseguradora aliada

En la lista `ALIADAS`:

```js
{ nombre: "Nombre visible", archivo: "nombre-archivo.png", alt: "Nombre de la marca" }
```

El archivo va en `assets/logos/`. Si todavía no tienes el logo oficial, pon
`archivo: null` y el sitio mostrará el nombre en texto con la tipografía de la marca.

**Faltan estos logos oficiales** (hoy salen en texto): AXA Colpatria, La Equidad
Seguros y Universal de Fianzas.

### Muy importante al publicar cambios

Si editas `assets/css/site.css` o cualquier archivo de `assets/js/`, **cambia también
el número de versión** que aparece al final de los enlaces en los archivos `.html`:

```html
<link rel="stylesheet" href="assets/css/site.css?v=2026091803">
```

Sube ese número (por ejemplo a `2026091804`). Sin eso, quien ya visitó la página
seguirá viendo la versión vieja guardada en su navegador.

---

## 2. El catálogo de seguros

El sitio tiene **una página por producto**, en `/seguros/<producto>/`. Por ejemplo:

```
seguroswillisch.com/seguros/auto/
seguroswillisch.com/seguros/moto/
seguroswillisch.com/seguros/salud/
```

Esas páginas **no se escriben a mano**: las genera un pequeño programa a partir de
un archivo de texto con todo el catálogo. Así el menú, el pie, el buscador del
inicio y las 28 páginas siempre dicen lo mismo.

### Dónde está el catálogo

`_generador/productos.pl`. Es un archivo de texto: cada producto es un bloque con
su título, su descripción, sus coberturas y sus preguntas frecuentes. Las carpetas
que empiezan por `_` no se publican, así que ese archivo nunca se ve en el sitio.

### Cambiar el texto de un producto

Tienes dos caminos:

**A. Un cambio pequeño en una sola página.** Abre directamente
`seguros/<producto>/index.html` y edítalo: es HTML normal. Ojo: si después alguien
corre el generador, ese cambio se pierde.

**B. Un cambio que deba quedar.** Edita `_generador/productos.pl` y vuelve a
generar. Para eso, en Git Bash y desde la carpeta del proyecto:

```bash
perl _generador/generar.pl
```

Eso reescribe las 28 páginas, el menú y el pie del inicio, y el `sitemap.xml`.

### Agregar un producto nuevo

1. Copia un bloque completo de `@PRODUCTOS`, en `_generador/productos.pl`, y pégalo
   dentro de la lista con su propio `slug` (el nombre que irá en la URL).
2. Añádelo al menú: en `@MENU`, escribe su `slug` dentro del subgrupo donde quieras
   que salga. Puede ir en varios a la vez.
3. Corre el generador.

### El menú de arriba

Tiene tres grupos —**Personas**, **Empresas** y **Colectivos**— y de cada uno cuelgan
sus subgrupos. Todo eso se define en `@MENU`, dentro de `_generador/productos.pl`:

```perl
{ nombre => "Movilidad",
  items => [qw(auto moto bicicleta-patineta taxi utilitarios-pesados soat)] },
```

Para mover un seguro de sitio, cambia su `slug` de lista. Para enlazar una página
que no sale del catálogo (ARL, cumplimiento) usa `ext:arl` o `ext:cumplimiento`.

### Los tres seguros 100% digitales

`viaje`, `arrendamiento` y `mascotas` llevan `digital => "..."` en el catálogo. Eso
les pone la etiqueta **100% digital** y un botón «Cotizar en línea» que lleva al
portal de la aseguradora con nuestro código de asesor. Las URL de esos portales están en `COTIZADORES_EXTERNOS`, dentro de
`assets/js/config.js`. **No cambies los parámetros de esas URL**: se pierde la
trazabilidad de la venta.

El de **viaje todavía no tiene portal**: su entrada está vacía y, mientras lo esté,
el botón «Cotizar ahora» lleva a WhatsApp en vez de quedarse muerto. Cuando tengas
el enlace con tu código de asesor, pégalo ahí y el botón cambia solo.

---

## 3. Las tres secciones del inicio

El inicio es corto a propósito. Tiene exactamente tres secciones:

1. **Portada** — el titular, el isotipo flotante, las cifras y las aseguradoras aliadas.
2. **Seguros 100% digitales** — los tres que el cliente compra solo: mascotas,
   arrendamiento y viaje. El resto del catálogo está en el menú de arriba.
3. **Nosotros** — por qué con Willisch, el equipo y el contacto.

El detalle de cada seguro vive en su propia página. Si quieres añadir contenido,
va en la página del producto, no en el inicio.

Todo el sitio comparte el mismo fondo: un degradado suave y fijo detrás de las
páginas, con las franjas y las tarjetas translúcidas para que se vea a través.
Está en el bloque 0 de `assets/css/producto.css`.

---

## 4. Estructura de archivos

```
index.html                  Página principal (tres secciones)
seguros/<producto>/         Una carpeta por seguro, 28 en total (generadas)
politica-datos.html         Política de tratamiento de datos
personas.html               Redirección al portafolio (la página vieja)
empresas.html               Redirección al portafolio (la página vieja)
colectivos.html             Redirección al portafolio (la página vieja)
arl/  cumplimiento/         Presentaciones comerciales, con su propio diseño
ciaformandoconductores/     Página de aliado (exclusiva, con noindex)
baterias-del-caribe/        Página de aliado (exclusiva, con noindex)
time2cars/                  Página de aliado (exclusiva, con noindex)
_generador/                 El catálogo y el generador. No se publica.
assets/css/site.css         El sistema de diseño de todo el sitio
assets/css/producto.css     Las páginas de producto y las tres secciones del inicio
assets/js/config.js         Los datos que cambian (teléfono, correo, redes, aliadas)
assets/js/site.js           El comportamiento de todo el sitio
assets/logos/               Logos de Willisch y de las aseguradoras
assets/logos/aliados/       Logos de las empresas aliadas
assets/img/                 Fotografías (hoy casi vacía: ver PENDIENTES-IMAGENES.md)
assets/share/               Imágenes de vista previa y códigos QR
sitemap.xml  robots.txt     Para los buscadores (el sitemap lo genera el programa)
```

---
## 5. Páginas de aliados: cómo hacer la del próximo

Hoy hay dos páginas de alianza construidas con la misma plantilla:

- `baterias-del-caribe/index.html` — la primera
- `time2cars/index.html` — la segunda, y la más completa

Las dos son **una sola carpeta con un `index.html` que se basta solo**: el CSS y el
JavaScript van dentro del archivo, y lo único que toman de afuera son las imágenes,
los logos y `assets/js/config.js` (de donde sale el WhatsApp de Willisch). Así una
página de aliado nunca puede romper el resto del sitio, y al revés.

### Los siete pasos

1. **Copia la carpeta** `time2cars/` y ponle el nombre del nuevo aliado, en
   minúsculas y con guiones: por ejemplo `taller-del-norte/`. Esa carpeta es la URL:
   `seguroswillisch.com/taller-del-norte/`.
2. **Cambia los datos del aliado** en el `index.html`: nombre, servicios, teléfono,
   correo, dirección, Instagram y horario. Están todos en el HTML, sin esconder.
3. **Cambia el color de acento.** Al principio del `<style>` hay un bloque
   `:root` con `--t2c-red`. Cámbialo por el color del nuevo aliado. Vive solo en
   esa página y no toca las variables del sitio.
4. **Los dos números nunca se mezclan.** En el JavaScript, arriba del todo, están
   `TEL_T2C` (el del aliado) y la función `telWillisch()`. Todo lo del taller va al
   primero y todo lo de seguros al segundo. Cada botón lleva debajo un rótulo que
   dice a cuál escribe: no lo quites.
5. **El logo del aliado** va en `assets/logos/aliados/`. Mientras no llegue, la
   página muestra sola una marca de relleno tipográfica; no hay que hacer nada.
6. **Las fotos** van en `assets/img/aliados/` con los nombres que ya están escritos
   en el HTML. Mientras no lleguen, cada hueco muestra el patrón de marca de la
   página, con el encuadre correcto. Deja la lista en un archivo
   `PENDIENTES-<ALIADO>.md` dentro de esa carpeta.
7. **No la enlaces** desde el resto del sitio ni la agregues a `sitemap.xml`: las
   páginas de aliados son exclusivas y solo se comparten por enlace directo.

### Lo que no se toca

- **El beneficio.** No se publica un descuento que no esté acordado **por escrito**
  con el aliado. En `time2cars/index.html` el texto del beneficio está en un bloque
  comentado, aislado, para cambiarlo sin tocar nada más.
- **Precios.** Estas páginas circulan por WhatsApp durante meses y los precios
  envejecen mal. Todo termina en «cotiza por WhatsApp». Si algún día hay que
  publicarlos, se hace con fecha de vigencia visible.
- **El aviso legal del pie**, que dice que los servicios del taller los presta el
  aliado y no Seguros Willisch.
- **Los logos ajenos**: no se deforman, no se recolorean y se usan solo con
  autorización del dueño.

### Enlace compartible

Igual que las páginas de producto, estas entienden `?aliado=`:

```
https://seguroswillisch.com/time2cars/?aliado=Time2Cars
```

Con ese enlace, todos los mensajes de WhatsApp que salgan de esa visita terminan en
*«Vengo de parte de Time2Cars.»*, y arriba del botón de compartir aparece quién
comparte la página.

---

## 6. Pendientes

### Time2Cars — puntos por cerrar con el aliado

Antes de publicar el enlace hay que confirmar con Time2Cars, por escrito:

1. **Autorización** para usar su logo y sus fotos en la página.
2. **Cuál es el beneficio** para clientes de Willisch, y su **vigencia y
   condiciones**. Hoy la página dice que se está cerrando, sin prometer un
   porcentaje.
3. **El horario de atención** del taller.
4. Si la aseguradora **avala o no** a Time2Cars como taller: hoy la página dice
   expresamente que **no** lo promete, y así debe quedarse mientras no haya un
   acuerdo firmado con la aseguradora.

Las fotos pendientes y sus rutas exactas están en
`assets/img/aliados/PENDIENTES-TIME2CARS.md`.

### Del resto del sitio

- **Fotografías propias.** Hoy el sitio no tiene ninguna foto: cada lugar donde va
  una tiene un recuadro que reserva el espacio. La lista completa, con el nombre de
  archivo y la proporción de cada una, está en `assets/img/PENDIENTES-IMAGENES.md`.
- **Logo de Willisch en vectorial (SVG).** Hoy todo sale de imágenes; con el vector
  se ve perfecto a cualquier tamaño y sirve para impresión.
- **Textos del catálogo.** Las coberturas que describe cada página son las
  habituales del mercado colombiano, no las de una póliza concreta. Conviene que
  un asesor los revise producto por producto en `_generador/productos.pl`.
