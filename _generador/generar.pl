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
our (@CATEGORIAS, @PRODUCTOS, @EXTERNOS, @MENU);

my $VER = "2026100102";

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
  # Si la foto ya está en assets/img/productos/, va la foto y no el hueco.
  if (-f "$RAIZ/assets/img/productos/$id.webp") {
    my ($w, $h) = $ratio eq "4/3" ? (1600, 1200) : (1600, 1000);
    my $carga = $clase =~ /ph-hero/ ? qq{fetchpriority="high"} : qq{loading="lazy"};
    return qq{<img class="ph-foto$clase" style="--ph-ratio:$ratio" src="/assets/img/productos/$id.webp" alt="}.esc($desc).
      qq{" width="$w" height="$h" $carga decoding="async">};
  }
  return
    qq{<div class="ph$clase" style="--ph-ratio:$ratio" data-img="assets/img/productos/$id.webp" role="img" aria-label="}.esc($desc).qq{">\n}.
    qq{        <svg class="ph-mark" viewBox="0 0 64 64" aria-hidden="true"><path d="M32 8l22 8.5v18.6c0 13.6-9.3 23.4-22 26.9-12.7-3.5-22-13.3-22-26.9V16.5L32 8z" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linejoin="round"/><path d="M23 33l6.5 6.5L42 26" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"/></svg>\n}.
    qq{        <span class="ph-txt">}.esc($desc).qq{</span>\n}.
    qq{      </div>};
}

# ------------------------------------------------------------------ menús
# Tres grupos arriba (Personas, Empresas, Colectivos) y, dentro de cada uno,
# los subgrupos a la izquierda con sus seguros a la derecha, como en el menú
# de las aseguradoras grandes. Todo sale de @MENU en productos.pl.

# Devuelve el enlace de un ítem del menú: un slug del catálogo o "ext:<id>".
sub item_menu {
  my ($clave) = @_;
  if ($clave =~ /^ext:(.+)$/) {
    my ($e) = grep { ($_->{id} || "") eq $1 } @EXTERNOS;
    return $e ? { url => "/$e->{url}", texto => $e->{menu}, digital => 0 } : undef;
  }
  my $p = $POR_SLUG{$clave} or return undef;
  return { url => "/seguros/$p->{slug}/", texto => $p->{menu}, digital => $p->{digital} ? 1 : 0 };
}

sub menu_escritorio {
  my $html = "";
  for my $g (@MENU) {
    $html .= qq{        <li data-mega>\n};
    $html .= qq{          <button type="button" aria-expanded="false">}.esc($g->{nombre}).qq{\n};
    $html .= qq{            <svg class="caret" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 9l6 6 6-6" stroke-linecap="round" stroke-linejoin="round"/></svg>\n};
    $html .= qq{          </button>\n};
    $html .= qq{          <div class="mega mega-dos">\n};

    # Columna izquierda: los subgrupos
    $html .= qq{            <div class="mega-subs" role="tablist" aria-label="Categorías de }.esc($g->{nombre}).qq{">\n};
    my $i = 0;
    for my $s (@{$g->{subs}}) {
      my $id = "$g->{id}-$i";
      my $sel = $i == 0 ? "true" : "false";
      $html .= qq{              <button class="mega-sub" type="button" role="tab" data-sub="$id" aria-selected="$sel">}.esc($s->{nombre});
      $html .= qq{<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" aria-hidden="true"><path d="M9 6l6 6-6 6" stroke-linecap="round" stroke-linejoin="round"/></svg></button>\n};
      $i++;
    }
    $html .= qq{            </div>\n};

    # Columna derecha: los seguros del subgrupo activo
    $html .= qq{            <div class="mega-prods">\n};
    $i = 0;
    for my $s (@{$g->{subs}}) {
      my $id = "$g->{id}-$i";
      my $oculto = $i == 0 ? "" : " hidden";
      $html .= qq{              <div class="mega-panel" data-sub-panel="$id"$oculto>\n};
      for my $clave (@{$s->{items}}) {
        my $it = item_menu($clave) or next;
        my $tag = $it->{digital} ? qq{ <span class="mega-tag">100% digital</span>} : "";
        $html .= qq{                <a href="$it->{url}">}.esc($it->{texto}).qq{$tag</a>\n};
      }
      $html .= qq{              </div>\n};
      $i++;
    }
    $html .= qq{            </div>\n          </div>\n        </li>\n};
  }
  return $html;
}

sub menu_movil {
  my $html = "";
  for my $g (@MENU) {
    $html .= qq{  <details class="m-grupo">\n};
    $html .= qq{    <summary>}.esc($g->{nombre}).qq{</summary>\n};
    for my $s (@{$g->{subs}}) {
      $html .= qq{    <p class="m-sub">}.esc($s->{nombre}).qq{</p>\n};
      for my $clave (@{$s->{items}}) {
        my $it = item_menu($clave) or next;
        $html .= qq{    <a class="m-link" href="$it->{url}">}.esc($it->{texto}).qq{</a>\n};
      }
    }
    $html .= qq{  </details>\n};
  }
  return $html;
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
$mega        <li><a href="/#nosotros">Nosotros</a></li>
      </ul>
    </nav>

    <div class="header-actions">
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
  <div class="m-redes" data-redes-menu></div>
  <p class="m-menu-foot">Atendemos en toda Colombia<br><span data-cfg="HORARIO"></span></p>
</div>
HTML
}

# ----------------------------------------------------- cotizador rápido (#cotizar)
# Ficha del producto a la izquierda y formulario a la derecha. El botón abre
# WhatsApp con el mensaje ya escrito; el número sale de config.js, que es el
# que usa esta página.
sub cotizador {
  my ($p) = @_;
  my $frase = $p->{frase} || $p->{lead};

  # Beneficios: los del bloque de valor o, si no hay, los títulos de sus coberturas.
  my @ben = $p->{destacados} ? @{$p->{destacados}}
          : map { $_->[0] . ". " . $_->[1] } @{$p->{coberturas}}[0 .. ($#{$p->{coberturas}} > 3 ? 3 : $#{$p->{coberturas}})];
  my $lista = "";
  for my $b (@ben) {
    $lista .= qq{            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.6" aria-hidden="true"><path d="M4 12l5 5L20 6" stroke-linecap="round" stroke-linejoin="round"/></svg><span>}.esc($b).qq{</span></li>\n};
  }

  my $gancho = $p->{gancho}
    ? qq{        <p class="cot-gancho"><b>}.esc($p->{gancho}).qq{</b></p>\n} : "";

  my $ideal = $p->{ideal}
    ? qq{        <p class="cot-ideal"><b>Ideal para:</b> }.esc($p->{ideal}).qq{</p>\n} : "";

  my $tenamano = "";
  if ($p->{tenAMano}) {
    $tenamano .= qq{        <div class="cot-tener">\n          <b>Ten a mano</b>\n          <ul>\n};
    $tenamano .= qq{            <li>}.esc($_).qq{</li>\n} for @{$p->{tenAMano}};
    $tenamano .= qq{          </ul>\n        </div>\n};
  }

  # Campos del formulario
  my $campos = "";
  for my $c (@{$p->{campos}}) {
    my ($clave, $etiqueta, $tipo, $ej, $ops) = @$c;
    my $id = "cot-$clave";
    $campos .= qq{          <div class="field">\n};
    $campos .= qq{            <label for="$id">}.esc($etiqueta).qq{</label>\n};
    if ($tipo eq "lista" && $ops) {
      $campos .= qq{            <select id="$id" name="$clave" data-campo="}.esc($etiqueta).qq{" required>\n};
      $campos .= qq{              <option value="">Elige una opción</option>\n};
      $campos .= qq{              <option value="}.esc($_).qq{">}.esc($_).qq{</option>\n} for @$ops;
      $campos .= qq{            </select>\n};
    } else {
      my $t = $tipo eq "numero" ? "number" : "text";
      my $extra = $tipo eq "numero" ? qq{ inputmode="numeric" min="0"} : "";
      $campos .= qq{            <input id="$id" name="$clave" type="$t"$extra placeholder="}.esc($ej).qq{" data-campo="}.esc($etiqueta).qq{" required>\n};
    }
    $campos .= qq{            <p class="field-error" data-error hidden></p>\n};
    $campos .= qq{          </div>\n};
  }

  my $extra = $p->{extra}
    ? qq{          <label class="cot-check"><input type="checkbox" name="extra" data-campo="}.esc($p->{extra}).qq{"><span>}.esc($p->{extra}).qq{</span></label>\n} : "";

  my $comprar = $p->{digital}
    ? qq{\n          <a class="btn btn-ghost btn-block" data-cotizador-externo="$p->{digital}" data-evento="comprar_en_linea" data-producto="}.esc($p->{menu}).qq{">Comprar en línea</a>} : "";

  return <<"HTML";
<!-- ============ COTIZADOR RÁPIDO ============ -->
<section class="cot" id="cotizar">
  <div class="container">
    <div class="cot-grid">

      <div class="cot-ficha reveal">
        <span class="kicker">@{[ esc($p->{kicker}) ]}</span>
        <h2 class="h-md">@{[ esc($p->{nombre}) ]}</h2>
        <p class="cot-frase">@{[ esc($frase) ]}</p>
$gancho        <ul class="cot-ben">
$lista        </ul>
$ideal$tenamano        <p class="cot-comparamos">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 6h18M3 12h18M3 18h12" stroke-linecap="round"/></svg>
          Comparamos entre varias aseguradoras para darte la mejor opción.
        </p>
      </div>

      <form class="cot-form reveal" data-cot data-producto="@{[ esc($p->{menu}) ]}" novalidate>
        <h3>Recibe tu cotización</h3>
        <p class="cot-hint">Te escribimos por WhatsApp con opciones concretas. Sin compromiso.</p>

        <div class="field">
          <label for="cot-nombre">Tu nombre</label>
          <input id="cot-nombre" name="nombre" type="text" placeholder="María Fernanda" autocomplete="given-name" data-campo="Tu nombre" required>
          <p class="field-error" data-error hidden></p>
        </div>
$campos$extra
        <button class="btn btn-wa btn-block" type="submit">
          <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
          Recibir mi cotización
        </button>$comprar

        <a class="cot-asesor" data-wa="@{[ esc($p->{wa}) ]}" data-evento="hablar_asesor" data-producto="@{[ esc($p->{menu}) ]}">Prefiero hablar con un asesor</a>
        <p class="cot-legal">Al enviar autorizas el tratamiento de tus datos conforme a la <a href="/politica-datos.html">política de tratamiento de datos</a>.</p>
      </form>

    </div>
  </div>
</section>
HTML
}

# ------------------------------------- "Lo que hace diferente este seguro"
sub diferencia {
  my ($p) = @_;
  return "" unless $p->{adicionales};
  my $tarjetas = "";
  my $i = 0;
  for my $a (@{$p->{adicionales}}) {
    my $d = $i % 4;
    $tarjetas .= qq{      <article class="dif-card reveal"}.($d ? qq{ data-delay="$d"} : "").qq{>\n};
    $tarjetas .= qq{        <span class="dif-ic"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" aria-hidden="true"><path d="M5 13l4 4L19 7" stroke-linecap="round" stroke-linejoin="round"/></svg></span>\n};
    $tarjetas .= qq{        <h3>}.esc($a->[0]).qq{</h3>\n};
    $tarjetas .= qq{        <p>}.esc($a->[1]).qq{</p>\n};
    $tarjetas .= qq{      </article>\n};
    $i++;
  }

  my $complementa = "";
  if ($p->{complementa}) {
    $complementa .= qq{    <div class="dif-mas reveal">\n      <h3>Complementa tu póliza</h3>\n      <ul>\n};
    $complementa .= qq{        <li>}.esc($_).qq{</li>\n} for @{$p->{complementa}};
    $complementa .= qq{      </ul>\n    </div>\n};
  }

  my $aviso = $p->{aviso} ? qq{ }.esc($p->{aviso}) : "";

  return <<"HTML";
<!-- ============ LO QUE HACE DIFERENTE ============ -->
<section class="pad franja" id="diferente">
  <div class="container">
    <div class="head reveal">
      <span class="kicker">La diferencia</span>
      <h2 class="h-md">Lo que hace diferente este seguro</h2>
    </div>
    <div class="dif-grid">
$tarjetas    </div>
$complementa
    <p class="dif-nota">Beneficios sujetos al plan contratado, ciudad y condiciones de la póliza. Te confirmamos cuáles aplican en tu caso.$aviso</p>

    <div class="center" style="margin-top:38px">
      <a class="btn btn-primary" href="#cotizar" data-scroll>Cotizar este seguro</a>
    </div>
  </div>
</section>
HTML
}
# ------------------------------------------------- bloque "Síguenos" (antes del pie)
sub siguenos {
  return <<"HTML";
<!-- ============ SÍGUENOS ============ -->
<section class="sig pad" id="siguenos">
  <div class="container">
    <div class="head center reveal">
      <span class="kicker">Síguenos</span>
      <h2 class="h-md">Tips, noticias y beneficios para protegerte</h2>
    </div>

    <div class="sig-btns reveal">
      <a class="sig-btn sig-ig" data-red-btn="instagram" target="_blank" rel="noopener" data-evento="clic_redes" data-red="instagram">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="5.2"/><circle cx="12" cy="12" r="4.1"/><circle cx="17.4" cy="6.6" r="1.2" fill="currentColor" stroke="none"/></svg>
        <span><b>Síguenos en Instagram</b><i data-red-usuario="instagram"></i></span>
      </a>
      <a class="sig-btn sig-fb" data-red-btn="facebook" target="_blank" rel="noopener" data-evento="clic_redes" data-red="facebook">
        <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M22 12a10 10 0 1 0-11.6 9.9v-7H7.9V12h2.5V9.8c0-2.5 1.5-3.9 3.7-3.9 1.1 0 2.2.2 2.2.2v2.4h-1.2c-1.2 0-1.6.8-1.6 1.6V12h2.7l-.4 2.9h-2.3v7A10 10 0 0 0 22 12z"/></svg>
        <span><b>Síguenos en Facebook</b><i data-red-usuario="facebook"></i></span>
      </a>
    </div>

  </div>
</section>
HTML
}

# --------------------------------------------------------------- pie compartido
sub pie {
  my ($cols) = @_;
  my $sig = siguenos();
  return $sig . <<"HTML";
<!-- ============ PIE ============ -->
<footer class="site-footer">
  <div class="container">
    <div class="f-sos">
      <div>
        <b>¿Tuviste un siniestro? Escríbenos de inmediato</b>
        <p>Te decimos qué hacer en el sitio y radicamos contigo la reclamación.</p>
      </div>
      <a class="btn btn-warm" data-wa="Hola, tuve un siniestro y necesito ayuda." data-evento="clic_whatsapp" data-producto="Siniestro">Reportar un siniestro</a>
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
        <a data-wa="Hola Seguros Willisch, quiero cotizar un seguro." data-evento="clic_whatsapp" data-producto="Pie de página">
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
        <span class="f-horario">
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
        <!-- [COMPLETAR] Falta la página de términos y condiciones. -->
        <a href="#" data-pendiente>Términos y condiciones</a>
        <span>·</span>
        <span>© <span data-year>2026</span> Seguros Willisch. Todos los derechos reservados.</span>
      </div>
    </div>
  </div>
</footer>

<!-- ============ FLOTANTES ============ -->
<div class="wa-float" data-wa-float>
  <span class="wa-msg"></span>
  <a class="wa-btn" href="https://wa.me/573007525773" data-wa="Hola Seguros Willisch, quiero cotizar un seguro." data-evento="clic_whatsapp" data-producto="Burbuja" aria-label="Escribir por WhatsApp" style="position:relative">
    <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
  </a>
</div>

<!-- Barra fija de móvil -->
<div class="barra-movil" data-barra>
  <a class="bm-wa" data-wa="Hola Seguros Willisch, quiero cotizar un seguro." data-evento="clic_whatsapp" data-producto="Barra móvil">
    <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
    WhatsApp
  </a>
</div>

<button class="to-top" data-totop type="button" aria-label="Volver arriba" style="position:fixed">
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
  my $cot  = cotizador($p);
  my $dif  = diferencia($p);

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
    qq(      {"\@type":"ListItem","position":2,"name":") . json_esc($p->{menu}) . qq(","item":"$url"}\n) .
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
    $btn_digital = qq{\n          <a class="btn btn-ghost" data-cotizador-externo="$p->{digital}" data-evento="comprar_en_linea" data-producto="} . esc($p->{menu}) . qq{">Comprar en línea</a>};
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

<link rel="icon" href="/favicon.ico" sizes="any">
<link rel="icon" type="image/png" sizes="32x32" href="/assets/logos/favicon-32.png">
<link rel="icon" type="image/png" sizes="192x192" href="/assets/logos/favicon-192.png">
<link rel="apple-touch-icon" href="/assets/logos/apple-touch-icon.png">

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
<body class="no-js pagina-producto" data-producto="@{[ esc($p->{menu}) ]}">

$head
<main>

<!-- ============ PORTADA ============ -->
<section class="prod-hero" id="inicio"
         data-wa-context="¿Hablamos de tu @{[ esc($p->{menu}) ]}?" data-wa-msg="@{[ esc($p->{wa}) ]}">
  <div class="container">
    <nav class="miga" aria-label="Ruta">
      <a href="/">Inicio</a> <span aria-hidden="true">›</span>
      <b>@{[ esc($p->{menu}) ]}</b>
    </nav>

    <div class="prod-hero-grid">
      <div class="prod-hero-txt">
        <span class="kicker">@{[ esc($p->{kicker}) ]}</span>
        <h1 class="h-lg">@{[ esc($p->{h1}) ]}</h1>
        <p class="lead">@{[ esc($p->{lead}) ]}</p>
        <div class="prod-cta">
          <a class="btn btn-primary" href="#cotizar" data-scroll>Cotizar este seguro</a>
          <a class="btn btn-wa" data-wa="@{[ esc($p->{wa}) ]}" data-evento="hablar_asesor" data-producto="@{[ esc($p->{menu}) ]}">
            <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
            Hablar con un asesor
          </a>$btn_digital
        </div>$nota_digital
      </div>

      <div class="prod-hero-img">
        $hero_img
      </div>
    </div>
  </div>
</section>

$cot
<!-- ============ QUÉ CUBRE ============ -->
<section class="pad franja" id="cubre">
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

$dif
<!-- ============ PREGUNTAS FRECUENTES ============ -->
<section class="pad franja" id="faq">
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
    <p class="rel-todos reveal"><a href="/#digitales">Ver los seguros que compras en línea →</a></p>
  </div>
</section>

<!-- ============ CIERRE ============ -->
<section class="cierre pad" id="contacto">
  <div class="container container-angosto center">
    <h2 class="h-md">¿Hablamos de tu caso?</h2>
    <p class="lead">Escríbenos por WhatsApp y te respondemos con opciones concretas, comparadas y explicadas. Sin compromiso.</p>
    <div class="prod-cta center-cta">
      <a class="btn btn-wa" data-wa="@{[ esc($p->{wa}) ]}" data-evento="hablar_asesor" data-producto="@{[ esc($p->{menu}) ]}">
        <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg>
        Hablar con un asesor
      </a>
      <a class="btn btn-primary" href="#cotizar" data-scroll>Cotizar este seguro</a>
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
  my $piehtml = pie($cols);
  $html =~ s{(<!--PIE:INICIO-->).*?(<!--PIE:FIN-->)}{$1
$piehtml$2}s;
  $html =~ s{(<!--MENU:ESCRITORIO-->).*?(<!--MENU:FIN-->)}{$1\n$mega      $2}s;
  $html =~ s{(<!--MENU:MOVIL-->).*?(<!--MENU:MOVIL-FIN-->)}{$1\n$mmenu  $2}s;
  if ($html !~ /<!--MENU:ESCRITORIO-->/) {
    print "  ! index.html: faltan los marcadores <!--MENU:*-->, no toqué nada\n";
  } elsif ($html ne $antes) {
    open(my $out, ">:encoding(UTF-8)", "$RAIZ/index.html") or die $!;
    print $out $html; close $out;
    print "  ~ index.html: menú y pie sincronizados\n";
  } else {
    print "  = index.html: ya estaba al día\n";
  }
}

# --- Lista numerada de fotos pendientes, para que nunca se desfase del catálogo.
#     Se regenera con el resto: si agregas un producto, su foto entra sola.
{
  my @filas; my $n = 0;
  for my $e (["gerencia","Gerencia"], ["operaciones","Operaciones"], ["comercial","Asesoría comercial"]) {
    $n++;
    push @filas, [$n, "Inicio · equipo", "3/4 vertical", "1200×1600",
      "Retrato de quien está en $e->[1]", "equipo/$e->[0].webp"];
  }
  for my $p (@PRODUCTOS) {
    for my $im (@{ $p->{imgs} || [] }) {
      $n++;
      my ($id, $ratio, $desc) = @$im;
      my $medida = $ratio eq "16/10" ? "1600×1000" : $ratio eq "4/3" ? "1600×1200" : $ratio;
      push @filas, [$n, "/seguros/$p->{slug}/", $ratio, $medida, $desc, "productos/$id.webp"];
    }
  }
  my $tabla = "| # | Dónde va | Proporción | Medida | Qué debería mostrar | Archivo final |
";
  $tabla .= "|---|---|---|---|---|---|
";
  $tabla .= sprintf("| **%d** | %s | %s | %s | %s | `%s` |
", @$_) for @filas;

  my $md = "$RAIZ/assets/img/PENDIENTES-IMAGENES.md";
  if (-f $md) {
    open(my $fh, "<:encoding(UTF-8)", $md) or die $!;
    local $/; my $t = <$fh>; close $fh;
    $t =~ s{^# Fotos pendientes — \d+ en total}{# Fotos pendientes — $n en total}m;
    $t =~ s{(<!--TABLA:INICIO-->).*?(<!--TABLA:FIN-->)}{$1\n$tabla$2}s;
    open(my $o, ">:encoding(UTF-8)", $md) or die $!;
    print $o $t; close $o;
    print "  ~ assets/img/PENDIENTES-IMAGENES.md ($n fotos)
";
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
