# =========================================================
#  SEGUROS WILLISCH — GENERADOR DE SUBPÁGINAS DE PRODUCTO
#
#  Uso (desde la raíz del proyecto, en Git Bash):
#      perl _generador/generar.pl
#
#  Qué hace:
#   1. Crea /seguros/<slug>/index.html para cada producto del catálogo.
#   2. Reescribe el menú (escritorio y móvil) y las columnas del pie
#      dentro de index.html, entre los marcadores <!--MENU:*-->.
#
#  El catálogo vive en _generador/productos.pl. Edita ahí los textos.
#  Las carpetas que empiezan por _ no se publican en GitHub Pages.
# =========================================================
use strict;
use warnings;
use utf8;

my $RAIZ = ".";
require "./_generador/productos.pl";
our (@CATEGORIAS, @PRODUCTOS, @EXTERNOS);

my $VER = "2026092901";

# Índice por slug, para los "relacionados".
my %POR_SLUG = map { $_->{slug} => $_ } @PRODUCTOS;
my %NOMBRE_CAT = map { $_->{id} => $_->{nombre} } @CATEGORIAS;

# ----------------------------------------------------------------- utilidades
sub esc {
  my $t = shift; $t = "" unless defined $t;
  $t =~ s/&/&amp;/g; $t =~ s/</&lt;/g; $t =~ s/>/&gt;/g; $t =~ s/"/&quot;/g;
  return $t;
}
sub json_esc {
  my $t = shift; $t = "" unless defined $t;
  $t =~ s/\\/\\\\/g; $t =~ s/"/\\"/g; $t =~ s/\n/ /g;
  return $t;
}

