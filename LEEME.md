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

## 2. Cómo compartir la página con las empresas aliadas

La página `personas.html` está hecha para que las empresas aliadas la compartan con
sus clientes y empleados.

**Enlace normal:**

```
https://seguroswillisch.com/personas.html
```

### Enlace personalizado por aliado

Agrega `?aliado=` seguido del nombre de la empresa:

```
https://seguroswillisch.com/personas.html?aliado=Transportes%20del%20Caribe
```

Qué cambia con ese enlace:

1. En la parte de arriba aparece una línea discreta: *"Te comparte esta página: Transportes del Caribe"*.
2. **Todos los mensajes de WhatsApp** que salgan de esa visita terminan con
   *"Vengo de parte de Transportes del Caribe."*, así sabes de dónde viene cada persona.
3. El nombre se conserva aunque la persona navegue a otras secciones.

Sin el parámetro, la página funciona exactamente igual.

> Los espacios se escriben como `%20`. Si prefieres evitarlo, usa guiones:
> `?aliado=Transportes-del-Caribe`.

### Etiquetas UTM (opcional, para medir después)

Si algún día se activa Google Analytics, estas etiquetas permiten saber qué aliado
trajo más gente. Se pueden combinar con `?aliado=`:

```
https://seguroswillisch.com/personas.html?aliado=Transportes-del-Caribe&utm_source=transportes-caribe&utm_medium=whatsapp&utm_campaign=personas-2026
```

- `utm_source`: quién comparte (el aliado)
- `utm_medium`: por dónde lo comparte (`whatsapp`, `email`, `qr`, `instagram`)
- `utm_campaign`: la campaña (`personas-2026`)

### Código QR

En `assets/share/` hay QR de 990 × 990 px, listos para imprimir o poner en una pantalla:

| Archivo | A dónde lleva |
|---|---|
| `qr-personas.png` | `https://seguroswillisch.com/personas.html` |
| `qr-time2cars.png` | `https://seguroswillisch.com/time2cars/` (para que Time2Cars lo ponga en el taller) |

Si necesitas un QR con el nombre de un aliado, hay que generar uno nuevo con la URL
que lleve `?aliado=`; pídemelo y lo genero.

### Botón de compartir

Al final de la página hay botones para compartir: en celular abre el menú del
sistema (WhatsApp, Instagram, correo…) y en computador copia el enlace. Si la visita
llegó con `?aliado=`, el enlace que se comparte conserva ese dato.

---

## 3. Vista previa al pegar el enlace

Al pegar el enlace en WhatsApp o redes aparece la imagen `assets/share/og-personas.jpg`
(1200 × 630 px) con la marca y los tres seguros.

WhatsApp guarda esa vista previa un tiempo. Si cambias la imagen y quieres ver la nueva
de inmediato, agrega algo al final del enlace, por ejemplo `?v=2`.

---

## 4. Estructura de archivos

```
index.html                  Página principal
personas.html               Seguros para personas (la que se comparte con aliados)
politica-datos.html         Política de tratamiento de datos
arl/  cumplimiento/         Presentaciones comerciales
ciaformandoconductores/     Beneficio aliado
baterias-del-caribe/        Página de aliado
time2cars/                  Página de aliado (pintura y detallado automotriz)
assets/css/                 Estilos (site.css es el sistema; personas.css solo esa página)
assets/js/                  config.js (datos), site.js (todo el sitio), personas.js
assets/logos/               Logos de Willisch y de las aseguradoras
assets/logos/aliados/       Logos de las empresas aliadas
assets/img/                 Fotografías
assets/img/aliados/         Fotografías de las empresas aliadas
assets/share/               Imágenes de vista previa y códigos QR
sitemap.xml  robots.txt     Para los buscadores
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

Igual que `personas.html`, estas páginas entienden `?aliado=`:

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

- **Fotografías propias.** Varias tarjetas usan un patrón de marca (degradado con
  ícono) porque no hay foto disponible. Lo ideal es una sesión con personas
  latinoamericanas, luz natural y sin marcas de terceros visibles.
- **Logo de Willisch en vectorial (SVG).** Hoy todo sale de imágenes; con el vector
  se ve perfecto a cualquier tamaño y sirve para impresión.
- **Datos marcados `[CONFIRMAR]`** en `personas.html`: carro de reemplazo, tiempos de
  emisión, conductor distinto al dueño, traslado de antigüedad en salud y preexistencias.
- **Texto del vida deudor**, marcado para revisión con asesoría legal.
