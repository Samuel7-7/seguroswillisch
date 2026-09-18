/* =========================================================
   SEGUROS WILLISCH — Subpágina "Seguros para personas"
   Se carga después de site.js y solo añade lo propio de esta página.
   ========================================================= */
(function () {
  "use strict";

  var CFG = window.WILLISCH || {};
  var reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var finePointer = window.matchMedia("(hover: hover) and (pointer: fine)").matches;

  function safe(fn, nombre) {
    try { fn(); } catch (e) { console.warn("[personas:" + nombre + "]", e); }
  }
  function $(sel, ctx) { return (ctx || document).querySelector(sel); }
  function $$(sel, ctx) { return Array.prototype.slice.call((ctx || document).querySelectorAll(sel)); }

  /* ---------- Aliado que comparte la página (?aliado=nombre) ---------- */
  var aliado = "";

  function leerAliado() {
    var url = new URLSearchParams(window.location.search);
    var valor = (url.get("aliado") || "").trim();
    if (valor) {
      try { sessionStorage.setItem("willisch_aliado", valor); } catch (e) {}
    } else {
      try { valor = sessionStorage.getItem("willisch_aliado") || ""; } catch (e) {}
    }
    // Se limpia por si alguien manipula el enlace: solo texto legible y corto
    aliado = valor.replace(/[<>{}"'`\\]/g, "").slice(0, 60);
  }

  function mostrarAliado() {
    var linea = $("[data-aliado-linea]");
    if (!linea || !aliado) return;
    linea.innerHTML = "";
    linea.appendChild(document.createTextNode("Te comparte esta página: "));
    var b = document.createElement("b");
    b.textContent = aliado;
    linea.appendChild(b);
    linea.hidden = false;
  }

  /* ---------- WhatsApp: todos los mensajes llevan el aliado si existe ---------- */
  function initWhatsAppPersonas() {
    var original = window.waLink;
    if (typeof original !== "function") return;

    // A partir de aquí, cualquier enlace que construya site.js o esta página
    // incluye de dónde viene el visitante.
    window.waLink = function (mensaje) {
      var texto = mensaje || CFG.MSG_DEFECTO || "";
      if (aliado) texto += " Vengo de parte de " + aliado + ".";
      return original(texto);
    };

    $$("[data-wa-base]").forEach(function (el) {
      el.setAttribute("href", window.waLink(el.getAttribute("data-wa-base")));
      if (el.tagName === "A") {
        el.setAttribute("target", "_blank");
        el.setAttribute("rel", "noopener noreferrer");
      }
    });
  }

  /* ---------- Financieras desde config.js ---------- */
  function initFinancieras() {
    var cont = $("[data-financieras]");
    if (!cont) return;
    var lista = CFG.FINANCIERAS || [];
    cont.innerHTML = "";
    lista.forEach(function (f) {
      var s = document.createElement("span");
      s.className = "fin-partner";
      if (f.archivo) {
        var img = document.createElement("img");
        img.src = "assets/logos/" + f.archivo;
        img.alt = f.alt || f.nombre;
        img.loading = "lazy";
        img.onerror = function () { s.textContent = f.nombre; };
        s.appendChild(img);
      } else {
        s.textContent = f.nombre;
      }
      cont.appendChild(s);
    });
  }

  /* ---------- Tríptico del hero ---------- */
  function initTriptico() {
    var stage = $("[data-triptico]");
    if (!stage) return;

    // Se separan al cargar
    requestAnimationFrame(function () {
      requestAnimationFrame(function () { stage.classList.add("listo"); });
    });

    if (!finePointer || reduce) return;
    var hero = $(".hero-personas");
    if (!hero) return;
    hero.addEventListener("mousemove", function (e) {
      var r = hero.getBoundingClientRect();
      var px = ((e.clientX - r.left) / r.width - 0.5) * 18;
      var py = ((e.clientY - r.top) / r.height - 0.5) * 14;
      stage.style.setProperty("--px", px.toFixed(2) + "px");
      stage.style.setProperty("--py", py.toFixed(2) + "px");
    });
    hero.addEventListener("mouseleave", function () {
      stage.style.setProperty("--px", "0px");
      stage.style.setProperty("--py", "0px");
    });
  }

  /* ---------- Botones magnéticos ---------- */
  function initImanes() {
    if (!finePointer || reduce) return;
    $$("[data-iman]").forEach(function (btn) {
      btn.addEventListener("mousemove", function (e) {
        var r = btn.getBoundingClientRect();
        var x = (e.clientX - r.left - r.width / 2) * 0.22;
        var y = (e.clientY - r.top - r.height / 2) * 0.3;
        btn.style.transform = "translate3d(" + x.toFixed(1) + "px," + y.toFixed(1) + "px,0)";
      });
      btn.addEventListener("mouseleave", function () { btn.style.transform = ""; });
    });
  }

  /* ---------- Compartir la página ---------- */
  function initCompartir() {
    var url = window.location.origin + window.location.pathname + (aliado ? "?aliado=" + encodeURIComponent(aliado) : "");
    var titulo = "Seguros para personas — Seguros Willisch";
    var texto = "Vehículo, salud y vida: los tres seguros que más cotizamos, comparados entre 13 aseguradoras.";

    var wa = $("[data-compartir-wa]");
    if (wa) wa.setAttribute("href", "https://wa.me/?text=" + encodeURIComponent(texto + " " + url));

    var mail = $("[data-compartir-mail]");
    if (mail) mail.setAttribute("href", "mailto:?subject=" + encodeURIComponent(titulo) + "&body=" + encodeURIComponent(texto + "\n\n" + url));

    var btnNativo = $("[data-compartir]");
    if (btnNativo && navigator.share) {
      btnNativo.hidden = false;
      btnNativo.addEventListener("click", function () {
        navigator.share({ title: titulo, text: texto, url: url }).catch(function () {});
      });
    }

    var copiar = $("[data-copiar-enlace]");
    var etiqueta = $("[data-copiar-txt]");
    if (!copiar) return;
    copiar.addEventListener("click", function () {
      function confirmar() {
        if (!etiqueta) return;
        var antes = etiqueta.textContent;
        etiqueta.textContent = "¡Enlace copiado!";
        setTimeout(function () { etiqueta.textContent = antes; }, 2200);
      }
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(url).then(confirmar).catch(function () {});
      } else {
        var t = document.createElement("textarea");
        t.value = url; t.setAttribute("readonly", "");
        t.style.position = "fixed"; t.style.opacity = "0";
        document.body.appendChild(t); t.select();
        try { document.execCommand("copy"); confirmar(); } catch (e) {}
        document.body.removeChild(t);
      }
    });
  }

  /* ---------- Cotizador corto (3 pasos) ---------- */
  function initCotizadorCorto() {
    var form = $("[data-cotizador-corto]");
    if (!form) return;
    var pasos = $$("[data-paso]", form);
    var barra = $("[data-q-prog]", form);
    var actual = 0;
    var respuestas = { producto: "", para: "" };

    function pintar() {
      pasos.forEach(function (p, i) { p.classList.toggle("on", i === actual); });
      if (barra) barra.style.width = ((actual + 1) / pasos.length * 100) + "%";
    }
    function avanzar() { if (actual < pasos.length - 1) { actual++; pintar(); } }

    function grupo(sel, campo) {
      $$(sel + " .chip", form).forEach(function (b) {
        b.addEventListener("click", function () {
          $$(sel + " .chip", form).forEach(function (o) { o.setAttribute("aria-pressed", "false"); });
          b.setAttribute("aria-pressed", "true");
          respuestas[campo] = b.textContent.trim();
          setTimeout(avanzar, 240);
        });
      });
    }
    grupo("[data-producto]", "producto");
    grupo("[data-para]", "para");

    $$("[data-atras]", form).forEach(function (b) {
      b.addEventListener("click", function () { if (actual > 0) { actual--; pintar(); } });
    });

    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var nombre = $("#p-nombre", form);
      var ciudad = $("#p-ciudad", form);
      var consent = $("#p-consent", form);
      if (!consent.checked) { consent.focus(); return; }
      if (!nombre.value.trim()) { nombre.focus(); return; }
      if (!ciudad.value.trim()) { ciudad.focus(); return; }

      var msg = "Hola Seguros Willisch, soy " + nombre.value.trim() + " de " + ciudad.value.trim() +
        ". Quiero cotizar " + (respuestas.producto || "un seguro").toLowerCase() +
        " " + (respuestas.para || "para mí").toLowerCase() + ".";
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

    pintar();
  }

  function boot() {
    safe(leerAliado, "aliado");
    safe(mostrarAliado, "aliado-linea");
    safe(initWhatsAppPersonas, "whatsapp");
    safe(initFinancieras, "financieras");
    safe(initTriptico, "triptico");
    safe(initImanes, "imanes");
    safe(initCompartir, "compartir");
    safe(initCotizadorCorto, "cotizador-corto");
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", boot);
  else boot();
})();
