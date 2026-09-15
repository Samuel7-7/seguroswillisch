(function () {
  "use strict";

  var data = window.__BRAND__ || {};
  var reduced = matchMedia("(prefers-reduced-motion: reduce)").matches;
  var fineHover = matchMedia("(hover: hover) and (pointer: fine)").matches;

  var $ = function (sel, scope) { return (scope || document).querySelector(sel); };
  var $$ = function (sel, scope) { return Array.prototype.slice.call((scope || document).querySelectorAll(sel)); };

  function safe(fn, name) {
    try { fn(); } catch (e) { console.warn("[" + name + "]", e); }
  }

  /* ---------------------------------------------------------
     WhatsApp links + year
     --------------------------------------------------------- */
  function initWhatsApp() {
    var contact = data.contact || {};
    var messages = data.whatsappMessages || {};
    $$("[data-wa]").forEach(function (el) {
      var number = contact[el.getAttribute("data-wa")];
      var msgKey = el.getAttribute("data-wa-msg");
      var text = messages[msgKey] || messages.general || "";
      if (!number) return;
      el.setAttribute("href", "https://wa.me/" + number + "?text=" + encodeURIComponent(text));
    });
  }

  function initYear() {
    $$("[data-year]").forEach(function (el) { el.textContent = new Date().getFullYear(); });
  }

  /* ---------------------------------------------------------
     Nav: scrolled state + mobile menu + smooth anchors
     --------------------------------------------------------- */
  function initNav() {
    var nav = $("[data-nav]");
    var toggle = $("[data-nav-toggle]");
    var mobile = $("[data-nav-mobile]");
    if (!nav) return;

    var onScroll = function () {
      nav.classList.toggle("is-scrolled", window.scrollY > 12);
    };
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });

    if (toggle && mobile) {
      var closeMenu = function () {
        mobile.classList.remove("is-open");
        toggle.setAttribute("aria-expanded", "false");
        toggle.setAttribute("aria-label", "Abrir menú");
      };
      var openMenu = function () {
        mobile.classList.add("is-open");
        toggle.setAttribute("aria-expanded", "true");
        toggle.setAttribute("aria-label", "Cerrar menú");
      };
      toggle.addEventListener("click", function () {
        var isOpen = mobile.classList.contains("is-open");
        if (isOpen) closeMenu(); else openMenu();
      });
      $$("a", mobile).forEach(function (a) { a.addEventListener("click", closeMenu); });
      document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") closeMenu();
      });
    }
  }

  function initSmoothAnchors() {
    var navOffset = 92;
    document.addEventListener("click", function (e) {
      var a = e.target.closest && e.target.closest('a[href^="#"]');
      if (!a) return;
      var id = a.getAttribute("href");
      if (!id || id === "#") return;
      var el = document.querySelector(id);
      if (!el) return;
      e.preventDefault();
      var top = el.getBoundingClientRect().top + window.scrollY - navOffset;
      window.scrollTo({ top: top, behavior: reduced ? "auto" : "smooth" });
    });
  }

  /* ---------------------------------------------------------
     Scroll reveals + count-up (single IntersectionObserver)
     --------------------------------------------------------- */
  function animateCount(el) {
    if (el.dataset.counted) return;
    el.dataset.counted = "1";
    var target = parseFloat(el.getAttribute("data-count-to"), 10);
    if (isNaN(target)) return;
    if (reduced) { el.textContent = target; return; }

    var start = null;
    var duration = 1100;
    function step(ts) {
      if (start === null) start = ts;
      var progress = Math.min((ts - start) / duration, 1);
      var eased = 1 - Math.pow(1 - progress, 3);
      el.textContent = Math.round(target * eased);
      if (progress < 1) requestAnimationFrame(step);
      else el.textContent = target;
    }
    requestAnimationFrame(step);
  }

  function initReveals() {
    document.documentElement.classList.add("reveal-ready");
    var targets = $$("[data-reveal]");
    if (!targets.length) return;

    var reveal = function (el) {
      if (el.classList.contains("is-visible")) return;
      el.classList.add("is-visible");
      var counters = el.matches("[data-count-to]") ? [el] : $$("[data-count-to]", el);
      counters.forEach(animateCount);
    };

    if (typeof IntersectionObserver === "undefined") {
      targets.forEach(reveal);
      return;
    }

    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          reveal(entry.target);
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.01, rootMargin: "0px 0px -2% 0px" });

    targets.forEach(function (el) { io.observe(el); });

    setTimeout(function () {
      targets.forEach(function (el) {
        if (!el.classList.contains("is-visible") && el.getBoundingClientRect().top < window.innerHeight) {
          reveal(el);
        }
      });
    }, 6000);
  }

  /* ---------------------------------------------------------
     Card tilt (glass cards) — fine pointer only, never gated by reduced-motion
     --------------------------------------------------------- */
  function initTilt() {
    if (!fineHover) return;
    $$("[data-tilt]").forEach(function (card) {
      var bounds;
      var onMove = function (e) {
        bounds = card.getBoundingClientRect();
        var px = (e.clientX - bounds.left) / bounds.width - 0.5;
        var py = (e.clientY - bounds.top) / bounds.height - 0.5;
        card.style.transform = "perspective(700px) rotateX(" + (py * -6) + "deg) rotateY(" + (px * 6) + "deg) translateY(-4px)";
      };
      var reset = function () { card.style.transform = ""; };
      card.addEventListener("mouseover", function (e) {
        if (!card.contains(e.relatedTarget)) card.addEventListener("mousemove", onMove);
      });
      card.addEventListener("mouseout", function (e) {
        if (!card.contains(e.relatedTarget)) { card.removeEventListener("mousemove", onMove); reset(); }
      });
    });
  }

  /* ---------------------------------------------------------
     Magnetic primary buttons — fine pointer only
     --------------------------------------------------------- */
  function initMagnetic() {
    if (!fineHover) return;
    $$(".btn-primary").forEach(function (btn) {
      var strength = 0.22;
      var onMove = function (e) {
        var b = btn.getBoundingClientRect();
        var mx = (e.clientX - (b.left + b.width / 2)) * strength;
        var my = (e.clientY - (b.top + b.height / 2)) * strength;
        btn.style.transform = "translate(" + mx + "px, " + my + "px)";
      };
      var reset = function () { btn.style.transform = ""; };
      btn.addEventListener("mouseover", function (e) {
        if (!btn.contains(e.relatedTarget)) btn.addEventListener("mousemove", onMove);
      });
      btn.addEventListener("mouseout", function (e) {
        if (!btn.contains(e.relatedTarget)) { btn.removeEventListener("mousemove", onMove); reset(); }
      });
    });
  }

  /* ---------------------------------------------------------
     Boot
     --------------------------------------------------------- */
  function boot() {
    safe(initWhatsApp, "initWhatsApp");
    safe(initYear, "initYear");
    safe(initNav, "initNav");
    safe(initSmoothAnchors, "initSmoothAnchors");
    safe(initReveals, "initReveals");
    safe(initTilt, "initTilt");
    safe(initMagnetic, "initMagnetic");
    document.documentElement.classList.add("is-ready");
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot);
  } else {
    boot();
  }
})();
