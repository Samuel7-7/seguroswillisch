/* =========================================================
   SEGUROS WILLISCH — CONFIGURACIÓN CENTRAL
   Cambia los datos aquí y se actualizan en todo el sitio.
   ========================================================= */

window.WILLISCH = {

  /* --- WhatsApp: solo dígitos, con indicativo de país (57) --- */
  WHATSAPP_NUMBER: "573007525773",

  /* --- Datos de contacto --- */
  EMAIL: "gerencia@seguroswillisch.com",
  DIRECCION: "Calle 77 # 59-35, Edificio Américas III, Oficina 1403, Barranquilla",
  MAPS_URL: "https://share.google/LXEykav0mIWhdiPig",
  HORARIO: "Lunes a sábado, 8:00 a. m. – 6:00 p. m.",

  /* --- Horario de atención, para el mensaje del botón flotante --- */
  HORARIO_INICIO: 8,   // 8 a. m.
  HORARIO_FIN: 18,     // 6 p. m.
  DIAS_HABILES: [1, 2, 3, 4, 5, 6], // lunes(1) a sábado(6)

  /* --- Redes sociales: deja "" en las que no existan y desaparecen solas --- */
  INSTAGRAM: "https://www.instagram.com/seguroswillisch/",
  FACEBOOK: "",
  LINKEDIN: "",
  TIKTOK: "",

  /* --- Perfil de Empresa de Google (para la sección de reseñas) --- */
  GOOGLE_PERFIL_URL: "https://share.google/LXEykav0mIWhdiPig",
  GOOGLE_ESCRIBIR_RESENA_URL: "",

  /* --- Mensaje por defecto de WhatsApp --- */
  MSG_DEFECTO: "Hola Seguros Willisch, quiero asesoría para cotizar un seguro."
};

/* Construye el enlace de WhatsApp con el mensaje ya escrito. */
window.waLink = function (mensaje) {
  var cfg = window.WILLISCH;
  var texto = mensaje || cfg.MSG_DEFECTO;
  return "https://wa.me/" + cfg.WHATSAPP_NUMBER + "?text=" + encodeURIComponent(texto);
};
