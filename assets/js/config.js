/* =========================================================
   SEGUROS WILLISCH — CONFIGURACIÓN CENTRAL
   Cambia los datos aquí y se actualizan en todo el sitio.
   ========================================================= */

window.WILLISCH = {

  /* --- WhatsApp: solo dígitos, con indicativo de país (57) --- */
  WHATSAPP_NUMBER: "573007525773",

  /* --- Datos de contacto --- */
  EMAIL: "Mercadeo@seguroswillisch.com",
  DIRECCION: "Calle 77 # 59-35, Edificio Américas III, Oficina 1403, Barranquilla",
  MAPS_URL: "https://share.google/LXEykav0mIWhdiPig",
  HORARIO: "Lunes a sábado, 8:00 a. m. – 6:00 p. m.",

  /* --- Horario de atención, para el mensaje del botón flotante --- */
  HORARIO_INICIO: 8,   // 8 a. m.
  HORARIO_FIN: 18,     // 6 p. m.
  DIAS_HABILES: [1, 2, 3, 4, 5, 6], // lunes(1) a sábado(6)

  /* --- Redes sociales ---
     Solo se muestran las que estén en esta lista. Para agregar una nueva:
     añade { red: "linkedin", url: "https://..." }. Redes admitidas:
     instagram, facebook, linkedin, tiktok, youtube. */
  REDES: [
    { red: "instagram", url: "https://www.instagram.com/seguroswillisch/" },
    { red: "facebook",  url: "https://www.facebook.com/people/Seguros-Willisch/61575842832331/" }
  ],

  /* --- Aseguradoras aliadas (marquee de la franja de confianza) ---
     archivo: nombre del archivo dentro de assets/logos/. Si es null, se muestra
     el nombre en texto con la tipografía del sitio hasta que llegue el logo oficial.
     Para agregar o quitar una aliada, edita solo esta lista. */
  ALIADAS: [
    { nombre: "SURA",                       archivo: "sura.png",     alt: "Seguros SURA" },
    { nombre: "Seguros Bolívar",            archivo: "bolivar.png",  alt: "Seguros Bolívar" },
    { nombre: "Allianz",                    archivo: "allianz.png",  alt: "Allianz" },
    { nombre: "AXA Colpatria",              archivo: null,           alt: "AXA Colpatria" },
    { nombre: "Mapfre",                     archivo: "mapfre.png",   alt: "Mapfre" },
    { nombre: "Zurich",                     archivo: "zurich.png",   alt: "Zurich" },
    { nombre: "Seguros Mundial",            archivo: "mundial.png",  alt: "Seguros Mundial" },
    { nombre: "Seguros del Estado",         archivo: "estado.png",   alt: "Seguros del Estado" },
    { nombre: "La Equidad Seguros",         archivo: null,           alt: "La Equidad Seguros" },
    { nombre: "Colmena Seguros",            archivo: "colmena.png",  alt: "Colmena Seguros" },
    { nombre: "Quálitas",                   archivo: "qualitas.png", alt: "Quálitas" },
    { nombre: "Coomeva Medicina Prepagada", archivo: "coomeva.png",  alt: "Coomeva Medicina Prepagada" },
    { nombre: "Universal de Fianzas",       archivo: null,           alt: "Universal de Fianzas" }
  ],

  /* --- Aliadas financieras (banda de financiación) --- */
  FINANCIERAS: [
    { nombre: "Crediseguro", archivo: null, alt: "Crediseguro" },
    { nombre: "Finesa",      archivo: null, alt: "Finesa" }
  ],

  /* --- Cotizadores externos ---
     Estos dos productos se compran solos en el portal de la aseguradora.
     Las URL llevan nuestro código de asesor: NO cambies los parámetros,
     porque se pierde la trazabilidad de la venta. */
  COTIZADORES_EXTERNOS: {
    mascotas: "https://surapet.com.co/asesorcliente/97726",
    arrendamiento: "https://arrienda.facilito.ai/cotizadorarrendamiento?codasesor=97726&nombreasesor=Seguros+Willisch"
  },

  /* --- Mensaje por defecto de WhatsApp --- */
  MSG_DEFECTO: "Hola Seguros Willisch, quiero asesoría para cotizar un seguro."
};

/* Construye el enlace de WhatsApp con el mensaje ya escrito. */
window.waLink = function (mensaje) {
  var cfg = window.WILLISCH;
  var texto = mensaje || cfg.MSG_DEFECTO;
  return "https://wa.me/" + cfg.WHATSAPP_NUMBER + "?text=" + encodeURIComponent(texto);
};