# Hueco para una foto que todavía no existe. No usa ninguna imagen del sitio:
# deja el espacio reservado con la proporción final para que al llegar la foto
# solo haya que cambiar el bloque por un <img>.
sub hueco {
  my ($id, $ratio, $desc, $clase) = @_;
  $clase = $clase ? " $clase" : "";
  return
    qq{<div class="ph$clase" style="--ph-ratio:$ratio" data-img="assets/img/productos/$id.webp" role="img" aria-label="}.esc($desc).qq{">\n}.
    qq{        <svg class="ph-mark" viewBox="0 0 64 64" aria-hidden="true"><path d="M32 8l22 8.5v18.6c0 13.6-9.3 23.4-22 26.9-12.7-3.5-22-13.3-22-26.9V16.5L32 8z" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linejoin="round"/><path d="M23 33l6.5 6.5L42 26" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"/></svg>\n}.
    qq{        <span class="ph-txt">}.esc($desc).qq{</span>\n}.
    qq{      </div>};
}

# ------------------------------------------------------------------ menús
# Se generan una sola vez y se usan igual en el inicio y en cada producto,
# para que la navegación sea idéntica en todo el sitio.
sub menu_escritorio {
  my $html = "";
  for my $c (@CATEGORIAS) {
    my @items = grep { $_->{cat} eq $c->{id} } @PRODUCTOS;
    my @ext   = grep { $_->{cat} eq $c->{id} } @EXTERNOS;
    next unless @items || @ext;
    $html .= qq{        <li data-mega>\n};
    $html .= qq{          <button type="button" aria-expanded="false">}.esc($c->{nombre}).qq{\n};
    $html .= qq{            <svg class="caret" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 9l6 6 6-6" stroke-linecap="round" stroke-linejoin="round"/></svg>\n};
    $html .= qq{          </button>\n};
    $html .= qq{          <div class="mega mega-lista">\n};
    $html .= qq{            <div class="mega-col">\n};
    for my $p (@items) {
      my $tag = $p->{digital} ? qq{ <span class="mega-tag">100% digital</span>} : "";
      $html .= qq{              <a href="/seguros/$p->{slug}/">}.esc($p->{menu}).qq{$tag</a>\n};
    }
    for my $e (@ext) {
      $html .= qq{              <a href="/$e->{url}">}.esc($e->{menu}).qq{</a>\n};
    }
    $html .= qq{            </div>\n          </div>\n        </li>\n};
  }
  return $html;
}

sub menu_movil {
  my $html = "";
  for my $c (@CATEGORIAS) {
    my @items = grep { $_->{cat} eq $c->{id} } @PRODUCTOS;
    my @ext   = grep { $_->{cat} eq $c->{id} } @EXTERNOS;
    next unless @items || @ext;
    $html .= qq{  <details class="m-grupo">\n};
    $html .= qq{    <summary>}.esc($c->{nombre}).qq{</summary>\n};
    for my $p (@items) {
      $html .= qq{    <a class="m-link" href="/seguros/$p->{slug}/">}.esc($p->{menu}).qq{</a>\n};
    }
    for my $e (@ext) {
      $html .= qq{    <a class="m-link" href="/$e->{url}">}.esc($e->{menu}).qq{</a>\n};
    }
    $html .= qq{  </details>\n};
  }
  return $html;
}

# Pestañas y tarjetas del portafolio del inicio.
# Las claves de búsqueda salen del nombre del producto más las que se
# declaren en "claves" dentro del catálogo.
sub portafolio {
  my $tabs = qq{    <div class="port-tabs" role="tablist" aria-label="Categorías del portafolio">\n};
  $tabs .= qq{      <span class="port-pill" data-pill aria-hidden="true"></span>\n};
  my $primera = 1;
  for my $c (@CATEGORIAS) {
    my $sel = $primera ? "true" : "false";
    $tabs .= qq{      <button class="port-tab" type="button" role="tab" data-tab="$c->{id}" aria-selected="$sel">}.esc($c->{nombre}).qq{</button>\n};
    $primera = 0;
  }
  $tabs .= qq{    </div>\n};

  my $cards = qq{    <div class="port-grid">\n};
  for my $p (@PRODUCTOS) {
    my $claves = lc($p->{menu}." ".$p->{nombre}." ".($p->{claves}||""));
    $claves =~ s/[^a-z0-9áéíóúñü ]/ /g;
    $claves =~ s/\s+/ /g; $claves =~ s/^ | $//g;
    my $tag = $p->{digital} ? qq{<span class="port-tag">100% digital</span>} : "";
    $cards .= qq{      <a class="port-card reveal" data-cat="$p->{cat}" data-keys="}.esc($claves).qq{" href="/seguros/$p->{slug}/">\n};
    $cards .= qq{        <span class="port-cat">}.esc($NOMBRE_CAT{$p->{cat}}).qq{</span>\n};
    $cards .= qq{        <h3>}.esc($p->{menu}).qq{</h3>\n};
    $cards .= qq{        <p>}.esc($p->{h1}).qq{</p>\n};
    $cards .= qq{        <span class="port-go">Ver el seguro →</span>$tag\n};
    $cards .= qq{      </a>\n};
  }
  for my $e (@EXTERNOS) {
    my $claves = lc($e->{menu}); $claves =~ s/[^a-z0-9áéíóúñü ]/ /g; $claves =~ s/\s+/ /g;
    $cards .= qq{      <a class="port-card reveal" data-cat="$e->{cat}" data-keys="}.esc($claves).qq{" href="/$e->{url}">\n};
    $cards .= qq{        <span class="port-cat">}.esc($NOMBRE_CAT{$e->{cat}}).qq{</span>\n};
    $cards .= qq{        <h3>}.esc($e->{menu}).qq{</h3>\n};
    $cards .= qq{        <p>Tiene su propia página, con el detalle completo del producto.</p>\n};
    $cards .= qq{        <span class="port-go">Ver el seguro →</span>\n};
    $cards .= qq{      </a>\n};
  }
  $cards .= qq{    </div>\n};

  return $tabs . "\n" . $cards;
}

sub columnas_pie {
  my $html = "";
  for my $c (@CATEGORIAS) {
    my @items = grep { $_->{cat} eq $c->{id} } @PRODUCTOS;
    my @ext   = grep { $_->{cat} eq $c->{id} } @EXTERNOS;
    next unless @items || @ext;
    $html .= qq{      <div class="f-col">\n        <h4>}.esc($c->{nombre}).qq{</h4>\n};
    for my $p (@items) {
      $html .= qq{        <a href="/seguros/$p->{slug}/">}.esc($p->{menu}).qq{</a>\n};
    }
    for my $e (@ext) {
      $html .= qq{        <a href="/$e->{url}">}.esc($e->{menu}).qq{</a>\n};
    }
    $html .= qq{      </div>\n\n};
  }
  return $html;
}

# --------------------------------------------------------- cabecera compartida
sub cabecera {
  my ($mega, $mmenu) = @_;
  return <<"HTML";
<!-- ============ CABECERA ============ -->
<header class="site-header" data-header>
  <div class="container">
    <a class="logo" href="/" aria-label="Seguros Willisch, inicio">
      <img src="/assets/logos/logo-willisch-monograma.png" alt="" onerror="this.style.display='none'">
      <span class="logo-txt"><b>Seguros Willisch</b></span>
    </a>

    <nav aria-label="Principal">
      <ul class="nav">
$mega      </ul>
    </nav>

    <div class="header-actions">
      <button class="theme-btn" data-theme-btn type="button" aria-label="Cambiar entre modo claro y oscuro">
        <svg class="sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="4.2"/><path d="M12 2v2.6M12 19.4V22M4.2 4.2l1.9 1.9M17.9 17.9l1.9 1.9M2 12h2.6M19.4 12H22M4.2 19.8l1.9-1.9M17.9 6.1l1.9-1.9" stroke-linecap="round"/></svg>
        <svg class="moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M20 14.5A8.5 8.5 0 0 1 9.5 4a8.5 8.5 0 1 0 10.5 10.5z" stroke-linejoin="round"/></svg>
      </button>
      <a class="btn btn-wa btn-sm header-cta" data-wa="Hola Seguros Willisch, quiero cotizar un seguro.">
        <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
        Cotiza por WhatsApp
      </a>
      <button class="burger" data-burger type="button" aria-label="Abrir menú" aria-expanded="false">
        <span></span><span></span><span></span>
      </button>
    </div>
  </div>
</header>

<div class="m-menu" data-mmenu>
$mmenu  <a class="m-link" href="/#nosotros">Nosotros y contacto</a>
  <a class="btn btn-wa btn-block" data-wa="Hola Seguros Willisch, quiero cotizar un seguro.">
    <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
    Cotiza por WhatsApp
  </a>
  <p class="m-menu-foot">Atendemos en toda Colombia<br><span data-cfg="HORARIO"></span></p>
</div>
HTML
}

# --------------------------------------------------------------- pie compartido
sub pie {
  my ($cols) = @_;
  return <<"HTML";
<!-- ============ PIE ============ -->
<footer class="site-footer">
  <div class="container">
    <div class="f-sos">
      <div>
        <b>¿Tuviste un siniestro? Escríbenos de inmediato</b>
        <p>Te decimos qué hacer en el sitio y radicamos contigo la reclamación.</p>
      </div>
      <a class="btn btn-warm" data-wa="Hola Seguros Willisch, tuve un siniestro y necesito ayuda urgente.">Reportar un siniestro</a>
    </div>

    <div class="f-grid f-grid-ancha">
      <div class="f-brand">
        <span class="logo">
          <img src="/assets/logos/logo-willisch-monograma.png" alt="" onerror="this.style.display='none'">
          <span class="logo-txt"><b>Seguros Willisch</b><span>Comparamos por ti</span></span>
        </span>
        <p>Comparamos por ti. Te acompañamos siempre. Agencia de seguros con más de 7 años asegurando personas y empresas en toda Colombia.</p>
        <div class="f-social" data-redes></div>
      </div>

$cols      <div class="f-col f-contact">
        <h4>Contacto</h4>
        <a data-wa="Hola Seguros Willisch, quiero cotizar un seguro.">
          <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
          <span>WhatsApp: +57 300 7525773</span>
        </a>
        <a data-mail href="mailto:Mercadeo\@seguroswillisch.com">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg>
          <span data-cfg="EMAIL">Mercadeo\@seguroswillisch.com</span>
        </a>
        <a data-cfg-href="MAPS_URL" target="_blank" rel="noopener">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><path d="M12 21s-7-4.9-7-11a7 7 0 0 1 14 0c0 6.1-7 11-7 11z"/><circle cx="12" cy="10" r="2.5"/></svg>
          <span data-cfg="DIRECCION"></span>
        </a>
        <span>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3.4 2" stroke-linecap="round"/></svg>
          <span data-cfg="HORARIO"></span>
        </span>
      </div>
    </div>

    <div class="f-legal">
      <p><b>Seguros Willisch</b> actúa como intermediario de seguros. Las coberturas, condiciones, exclusiones y precios dependen de cada aseguradora y de las condiciones particulares de cada póliza. Damos cumplimiento a las disposiciones vigentes en materia de SARLAFT y de protección de datos personales (Ley 1581 de 2012).</p>
      <div class="f-legal-links">
        <a href="/politica-datos.html">Política de tratamiento de datos</a>
        <span>·</span>
        <span>© <span data-year>2026</span> Seguros Willisch. Todos los derechos reservados.</span>
      </div>
    </div>
  </div>
</footer>

<!-- ============ FLOTANTES ============ -->
<div class="wa-float" data-wa-float>
  <span class="wa-msg"></span>
  <a class="wa-btn" href="https://wa.me/573007525773" data-wa="Hola Seguros Willisch, quiero cotizar un seguro." aria-label="Escribir por WhatsApp" style="position:relative">
    <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
  </a>
</div>

<button class="to-top" data-totop type="button" aria-label="Volver arriba" style="position:fixed">
  <svg class="ring" viewBox="0 0 48 48" aria-hidden="true"><circle cx="24" cy="24" r="22"/></svg>
  <svg class="arrow" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M12 19V5M5 12l7-7 7 7" stroke-linecap="round" stroke-linejoin="round"/></svg>
</button>

<script src="/assets/js/config.js?v=$VER" defer></script>
<script src="/assets/js/site.js?v=$VER" defer></script>
HTML
}

# ----------------------------------------------------------- página de producto
sub pagina {
  my ($p, $mega, $mmenu, $cols) = @_;
  my $url  = "https://seguroswillisch.com/seguros/$p->{slug}/";
  my $cat  = $NOMBRE_CAT{$p->{cat}} || "";
  my $head = cabecera($mega, $mmenu);
  my $foot = pie($cols);

  # --- JSON-LD: el servicio y sus preguntas frecuentes
  my @faqjson = map {
    '{"@type":"Question","name":"'.json_esc($_->[0]).'","acceptedAnswer":{"@type":"Answer","text":"'.json_esc($_->[1]).'"}}'
  } @{$p->{faq}};
  my $ld = qq({\n  "\@context":"https://schema.org",\n  "\@graph":[\n) .
    qq(    {"\@type":"Service","serviceType":") . json_esc($p->{nombre}) . qq(",\n) .
    qq(     "provider":{"\@type":"InsuranceAgency","name":"Seguros Willisch","url":"https://seguroswillisch.com/"},\n) .
    qq(     "areaServed":{"\@type":"Country","name":"Colombia"},\n) .
    qq(     "url":"$url",\n) .
    qq(     "description":") . json_esc($p->{meta}) . qq("},\n) .
    qq(    {"\@type":"BreadcrumbList","itemListElement":[\n) .
    qq(      {"\@type":"ListItem","position":1,"name":"Inicio","item":"https://seguroswillisch.com/"},\n) .
    qq(      {"\@type":"ListItem","position":2,"name":") . json_esc($cat) . qq(","item":"https://seguroswillisch.com/#portafolio"},\n) .
    qq(      {"\@type":"ListItem","position":3,"name":") . json_esc($p->{menu}) . qq(","item":"$url"}\n) .
    qq(    ]},\n) .
    qq(    {"\@type":"FAQPage","mainEntity":[\n      ) . join(",\n      ", @faqjson) . qq(\n    ]}\n  ]\n});

  # --- Coberturas
  my $coberturas = "";
  my $i = 0;
  for my $c (@{$p->{coberturas}}) {
    $i++;
    $coberturas .= qq{      <article class="cob-card reveal">\n};
    $coberturas .= qq{        <span class="cob-num">0$i</span>\n};
    $coberturas .= qq{        <h3>}.esc($c->[0]).qq{</h3>\n};
    $coberturas .= qq{        <p>}.esc($c->[1]).qq{</p>\n};
    $coberturas .= qq{      </article>\n};
  }

  # --- Lo que hacemos por ti
  my $incluye = "";
  for my $t (@{$p->{incluye}}) {
    $incluye .= qq{        <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.6" aria-hidden="true"><path d="M4 12l5 5L20 6" stroke-linecap="round" stroke-linejoin="round"/></svg>}.esc($t).qq{</li>\n};
  }

  # --- FAQ
  my $faq = "";
  for my $f (@{$p->{faq}}) {
    $faq .= qq{      <div class="faq-item reveal" data-faq>\n};
    $faq .= qq{        <button class="faq-q" type="button" aria-expanded="false">}.esc($f->[0]).qq{\n};
    $faq .= qq{          <span class="faq-ic"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" aria-hidden="true"><path d="M12 5v14M5 12h14" stroke-linecap="round"/></svg></span>\n};
    $faq .= qq{        </button>\n};
    $faq .= qq{        <div class="faq-a"><div class="faq-a-inner">}.esc($f->[1]).qq{</div></div>\n};
    $faq .= qq{      </div>\n\n};
  }

  # --- Relacionados
  my $rel = "";
  for my $s (@{$p->{relacionados}}) {
    my $r = $POR_SLUG{$s} or next;
    $rel .= qq{      <a class="rel-card reveal" href="/seguros/$r->{slug}/">\n};
    $rel .= qq{        <span class="rel-cat">}.esc($NOMBRE_CAT{$r->{cat}}).qq{</span>\n};
    $rel .= qq{        <h3>}.esc($r->{menu}).qq{</h3>\n};
    $rel .= qq{        <span class="rel-go">Ver el seguro →</span>\n};
    $rel .= qq{      </a>\n};
  }

  # --- Botón de cotizador en línea, solo para los productos 100% digitales
  my $btn_digital = "";
  my $nota_digital = "";
  if ($p->{digital}) {
    $btn_digital = qq{\n        <a class="btn btn-primary" data-cotizador-externo="$p->{digital}">Cotizar en línea</a>};
    $nota_digital = qq{\n        <p class="prod-nota"><b>100% digital.</b> Este seguro lo cotizas y lo compras tú mismo en el portal de la aseguradora, con nuestro código de asesor. Si prefieres que te acompañemos, escríbenos.</p>};
  }

  # --- Huecos de foto
  my @im = @{ $p->{imgs} || [] };
  my $hero_img = @im ? hueco($im[0][0], $im[0][1], $im[0][2], "ph-hero") : "";
  my $img2     = @im > 1 ? hueco($im[1][0], $im[1][1], $im[1][2]) : "";
  my $bloque_img2 = $img2 ? qq{\n      <div class="inc-foto reveal">$img2</div>} : "";

  return <<"HTML";
<!doctype html>
<html lang="es" class="no-js">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>@{[ esc($p->{titulo}) ]}</title>
<meta name="description" content="@{[ esc($p->{meta}) ]}">
<meta name="theme-color" content="#0B1F33">
<link rel="canonical" href="$url">

<meta property="og:type" content="website">
<meta property="og:locale" content="es_CO">
<meta property="og:site_name" content="Seguros Willisch">
<meta property="og:title" content="@{[ esc($p->{nombre}) ]} | Seguros Willisch">
<meta property="og:description" content="@{[ esc($p->{meta}) ]}">
<meta property="og:url" content="$url">

<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 64 64'%3E%3Crect width='64' height='64' rx='14' fill='%230B1F33'/%3E%3Cpath d='M32 12l18 7v15c0 11-7.6 19-18 22-10.4-3-18-11-18-22V19l18-7z' fill='none' stroke='%23FF8A3D' stroke-width='3.4' stroke-linejoin='round'/%3E%3Cpath d='M24 33l6 6 11-12' fill='none' stroke='%23fff' stroke-width='3.4' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght\@500;600;700;800&family=Inter:wght\@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/css/site.css?v=$VER">
<link rel="stylesheet" href="/assets/css/producto.css?v=$VER">

<script type="application/ld+json">
$ld
</script>

<script>document.documentElement.classList.remove("no-js");</script>
</head>
<body class="no-js pagina-producto">

$head
<main>

<!-- ============ PORTADA ============ -->
<section class="prod-hero" id="inicio"
         data-wa-context="¿Cotizamos este seguro?" data-wa-msg="@{[ esc($p->{wa}) ]}">
  <div class="container">
    <nav class="miga" aria-label="Ruta">
      <a href="/">Inicio</a> <span aria-hidden="true">›</span>
      <a href="/#portafolio">@{[ esc($cat) ]}</a> <span aria-hidden="true">›</span>
      <b>@{[ esc($p->{menu}) ]}</b>
    </nav>

    <div class="prod-hero-grid">
      <div class="prod-hero-txt">
        <span class="kicker">@{[ esc($p->{kicker}) ]}</span>
        <h1 class="h-lg">@{[ esc($p->{h1}) ]}</h1>
        <p class="lead">@{[ esc($p->{lead}) ]}</p>
        <div class="prod-cta">
          <a class="btn btn-wa" data-wa="@{[ esc($p->{wa}) ]}">
            <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
            Cotizar por WhatsApp
          </a>$btn_digital
        </div>$nota_digital
      </div>

      <div class="prod-hero-img">
        $hero_img
      </div>
    </div>
  </div>
</section>

<!-- ============ QUÉ CUBRE ============ -->
<section class="pad" id="cubre" style="background:var(--bg-alt);border-block:1px solid var(--border)">
  <div class="container">
    <div class="head reveal">
      <span class="kicker">Qué cubre</span>
      <h2 class="h-md">Las coberturas que importan</h2>
      <p class="lead">Lo que ves aquí es lo habitual del mercado. El alcance exacto depende de la aseguradora y del plan que elijas, y te lo detallamos antes de firmar.</p>
    </div>
    <div class="cob-grid">
$coberturas    </div>
  </div>
</section>

<!-- ============ QUÉ HACEMOS POR TI ============ -->
<section class="pad" id="incluye">
  <div class="container">
    <div class="inc-grid">
      <div>
        <div class="head reveal">
          <span class="kicker">Con Willisch</span>
          <h2 class="h-md">Qué hacemos por ti</h2>
        </div>
        <ul class="inc-lista reveal">
$incluye        </ul>
        <a class="btn btn-wa reveal" style="margin-top:28px" data-wa="@{[ esc($p->{wa}) ]}">
          <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
          Hablar con un asesor
        </a>
      </div>$bloque_img2
    </div>
  </div>
</section>

<!-- ============ PREGUNTAS FRECUENTES ============ -->
<section class="pad" id="faq" style="background:var(--bg-alt);border-block:1px solid var(--border)">
  <div class="container container-angosto">
    <div class="head center reveal">
      <span class="kicker">Preguntas frecuentes</span>
      <h2 class="h-md">Lo que más nos preguntan</h2>
    </div>
    <div class="faq">
$faq    </div>
  </div>
</section>

<!-- ============ RELACIONADOS ============ -->
<section class="pad" id="relacionados">
  <div class="container">
    <div class="head reveal">
      <span class="kicker">También te puede servir</span>
      <h2 class="h-md">Otros seguros que solemos combinar con este</h2>
    </div>
    <div class="rel-grid">
$rel    </div>
    <p class="rel-todos reveal"><a href="/#portafolio">Ver todo el portafolio →</a></p>
  </div>
</section>

<!-- ============ CIERRE ============ -->
<section class="cierre pad" id="contacto">
  <div class="container container-angosto center">
    <h2 class="h-md">¿Hablamos de tu caso?</h2>
    <p class="lead">Escríbenos por WhatsApp y te respondemos con opciones concretas, comparadas y explicadas. Sin compromiso.</p>
    <div class="prod-cta center-cta">
      <a class="btn btn-wa" data-wa="@{[ esc($p->{wa}) ]}">
        <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
        Cotizar por WhatsApp
      </a>
      <a class="btn btn-ghost" href="/#nosotros">Conocer al equipo</a>
    </div>
  </div>
</section>

</main>

$foot
</body>
</html>
HTML
}

# ------------------------------------------------------------------- ejecución
binmode(STDOUT, ":encoding(UTF-8)");

my $mega  = menu_escritorio();
my $mmenu = menu_movil();
my $cols  = columnas_pie();
my $porta = portafolio();

my $n = 0;
for my $p (@PRODUCTOS) {
  my $dir = "$RAIZ/seguros/$p->{slug}";
  mkdir "$RAIZ/seguros" unless -d "$RAIZ/seguros";
  mkdir $dir unless -d $dir;
  open(my $fh, ">:encoding(UTF-8)", "$dir/index.html") or die "No pude escribir $dir: $!";
  print $fh pagina($p, $mega, $mmenu, $cols);
  close $fh;
  $n++;
  print "  + /seguros/$p->{slug}/\n";
}

# --- Sincroniza el menú y el pie del inicio con el catálogo
if (-f "$RAIZ/index.html") {
  open(my $in, "<:encoding(UTF-8)", "$RAIZ/index.html") or die $!;
  local $/; my $html = <$in>; close $in;
  my $antes = $html;
  $html =~ s{(<!--MENU:ESCRITORIO-->).*?(<!--MENU:FIN-->)}{$1\n$mega      $2}s;
  $html =~ s{(<!--MENU:MOVIL-->).*?(<!--MENU:MOVIL-FIN-->)}{$1\n$mmenu  $2}s;
  $html =~ s{(<!--MENU:PIE-->).*?(<!--MENU:PIE-FIN-->)}{$1\n$cols      $2}s;
  $html =~ s{(<!--MENU:PORTAFOLIO-->).*?(<!--MENU:PORTAFOLIO-FIN-->)}{$1\n$porta    $2}s;
  if ($html !~ /<!--MENU:ESCRITORIO-->/) {
    print "  ! index.html: faltan los marcadores <!--MENU:*-->, no toqué nada\n";
  } elsif ($html ne $antes) {
    open(my $out, ">:encoding(UTF-8)", "$RAIZ/index.html") or die $!;
    print $out $html; close $out;
    print "  ~ index.html: menú, portafolio y pie sincronizados\n";
  } else {
    print "  = index.html: ya estaba al día\n";
  }
}

# --- Sitemap: el inicio, todos los productos y las dos páginas propias.
#     Las páginas de aliados se quedan fuera a propósito.
{
  open(my $sm, ">:encoding(UTF-8)", "$RAIZ/sitemap.xml") or die $!;
  print $sm qq{<?xml version="1.0" encoding="UTF-8"?>\n};
  print $sm qq{<!-- Lo genera _generador/generar.pl. Las páginas de aliados\n};
  print $sm qq{     (baterias-del-caribe, time2cars, ciaformandoconductores) quedan fuera\n};
  print $sm qq{     a propósito: son exclusivas, se comparten por enlace directo y llevan noindex. -->\n};
  print $sm qq{<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n};
  my $u = sub {
    my ($loc, $freq, $pri) = @_;
    print $sm qq{  <url>\n    <loc>https://seguroswillisch.com$loc</loc>\n};
    print $sm qq{    <changefreq>$freq</changefreq>\n    <priority>$pri</priority>\n  </url>\n};
  };
  $u->("/", "monthly", "1.0");
  $u->("/seguros/$_->{slug}/", "monthly", "0.8") for @PRODUCTOS;
  $u->("/arl/", "monthly", "0.8");
  $u->("/cumplimiento/", "monthly", "0.8");
  $u->("/politica-datos.html", "yearly", "0.2");
  print $sm qq{</urlset>\n};
  close $sm;
  print "  ~ sitemap.xml\n";
}

print "\n  $n subpáginas de producto generadas.\n";
