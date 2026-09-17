/* =========================================================
   SEGUROS WILLISCH — COMPORTAMIENTO
   Vanilla JS. Cada módulo aislado: si uno falla, el resto sigue.
   El contenido crítico vive en el HTML; esto solo lo embellece.
   ========================================================= */
(function () {
  "use strict";

  var CFG = window.WILLISCH || {};
  var reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var finePointer = window.matchMedia("(hover: hover) and (pointer: fine)").matches;

  function safe(fn, nombre) {
    try { fn(); } catch (e) { console.warn("[willisch:" + nombre + "]", e); }
  }
  function $(sel, ctx) { return (ctx || document).querySelector(sel); }
  function $$(sel, ctx) { return Array.prototype.slice.call((ctx || document).querySelectorAll(sel)); }

  document.documentElement.classList.remove("no-js");
  document.body.classList.remove("no-js");

  /* ---------- Preloader ---------- */
  function initPreloader() {
    var pre = $("[data-preloader]");
    if (!pre) return;
    function cerrar() { pre.classList.add("done"); }
    if (sessionStorage.getItem("willisch_visto") === "1" || reduce) {
      pre.style.transition = "none";
      cerrar();
      return;
    }
    sessionStorage.setItem("willisch_visto", "1");
    setTimeout(cerrar, 1800);
    setTimeout(cerrar, 4000); // salida de emergencia
    window.addEventListener("load", function () { setTimeout(cerrar, 900); });
  }

  /* ---------- Tema claro / oscuro ---------- */
  function initTema() {
    var btn = $("[data-theme-btn]");
    var guardado = null;
    try { guardado = localStorage.getItem("willisch_tema"); } catch (e) {}
    if (guardado) document.documentElement.setAttribute("data-theme", guardado);
    if (!btn) return;
    btn.addEventListener("click", function () {
      // El sitio arranca siempre en claro (es el look de marca); el oscuro es una
      // elección explícita del visitante y se recuerda en su navegador.
      var actual = document.documentElement.getAttribute("data-theme") || "light";
      var nuevo = actual === "dark" ? "light" : "dark";
      document.documentElement.setAttribute("data-theme", nuevo);
      try { localStorage.setItem("willisch_tema", nuevo); } catch (e) {}
    });
  }

  /* ---------- Enlaces de WhatsApp ---------- */
  function initWhatsApp() {
    if (typeof window.waLink !== "function") return;
    $$("[data-wa]").forEach(function (el) {
      var msg = el.getAttribute("data-wa");
      el.setAttribute("href", window.waLink(msg || CFG.MSG_DEFECTO));
      el.setAttribute("target", "_blank");
      el.setAttribute("rel", "noopener");
    });
  }

  /* ---------- Header inteligente ---------- */
  function initHeader() {
    var header = $("[data-header]");
    if (!header) return;
    var ultimo = window.scrollY;
    var ticking = false;
    function update() {
      var y = window.scrollY;
      header.classList.toggle("glass", y > 24);
      var abierto = document.body.classList.contains("menu-abierto");
      if (!abierto && y > 340 && y > ultimo + 6) header.classList.add("hidden");
      else if (y < ultimo - 6 || y < 200) header.classList.remove("hidden");
      ultimo = y;
      ticking = false;
    }
    update();
    window.addEventListener("scroll", function () {
      if (!ticking) { ticking = true; window.requestAnimationFrame(update); }
    }, { passive: true });
  }

  /* ---------- Mega menú ---------- */
  function initMega() {
    var items = $$("[data-mega]");
    if (!items.length) return;
    function cerrarTodos(excepto) {
      items.forEach(function (li) {
        if (li !== excepto) {
          li.classList.remove("open");
          var b = $("button", li);
          if (b) b.setAttribute("aria-expanded", "false");
        }
      });
    }
    items.forEach(function (li) {
      var btn = $("button", li);
      if (!btn) return;
      function abrir() { cerrarTodos(li); li.classList.add("open"); btn.setAttribute("aria-expanded", "true"); }
      function cerrar() { li.classList.remove("open"); btn.setAttribute("aria-expanded", "false"); }
      btn.addEventListener("click", function (e) {
        e.stopPropagation();
        if (li.classList.contains("open")) cerrar(); else abrir();
      });
      if (finePointer) {
        li.addEventListener("mouseenter", abrir);
        li.addEventListener("mouseleave", cerrar);
      }
      $$("a", li).forEach(function (a) { a.addEventListener("click", cerrar); });
    });
    document.addEventListener("click", function (e) {
      if (!e.target.closest("[data-mega]")) cerrarTodos(null);
    });
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape") cerrarTodos(null);
    });
  }

  /* ---------- Menú móvil ---------- */
  function initMenuMovil() {
    var btn = $("[data-burger]");
    var menu = $("[data-mmenu]");
    if (!btn || !menu) return;
    function cerrar() {
      menu.classList.remove("open");
      btn.classList.remove("open");
      btn.setAttribute("aria-expanded", "false");
      document.body.classList.remove("menu-abierto");
      document.body.style.overflow = "";
    }
    btn.addEventListener("click", function () {
      var abierto = menu.classList.toggle("open");
      btn.classList.toggle("open", abierto);
      btn.setAttribute("aria-expanded", abierto ? "true" : "false");
      document.body.classList.toggle("menu-abierto", abierto);
      document.body.style.overflow = abierto ? "hidden" : "";
    });
    $$("a", menu).forEach(function (a) { a.addEventListener("click", cerrar); });
    document.addEventListener("keydown", function (e) { if (e.key === "Escape") cerrar(); });
  }

  /* ---------- Revelado al hacer scroll ---------- */
  function initReveal() {
    var items = $$(".reveal, [data-inview]");
    if (!items.length) return;
    function mostrarTodo() {
      items.forEach(function (el) {
        el.classList.add("in");
        if (el.classList.contains("word-reveal")) el.classList.add("in");
      });
    }
    if (typeof IntersectionObserver === "undefined") { mostrarTodo(); return; }
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (!en.isIntersecting) return;
        en.target.classList.add("in");
        io.unobserve(en.target);
      });
    }, { threshold: 0.05, rootMargin: "0px 0px -4% 0px" });
    items.forEach(function (el) { io.observe(el); });
    // Temporizador de seguridad: a los 6 s nada queda invisible.
    setTimeout(function () {
      $$(".reveal:not(.in), [data-inview]:not(.in)").forEach(function (el) {
        if (el.getBoundingClientRect().top < window.innerHeight * 1.4) el.classList.add("in");
      });
    }, 6000);
  }

  /* ---------- Titular por palabras ---------- */
  function initTitular() {
    $$("[data-words]").forEach(function (el) {
      if (el.dataset.split === "1") return;
      var partes = el.innerHTML.split(/(<br\s*\/?>)/i);
      var html = "";
      partes.forEach(function (p) {
        if (/^<br/i.test(p)) { html += p; return; }
        p.split(/\s+/).forEach(function (w) {
          if (!w) return;
          html += '<span class="word-reveal reveal-word"><span>' + w + "</span></span> ";
        });
      });
      el.innerHTML = html;
      el.dataset.split = "1";
      $$(".reveal-word", el).forEach(function (w, i) {
        w.querySelector("span").style.transitionDelay = (i * 0.055) + "s";
        setTimeout(function () { w.classList.add("in"); }, 120);
      });
    });
  }

  /* ---------- Palabra rotativa ---------- */
  function initRotator() {
    var mask = $("[data-rotator]");
    if (!mask) return;
    var palabras = (mask.getAttribute("data-rotator") || "").split("|").filter(Boolean);
    if (palabras.length < 2) return;
    var b = $("b", mask);
    if (!b) return;
    var i = 0;
    setInterval(function () {
      i = (i + 1) % palabras.length;
      b.classList.add("out");
      setTimeout(function () {
        b.textContent = palabras[i];
        b.classList.remove("out");
        b.classList.add("in");
        // fuerza reflow para reiniciar la transición
        void b.offsetWidth;
        b.classList.remove("in");
      }, 420);
    }, 2600);
  }

  /* ---------- Hero: parallax y convergencia del escudo ---------- */
  function initHero() {
    var stage = $("[data-stage]");
    if (!stage) return;
    var cards = $$(".ph-card", stage);
    var outline = $(".shield-outline", stage);

    if (finePointer && !reduce) {
      var hero = $(".hero");
      hero.addEventListener("mousemove", function (e) {
        var r = hero.getBoundingClientRect();
        var px = ((e.clientX - r.left) / r.width - 0.5) * 26;
        var py = ((e.clientY - r.top) / r.height - 0.5) * 26;
        stage.style.setProperty("--px", px.toFixed(2) + "px");
        stage.style.setProperty("--py", py.toFixed(2) + "px");
      });
      hero.addEventListener("mouseleave", function () {
        stage.style.setProperty("--px", "0px");
        stage.style.setProperty("--py", "0px");
      });
    }

    if (reduce) return;
    var ticking = false;
    function converger() {
      var r = stage.getBoundingClientRect();
      var w = r.width;
      // 0 → disperso, 1 → agrupado en forma de escudo
      var p = Math.min(1, Math.max(0, (window.scrollY) / (window.innerHeight * 0.85)));
      cards.forEach(function (c) {
        var tx = parseFloat(c.dataset.tx || 0) / 100 * w;
        var ty = parseFloat(c.dataset.ty || 0) / 100 * w;
        c.style.setProperty("--dx", (tx * p).toFixed(1) + "px");
        c.style.setProperty("--dy", (ty * p).toFixed(1) + "px");
        c.style.setProperty("--sc", (1 - p * 0.07).toFixed(3));
      });
      if (outline) outline.style.setProperty("--draw", p.toFixed(3));
      ticking = false;
    }
    converger();
    window.addEventListener("scroll", function () {
      if (!ticking) { ticking = true; window.requestAnimationFrame(converger); }
    }, { passive: true });
    window.addEventListener("resize", converger);
  }

  /* ---------- Contadores ---------- */
  function initContadores() {
    var nums = $$("[data-count]");
    if (!nums.length) return;
    function animar(el) {
      var destino = parseFloat(el.getAttribute("data-count")) || 0;
      var prefijo = el.getAttribute("data-prefix") || "";
      if (reduce) { el.textContent = prefijo + destino; return; }
      var t0 = null, dur = 1700;
      function paso(t) {
        if (!t0) t0 = t;
        var p = Math.min(1, (t - t0) / dur);
        var eased = 1 - Math.pow(1 - p, 3);
        el.textContent = prefijo + Math.round(destino * eased);
        if (p < 1) requestAnimationFrame(paso);
      }
      requestAnimationFrame(paso);
    }
    if (typeof IntersectionObserver === "undefined") { nums.forEach(animar); return; }
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (!en.isIntersecting) return;
        animar(en.target);
        io.unobserve(en.target);
      });
    }, { threshold: 0.4 });
    nums.forEach(function (n) { io.observe(n); });
  }

  /* ---------- Drawer de "¿Qué quieres proteger?" ---------- */
  function initDrawer() {
    var drawer = $("[data-drawer]");
    var back = $("[data-drawer-back]");
    if (!drawer || !back) return;
    var titulo = $("[data-drawer-title]", drawer);
    var sub = $("[data-drawer-sub]", drawer);
    var body = $("[data-drawer-body]", drawer);
    var ultimoFoco = null;

    function abrir(card) {
      ultimoFoco = card;
      var nombre = card.getAttribute("data-nombre") || "";
      titulo.textContent = nombre;
      sub.textContent = card.getAttribute("data-sub") || "";
      var productos = (card.getAttribute("data-productos") || "").split("|").filter(Boolean);
      body.innerHTML = "";
      productos.forEach(function (item) {
        var partes = item.split("::");
        var pNombre = partes[0] || "";
        var pBeneficio = partes[1] || "";
        var a = document.createElement("a");
        a.className = "drawer-item";
        a.href = window.waLink("Hola Seguros Willisch, quiero cotizar " + pNombre + ". Vengo de la web.");
        a.target = "_blank";
        a.rel = "noopener";
        a.innerHTML =
          '<span class="di-txt"><strong></strong><span></span></span>' +
          '<span class="di-wa"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2z"/></svg></span>';
        $("strong", a).textContent = pNombre;
        $(".di-txt span", a).textContent = pBeneficio;
        body.appendChild(a);
      });
      drawer.classList.add("open");
      back.classList.add("open");
      document.body.style.overflow = "hidden";
      var cerrarBtn = $(".drawer-close", drawer);
      if (cerrarBtn) cerrarBtn.focus();
    }
    function cerrar() {
      drawer.classList.remove("open");
      back.classList.remove("open");
      document.body.style.overflow = "";
      if (ultimoFoco) ultimoFoco.focus();
    }
    $$("[data-productos]").forEach(function (card) {
      card.addEventListener("click", function () { abrir(card); });
    });
    $$(".drawer-close", drawer).forEach(function (b) { b.addEventListener("click", cerrar); });
    back.addEventListener("click", cerrar);
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && drawer.classList.contains("open")) cerrar();
    });
  }

  /* ---------- Portafolio: pestañas + buscador ---------- */
  function initPortafolio() {
    var tabs = $$("[data-tab]");
    var pill = $("[data-pill]");
    var cards = $$("[data-cat]");
    var input = $("[data-buscar]");
    var vacio = $("[data-sin-resultados]");
    if (!tabs.length || !cards.length) return;
    var catActiva = "individuales";

    function moverPill() {
      if (!pill) return;
      var activa = tabs.filter(function (t) { return t.getAttribute("aria-selected") === "true"; })[0];
      if (!activa) return;
      pill.style.width = activa.offsetWidth + "px";
      pill.style.transform = "translateX(" + activa.offsetLeft + "px)";
    }
    // Coincide por inicio de palabra, no por subcadena suelta: así "moto" encuentra
    // "motos" pero no "terremoto" ni "automotor".
    function coincide(claves, q) {
      return claves.toLowerCase().split(/\s+/).some(function (palabra) {
        return palabra.indexOf(q) === 0;
      });
    }
    function filtrar() {
      var q = (input && input.value || "").trim().toLowerCase();
      var visibles = 0;
      cards.forEach(function (c) {
        var okCat = q ? true : c.getAttribute("data-cat") === catActiva;
        var okQ = !q || coincide(c.getAttribute("data-keys") || "", q);
        var mostrar = okCat && okQ;
        c.classList.toggle("hide", !mostrar);
        if (mostrar) visibles++;
      });
      if (vacio) vacio.classList.toggle("show", visibles === 0);
    }
    tabs.forEach(function (t) {
      t.addEventListener("click", function () {
        tabs.forEach(function (o) { o.setAttribute("aria-selected", "false"); });
        t.setAttribute("aria-selected", "true");
        catActiva = t.getAttribute("data-tab");
        if (input) input.value = "";
        moverPill();
        filtrar();
      });
    });
    if (input) input.addEventListener("input", filtrar);
    moverPill();
    filtrar();
    window.addEventListener("resize", moverPill);
    window.addEventListener("load", moverPill);
  }

  /* ---------- Movilidad: scroll horizontal fijado ---------- */
  function initMovilidad() {
    var sec = $("[data-mov]");
    if (!sec) return;
    var track = $("[data-mov-track]", sec);
    var barra = $("[data-mov-bar]", sec);
    var dots = $$("[data-mov-dots] i", sec);
    var paneles = $$(".mov-panel", track);
    if (!track || !paneles.length) return;

    var escritorio = window.matchMedia("(min-width: 900px)");

    function alturaSeccion() {
      if (!escritorio.matches) { sec.style.height = ""; return; }
      // Una pantalla por panel, más una de margen para entrar y salir.
      sec.style.height = (paneles.length * 100) + "vh";
    }
    var ticking = false;
    function mover() {
      if (!escritorio.matches) { track.style.transform = ""; ticking = false; return; }
      var r = sec.getBoundingClientRect();
      var total = sec.offsetHeight - window.innerHeight;
      var avance = Math.min(1, Math.max(0, -r.top / total));
      var recorrido = track.scrollWidth - window.innerWidth;
      track.style.transform = "translate3d(" + (-avance * recorrido) + "px,0,0)";
      if (barra) barra.style.width = (avance * 100).toFixed(1) + "%";
      ticking = false;
    }
    alturaSeccion();
    mover();
    window.addEventListener("scroll", function () {
      if (!ticking) { ticking = true; window.requestAnimationFrame(mover); }
    }, { passive: true });
    window.addEventListener("resize", function () { alturaSeccion(); mover(); });

    // Puntos de navegación en móvil
    if (dots.length) {
      track.addEventListener("scroll", function () {
        var i = Math.round(track.scrollLeft / (track.scrollWidth / paneles.length));
        dots.forEach(function (d, k) { d.classList.toggle("on", k === i); });
      }, { passive: true });
    }
  }

  /* ---------- Salud: toggle para mí / familia / empresa ---------- */
  function initSalud() {
    var botones = $$("[data-salud]");
    if (!botones.length) return;
    var textos = $$("[data-salud-txt]");
    function aplicar(modo) {
      textos.forEach(function (el) {
        var valor = el.getAttribute("data-" + modo);
        if (valor) {
          el.style.opacity = "0";
          setTimeout(function () {
            el.textContent = valor;
            el.style.opacity = "1";
          }, 180);
        }
      });
    }
    textos.forEach(function (el) { el.style.transition = "opacity .25s ease"; });
    botones.forEach(function (b) {
      b.addEventListener("click", function () {
        botones.forEach(function (o) { o.setAttribute("aria-pressed", "false"); });
        b.setAttribute("aria-pressed", "true");
        aplicar(b.getAttribute("data-salud"));
      });
    });
  }

  /* ---------- Vida deudor: calculadora ilustrativa ---------- */
  function initCalculadora() {
    var input = $("[data-calc]");
    var salida = $("[data-calc-out]");
    if (!input || !salida) return;
    function formatear(n) {
      return "$" + n.toLocaleString("es-CO");
    }
    input.addEventListener("input", function () {
      var limpio = input.value.replace(/[^\d]/g, "");
      if (!limpio) { salida.textContent = ""; input.value = ""; return; }
      var valor = parseInt(limpio, 10);
      input.value = valor.toLocaleString("es-CO");
      salida.textContent = "Protegerías " + formatear(valor) + " para tu familia.";
    });
  }

  /* ---------- Proceso: línea que se dibuja ---------- */
  function initProceso() {
    var linea = $("[data-proc-line] i");
    var pasos = $$("[data-proc-step]");
    if (!linea || !pasos.length) return;
    var cont = $("[data-proc]");
    var ticking = false;
    function pintar() {
      var r = cont.getBoundingClientRect();
      var avance = Math.min(1, Math.max(0, (window.innerHeight * 0.72 - r.top) / r.height));
      linea.style.height = (avance * 100).toFixed(1) + "%";
      pasos.forEach(function (p) {
        var pr = p.getBoundingClientRect();
        p.classList.toggle("in", pr.top < window.innerHeight * 0.78);
      });
      ticking = false;
    }
    pintar();
    window.addEventListener("scroll", function () {
      if (!ticking) { ticking = true; window.requestAnimationFrame(pintar); }
    }, { passive: true });
  }

  /* ---------- Robot: ojos y terminal ---------- */
  function initRobot() {
    var ojos = $$("[data-robot-eye]");
    if (ojos.length && finePointer && !reduce) {
      document.addEventListener("mousemove", function (e) {
        ojos.forEach(function (ojo) {
          var r = ojo.getBoundingClientRect();
          var cx = r.left + r.width / 2;
          var cy = r.top + r.height / 2;
          var ang = Math.atan2(e.clientY - cy, e.clientX - cx);
          var d = 2.2;
          ojo.style.transform = "translate(" + (Math.cos(ang) * d).toFixed(2) + "px," + (Math.sin(ang) * d).toFixed(2) + "px)";
        });
      }, { passive: true });
    }

    var term = $("[data-robot-term]");
    if (!term) return;
    var lineas = [
      "> Revisando vencimientos... ✓",
      "> Recordatorios enviados ✓",
      "> Horario: 24/7 · Café consumido: 0"
    ];
    if (reduce) { term.innerHTML = lineas.join("<br>"); return; }
    var li = 0, ci = 0, buffer = "";
    function escribir() {
      if (li >= lineas.length) {
        setTimeout(function () { li = 0; ci = 0; buffer = ""; term.innerHTML = ""; escribir(); }, 3600);
        return;
      }
      if (ci <= lineas[li].length) {
        term.innerHTML = buffer + lineas[li].slice(0, ci);
        ci++;
        setTimeout(escribir, 26);
      } else {
        buffer += lineas[li] + "<br>";
        li++; ci = 0;
        setTimeout(escribir, 420);
      }
    }
    if (typeof IntersectionObserver !== "undefined") {
      var io = new IntersectionObserver(function (entries) {
        if (entries[0].isIntersecting) { escribir(); io.disconnect(); }
      }, { threshold: 0.3 });
      io.observe(term);
    } else { escribir(); }
  }

  /* ---------- FAQ ---------- */
  function initFaq() {
    $$("[data-faq]").forEach(function (item) {
      var btn = $(".faq-q", item);
      var panel = $(".faq-a", item);
      if (!btn || !panel) return;
      btn.addEventListener("click", function () {
        var abierto = item.classList.toggle("open");
        btn.setAttribute("aria-expanded", abierto ? "true" : "false");
        panel.style.maxHeight = abierto ? (panel.scrollHeight + "px") : "0px";
      });
    });
  }

  /* ---------- Cotizador por pasos ---------- */
  function initCotizador() {
    var form = $("[data-cotizador]");
    if (!form) return;
    var pasos = $$("[data-paso]", form);
    var barra = $("[data-q-prog]", form);
    var actual = 0;
    var respuestas = { para: "", seguro: "", financiar: "" };

    var SEGUROS = {
      "Para mí": ["Carro", "Moto", "SOAT", "Salud", "Medicina prepagada", "Vida", "Accidentes personales", "Hogar", "Mascotas", "Viajes"],
      "Mi familia o grupo": ["Salud familiar", "Vida grupo", "Exequias", "Accidentes personales colectivos", "Escuela deportiva", "Hogar"],
      "Mi empresa": ["Todo Riesgo Empresarial", "Pólizas de Cumplimiento", "Responsabilidad Civil", "ARL", "Transporte de mercancías", "Flotas", "Energía / paneles solares", "Cultivos"]
    };

    function pintarPaso() {
      pasos.forEach(function (p, i) { p.classList.toggle("on", i === actual); });
      if (barra) barra.style.width = ((actual + 1) / pasos.length * 100) + "%";
    }
    function chipsDe(lista, destino, campo) {
      destino.innerHTML = "";
      lista.forEach(function (txt) {
        var b = document.createElement("button");
        b.type = "button";
        b.className = "chip";
        b.setAttribute("aria-pressed", "false");
        b.textContent = txt;
        b.addEventListener("click", function () {
          $$(".chip", destino).forEach(function (o) { o.setAttribute("aria-pressed", "false"); });
          b.setAttribute("aria-pressed", "true");
          respuestas[campo] = txt;
          setTimeout(avanzar, 260);
        });
        destino.appendChild(b);
      });
    }
    function avanzar() {
      if (actual < pasos.length - 1) { actual++; pintarPaso(); }
    }

    // Paso 1
    $$("[data-para] .chip", form).forEach(function (b) {
      b.addEventListener("click", function () {
        $$("[data-para] .chip", form).forEach(function (o) { o.setAttribute("aria-pressed", "false"); });
        b.setAttribute("aria-pressed", "true");
        respuestas.para = b.textContent.trim();
        chipsDe(SEGUROS[respuestas.para] || [], $("[data-seguros]", form), "seguro");
        setTimeout(avanzar, 260);
      });
    });
    // Paso 3
    $$("[data-financiar] .chip", form).forEach(function (b) {
      b.addEventListener("click", function () {
        $$("[data-financiar] .chip", form).forEach(function (o) { o.setAttribute("aria-pressed", "false"); });
        b.setAttribute("aria-pressed", "true");
        respuestas.financiar = b.textContent.trim();
        setTimeout(avanzar, 260);
      });
    });
    // Atrás
    $$("[data-atras]", form).forEach(function (b) {
      b.addEventListener("click", function () { if (actual > 0) { actual--; pintarPaso(); } });
    });

    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var nombre = $("#q-nombre", form);
      var ciudad = $("#q-ciudad", form);
      var consent = $("#q-consent", form);
      if (!consent.checked) { consent.focus(); return; }
      if (!nombre.value.trim()) { nombre.focus(); return; }
      if (!ciudad.value.trim()) { ciudad.focus(); return; }

      var msg = "Hola Seguros Willisch, soy " + nombre.value.trim() + " de " + ciudad.value.trim() +
        ". Quiero cotizar " + (respuestas.seguro || "un seguro") +
        " para " + (respuestas.para || "mí").toLowerCase() +
        ". ¿Financiación?: " + (respuestas.financiar || "Quiero saber más") + ".";
      var url = window.waLink(msg);

      var done = $("[data-q-done]", form);
      if (done && !reduce) {
        pasos.forEach(function (p) { p.classList.remove("on"); });
        done.classList.add("on");
        if (barra) barra.style.width = "100%";
        setTimeout(function () { window.location.href = url; }, 1250);
      } else {
        window.location.href = url;
      }
    });

    pintarPaso();
  }

  /* ---------- Escuelas deportivas: formulario rápido ---------- */
  function initEscuelas() {
    var form = $("[data-esc-form]");
    if (!form) return;
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var disciplina = $("#esc-disciplina", form).value;
      var cantidad = $("#esc-cantidad", form).value;
      var ciudad = $("#esc-ciudad", form).value;
      var msg = "Hola Seguros Willisch, quiero cotizar una póliza de accidentes personales para una escuela deportiva de " +
        (disciplina || "deporte") + ", con " + (cantidad || "varios") + " deportistas, en " + (ciudad || "mi ciudad") + ".";
      window.open(window.waLink(msg), "_blank", "noopener");
    });
  }

  /* ---------- WhatsApp flotante contextual ---------- */
  function initFlotante() {
    var wrap = $("[data-wa-float]");
    if (!wrap) return;
    var burbuja = $(".wa-msg", wrap);
    var boton = $(".wa-btn", wrap);
    var secciones = $$("[data-wa-context]");

    function enHorario() {
      var ahora = new Date();
      var dia = ahora.getDay();
      var hora = ahora.getHours();
      var dias = CFG.DIAS_HABILES || [1, 2, 3, 4, 5, 6];
      return dias.indexOf(dia) !== -1 && hora >= (CFG.HORARIO_INICIO || 8) && hora < (CFG.HORARIO_FIN || 18);
    }
    var fueraDeHorario = !enHorario();

    function fijar(texto, mensajeWa) {
      if (!burbuja) return;
      burbuja.textContent = fueraDeHorario
        ? "Déjanos tu mensaje, te respondemos a primera hora"
        : texto;
      burbuja.classList.add("show");
      if (boton) boton.setAttribute("href", window.waLink(mensajeWa || CFG.MSG_DEFECTO));
    }
    fijar("¿Hablamos de tu seguro?", CFG.MSG_DEFECTO);

    if (!secciones.length || typeof IntersectionObserver === "undefined") return;
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (!en.isIntersecting) return;
        fijar(en.target.getAttribute("data-wa-context"), en.target.getAttribute("data-wa-msg"));
      });
    }, { threshold: 0.35 });
    secciones.forEach(function (s) { io.observe(s); });
  }

  /* ---------- Volver arriba con anillo de progreso ---------- */
  function initToTop() {
    var btn = $("[data-totop]");
    if (!btn) return;
    var circ = $(".ring circle", btn);
    var largo = 0;
    if (circ) {
      largo = 2 * Math.PI * parseFloat(circ.getAttribute("r"));
      circ.style.strokeDasharray = largo;
      circ.style.strokeDashoffset = largo;
    }
    var ticking = false;
    function pintar() {
      var alto = document.documentElement.scrollHeight - window.innerHeight;
      var p = alto > 0 ? Math.min(1, window.scrollY / alto) : 0;
      btn.classList.toggle("show", window.scrollY > 520);
      if (circ) circ.style.strokeDashoffset = (largo - largo * p).toFixed(2);
      ticking = false;
    }
    pintar();
    window.addEventListener("scroll", function () {
      if (!ticking) { ticking = true; window.requestAnimationFrame(pintar); }
    }, { passive: true });
    btn.addEventListener("click", function () {
      window.scrollTo({ top: 0, behavior: reduce ? "auto" : "smooth" });
    });
  }

  /* ---------- Datos de configuración en el HTML ---------- */
  function initDatos() {
    $$("[data-cfg]").forEach(function (el) {
      var clave = el.getAttribute("data-cfg");
      if (CFG[clave]) el.textContent = CFG[clave];
    });
    $$("[data-cfg-href]").forEach(function (el) {
      var clave = el.getAttribute("data-cfg-href");
      if (CFG[clave]) el.setAttribute("href", CFG[clave]);
      else el.style.display = "none";
    });
    $$("[data-mail]").forEach(function (el) {
      if (!CFG.EMAIL) return;
      el.setAttribute("href", "mailto:" + CFG.EMAIL);
      if (el.hasAttribute("data-mail-txt")) el.textContent = CFG.EMAIL;
    });
    var anio = $("[data-year]");
    if (anio) anio.textContent = new Date().getFullYear();
  }

  /* ---------- Arranque ---------- */
  function boot() {
    safe(initPreloader, "preloader");
    safe(initTema, "tema");
    safe(initDatos, "datos");
    safe(initWhatsApp, "whatsapp");
    safe(initHeader, "header");
    safe(initMega, "mega");
    safe(initMenuMovil, "menu-movil");
    safe(initTitular, "titular");
    safe(initReveal, "reveal");
    safe(initRotator, "rotator");
    safe(initHero, "hero");
    safe(initContadores, "contadores");
    safe(initDrawer, "drawer");
    safe(initPortafolio, "portafolio");
    safe(initMovilidad, "movilidad");
    safe(initSalud, "salud");
    safe(initCalculadora, "calculadora");
    safe(initProceso, "proceso");
    safe(initRobot, "robot");
    safe(initFaq, "faq");
    safe(initCotizador, "cotizador");
    safe(initEscuelas, "escuelas");
    safe(initFlotante, "flotante");
    safe(initToTop, "to-top");
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", boot);
  else boot();
})();
