# Fotos pendientes

Hoy **el sitio no tiene ninguna foto**. En cada lugar donde va una, hay un
recuadro punteado con el escudo de la marca que reserva el espacio exacto.

Cada recuadro lleva un atributo `data-img` que dice **qué archivo va ahí**.
Por ejemplo, en `/seguros/auto/`:

```html
<div class="ph ph-hero" style="--ph-ratio:16/10" data-img="assets/img/productos/auto-hero.webp" …>
```

## Cómo poner una foto

1. Guarda la imagen con **exactamente** el nombre y la ruta que dice `data-img`.
2. En el HTML, reemplaza todo el bloque `<div class="ph" …>…</div>` por:

```html
<img src="/assets/img/productos/auto-hero.webp" alt="Descripción de la foto"
     width="1600" height="1000" loading="lazy">
```

3. Sube el `?v=` de los archivos CSS y JS (ver `LEEME.md`), y publica.

Si prefieres, mándame las fotos y yo hago el cambio en todas las páginas.

## Formato recomendado

- **WebP**, calidad 80. Pesa la mitad que un JPG y se ve igual.
- Ancho de 1600 px es más que suficiente.
- Respeta la proporción que pide cada hueco (`--ph-ratio`), o la foto se recorta.

---

## Lista completa

### Portada de cada producto — proporción 16/10 (1600×1000)

| Archivo | Página | Qué debería mostrar |
|---|---|---|
| `productos/auto-hero.webp` | /seguros/auto/ | Carro particular en carretera, luz de tarde |
| `productos/moto-hero.webp` | /seguros/moto/ | Motociclista con equipo de protección |
| `productos/bici-hero.webp` | /seguros/bicicleta-patineta/ | Ciclista urbano en la ciudad |
| `productos/taxi-hero.webp` | /seguros/taxi/ | Taxi en la ciudad, jornada de trabajo |
| `productos/soat-hero.webp` | /seguros/soat/ | Tarjeta de propiedad y llaves sobre una mesa |
| `productos/salud-hero.webp` | /seguros/salud/ | Consulta médica tranquila |
| `productos/prepagada-hero.webp` | /seguros/medicina-prepagada/ | Médico y paciente en consultorio |
| `productos/pac-hero.webp` | /seguros/plan-complementario/ | Familia en sala de espera |
| `productos/vida-hero.webp` | /seguros/vida/ | Familia reunida, varias generaciones |
| `productos/deudor-hero.webp` | /seguros/vida-deudor/ | Pareja joven con las llaves de su casa |
| `productos/accidentes-hero.webp` | /seguros/accidentes-personales/ | Persona activa, día cotidiano |
| `productos/exequias-hero.webp` | /seguros/exequias/ | Manos acompañando, ambiente sereno |
| `productos/hogar-hero.webp` | /seguros/hogar/ | Sala de una casa, luz natural |
| `productos/arrendamiento-hero.webp` | /seguros/arrendamiento/ | Llaves y contrato sobre una mesa |
| `productos/mascotas-hero.webp` | /seguros/mascotas/ | Perro o gato con su familia |
| `productos/viaje-hero.webp` | /seguros/viaje/ | Maleta y pasaporte, salida de viaje |
| `productos/vidagrupo-hero.webp` | /seguros/vida-grupo/ | Equipo de trabajo reunido |
| `productos/escuelas-hero.webp` | /seguros/escuelas-deportivas/ | Niños entrenando en una cancha |
| `productos/colectivos-hero.webp` | /seguros/accidentes-colectivos/ | Grupo en una actividad organizada |
| `productos/exequias-col-hero.webp` | /seguros/exequias-colectivas/ | Reunión de un grupo o asociación |
| `productos/dano-hero.webp` | /seguros/dano-material/ | Equipos y bienes de una sede |
| `productos/empresarial-hero.webp` | /seguros/todo-riesgo-empresarial/ | Bodega o planta en operación |
| `productos/rce-hero.webp` | /seguros/responsabilidad-civil/ | Equipo de trabajo en obra o servicio |
| `productos/transporte-hero.webp` | /seguros/transporte-mercancias/ | Camión de carga en ruta |
| `productos/flotas-hero.webp` | /seguros/flotas-camiones/ | Parque automotor de una empresa |
| `productos/energia-hero.webp` | /seguros/energia-solar/ | Paneles solares en cubierta |
| `productos/cultivos-hero.webp` | /seguros/cultivos-agro/ | Cultivo extenso, jornada de campo |

### Segunda foto, solo en los productos principales — proporción 4/3 (1600×1200)

| Archivo | Página | Qué debería mostrar |
|---|---|---|
| `productos/auto-detalle.webp` | /seguros/auto/ | Conductor revisando su carro con tranquilidad |
| `productos/moto-detalle.webp` | /seguros/moto/ | Moto parqueada, detalle de casco |
| `productos/bici-detalle.webp` | /seguros/bicicleta-patineta/ | Patineta eléctrica y casco |
| `productos/salud-detalle.webp` | /seguros/salud/ | Sala de espera de clínica moderna |
| `productos/vida-detalle.webp` | /seguros/vida/ | Padres e hijos en casa |
| `productos/hogar-detalle.webp` | /seguros/hogar/ | Detalle doméstico cotidiano |
| `productos/empresarial-detalle.webp` | /seguros/todo-riesgo-empresarial/ | Detalle de maquinaria o inventario |

### Equipo, en el inicio — proporción 3/4 vertical (1200×1600)

| Archivo | Qué debería mostrar |
|---|---|
| `equipo/gerencia.webp` | Foto del equipo de gerencia |
| `equipo/operaciones.webp` | Foto del equipo de operaciones |
| `equipo/comercial.webp` | Foto del equipo comercial |

> En el teléfono estas tres se muestran apaisadas (16/10) para no alargar la
> página, así que conviene que la persona quede centrada en el encuadre.

---

## Qué NO hace falta

- **Logos de aseguradoras** (`assets/logos/`): ya están, salvo los siete que
  faltan y que hoy salen en texto. Ver `LEEME.md`.
- **Isotipo de Willisch**: ya está en alta calidad.
