# =========================================================
#  SEGUROS WILLISCH — CATÁLOGO DE PRODUCTOS
#  Este archivo alimenta al generador (_generador/generar.pl).
#  Cada entrada produce una subpágina en /seguros/<slug>/.
#
#  Para cambiar un texto: edítalo aquí y vuelve a correr el generador.
#  Para cambiar solo una página suelta, también puedes editar
#  directamente su index.html; es HTML normal.
# =========================================================
use utf8;

our @CATEGORIAS = (
  { id => "movilidad",  nombre => "Movilidad" },
  { id => "salud",      nombre => "Salud" },
  { id => "vida",       nombre => "Vida" },
  { id => "hogar",      nombre => "Hogar" },
  { id => "colectivos", nombre => "Colectivos y grupos" },
  { id => "empresas",   nombre => "Empresas" },
);

our @PRODUCTOS = (

# ---------------------------------------------------------------- MOVILIDAD
{
  slug => "auto", cat => "movilidad", menu => "Seguro de Autos",
  nombre => "Seguro todo riesgo para tu carro",
  titulo => "Seguro de autos todo riesgo | Seguros Willisch",
  meta => "Compara el todo riesgo de tu carro entre las principales aseguradoras de Colombia. Te explicamos deducibles, asistencias y el valor asegurado sin letra pequeña.",
  kicker => "Movilidad",
  h1 => "Tu carro protegido, y tú sin sustos en la vía.",
  lead => "El todo riesgo no es solo para cuando se roban el carro. Cubre los daños que causes a otros, los golpes del día a día y te deja moverte mientras el taller responde. Comparamos las opciones y te decimos cuál conviene a tu caso.",
  coberturas => [
    ["Responsabilidad civil", "Responde por los daños y lesiones que le causes a terceros. Es la cobertura que evita que un accidente se vuelva una deuda de años."],
    ["Pérdida total y parcial", "Por daños o por hurto. La parcial cubre los golpes reparables; la total entra cuando el arreglo supera el porcentaje que fija la póliza."],
    ["Asistencia en vía", "Grúa, cambio de llanta, paso de corriente y conductor elegido, según el plan que elijas."],
    ["Carro de reemplazo", "Un vehículo mientras el tuyo está en el taller, por el número de días que contrate tu plan."],
  ],
  incluye => [
    "Comparamos el valor asegurado real de tu vehículo, no el que más le convenga a la aseguradora.",
    "Te explicamos cada deducible antes de firmar: cuánto pones tú si pasa algo.",
    "Talleres autorizados y la diferencia entre repuesto original y homologado.",
    "Acompañamiento el día del siniestro: te decimos qué documentar en el sitio.",
  ],
  faq => [
    ["¿El todo riesgo reemplaza al SOAT?", "No. El SOAT es obligatorio y cubre las lesiones de las personas involucradas en un accidente. El todo riesgo es voluntario y cubre tu vehículo y los daños que causes a terceros. Se complementan."],
    ["¿Qué es el deducible?", "Es la parte del daño que asumes tú cuando usas la póliza. A mayor deducible, menor prima; a menor deducible, mayor prima. Te mostramos las dos cuentas para que decidas."],
    ["¿Puedo asegurar un carro con varios años de uso?", "Sí. Cada aseguradora maneja su propio límite de antigüedad y su forma de calcular el valor asegurado. Revisamos cuáles aceptan tu vehículo y en qué condiciones."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar el todo riesgo de mi carro.",
  imgs => [ ["auto-hero", "16/10", "Carro particular en carretera, luz de tarde"],
            ["auto-detalle", "4/3", "Conductor revisando su carro con tranquilidad"] ],
  relacionados => ["moto","soat","taxi"],
},

{
  slug => "moto", cat => "movilidad", menu => "Seguro de Motos",
  nombre => "Seguro para tu moto",
  titulo => "Seguro para motos en Colombia | Seguros Willisch",
  meta => "Todo riesgo y responsabilidad civil para tu moto. Comparamos coberturas de hurto, daños a terceros y asistencia en vía entre varias aseguradoras.",
  kicker => "Movilidad",
  h1 => "La moto es tu trabajo y tu libertad. Que un golpe no te la quite.",
  lead => "En moto el riesgo no es el mismo que en carro: el hurto pesa más y las lesiones son más graves. Buscamos la póliza que de verdad responda por tu caso y por tu cilindraje.",
  coberturas => [
    ["Hurto total", "La cobertura que más se usa en moto. Te explicamos qué exige cada aseguradora en materia de seguridad y parqueadero."],
    ["Responsabilidad civil", "Daños y lesiones que le causes a otra persona. En moto es la que más rápido se agradece."],
    ["Daños parciales", "Los golpes reparables, con el deducible que acuerdes."],
    ["Asistencia y grúa", "Traslado de la moto y auxilio en vía según el plan."],
  ],
  incluye => [
    "Revisamos si tu cilindraje y tu uso (particular o trabajo) entran en cada plan.",
    "Comparamos el costo real del hurto total entre aseguradoras.",
    "Te decimos qué exige la póliza sobre parqueadero y dispositivos de seguridad.",
    "Trámite del SOAT en el mismo proceso, si lo necesitas.",
  ],
  faq => [
    ["¿Aseguran motos usadas para domicilios o trabajo?", "Depende de la aseguradora. El uso comercial cambia la tarifa y algunas lo excluyen. Dinos para qué la usas y te decimos cuáles la aceptan."],
    ["¿Cubre si me roban la moto en la calle?", "El hurto total sí, siempre que cumplas las condiciones de la póliza. Esas condiciones varían mucho entre aseguradoras y te las explicamos antes de firmar."],
    ["¿Necesito el SOAT además del seguro?", "Sí. El SOAT es obligatorio para circular; el seguro voluntario es adicional y cubre lo que el SOAT no."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar el seguro de mi moto.",
  imgs => [ ["moto-hero", "16/10", "Motociclista con equipo de protección"],
            ["moto-detalle", "4/3", "Moto parqueada, detalle de casco"] ],
  relacionados => ["auto","soat","accidentes-personales"],
},

{
  slug => "bicicleta-patineta", cat => "movilidad", menu => "Seguro de Bicis y Patinetas",
  nombre => "Seguro para bicicletas y patinetas eléctricas",
  titulo => "Seguro para bicicletas y patinetas eléctricas | Seguros Willisch",
  meta => "Protege tu bicicleta o patineta eléctrica contra hurto y daños, con responsabilidad civil y accidentes personales para quien la conduce.",
  kicker => "Movilidad",
  h1 => "Te mueves en bici o en patineta. También necesitas respaldo.",
  lead => "Una bicicleta buena cuesta como una moto, y una patineta eléctrica también. Existen pólizas pensadas para este tipo de movilidad, con hurto, daños y responsabilidad civil.",
  coberturas => [
    ["Hurto", "Cobertura del vehículo cuando te lo roban, según las condiciones de custodia que exija la póliza."],
    ["Daños accidentales", "Golpes y caídas que afecten el marco, la batería o los componentes."],
    ["Responsabilidad civil", "Si atropellas a alguien o dañas un bien ajeno mientras te movilizas."],
    ["Accidentes personales", "Gastos médicos e indemnización por lesiones del conductor."],
  ],
  incluye => [
    "Valoración del equipo con factura o avalúo, para que quede bien asegurado.",
    "Te explicamos qué exige la póliza sobre guayas, candados y parqueo.",
    "Opciones para uso urbano diario y para uso deportivo o de competencia.",
    "Alternativas si lo que quieres es sumarlo a tu póliza de hogar.",
  ],
  faq => [
    ["¿Sirve para patinetas eléctricas de cualquier potencia?", "No todas. Algunas aseguradoras ponen límite de velocidad o de potencia. Mándanos los datos del equipo y revisamos cuáles la aceptan."],
    ["¿Cubre si me la roban del parqueadero del edificio?", "Suele cubrir, siempre que cumplas las condiciones de aseguramiento que exige la póliza. Te las explicamos antes de firmar."],
    ["¿Puedo asegurarla dentro del seguro de hogar?", "En algunos casos sí, como contenido. Comparamos las dos rutas y te decimos cuál sale mejor."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro para mi bicicleta o patineta eléctrica.",
  imgs => [ ["bici-hero", "16/10", "Ciclista urbano en la ciudad"],
            ["bici-detalle", "4/3", "Patineta eléctrica y casco"] ],
  relacionados => ["auto","accidentes-personales","hogar"],
},

{
  slug => "taxi", cat => "movilidad", menu => "Seguro para Taxis",
  nombre => "Seguro para taxis y vehículos de servicio público",
  titulo => "Seguro para taxis y servicio público | Seguros Willisch",
  meta => "Pólizas para taxis y vehículos de servicio público: responsabilidad civil, daños, hurto y las coberturas que exige la operación.",
  kicker => "Movilidad",
  h1 => "El taxi es tu negocio. Si para, paras tú.",
  lead => "El servicio público tiene condiciones propias: más horas en la vía, más pasajeros y exigencias distintas. Buscamos la póliza que te mantenga trabajando.",
  coberturas => [
    ["Responsabilidad civil", "Daños y lesiones a terceros y a los pasajeros que transportas."],
    ["Pérdida total y parcial", "Por daños y por hurto, con el valor asegurado que corresponda al vehículo."],
    ["Asistencia en vía", "Grúa y auxilio, pensados para que vuelvas a rodar rápido."],
    ["Accidentes del conductor", "Gastos médicos e indemnización por lesiones de quien conduce."],
  ],
  incluye => [
    "Revisamos las exigencias de tu empresa afiliadora antes de cotizar.",
    "Opciones por vehículo o para varios taxis bajo un mismo contrato.",
    "Te explicamos cómo se maneja el conductor adicional o el turno.",
    "Acompañamiento en la reclamación para minimizar los días parado.",
  ],
  faq => [
    ["¿Sirve la misma póliza de un carro particular?", "No. El uso de servicio público cambia el riesgo y la tarifa; una póliza de particular puede quedar sin efecto si el vehículo se usa como taxi."],
    ["¿Cubre a los pasajeros?", "La responsabilidad civil responde por lesiones a terceros, incluidos los pasajeros, hasta los límites contratados."],
    ["¿Puedo asegurar varios taxis juntos?", "Sí. Si tienes varios vehículos conviene mirar una póliza de flota; suele salir mejor que asegurarlos uno por uno."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar el seguro de mi taxi.",
  imgs => [ ["taxi-hero", "16/10", "Taxi en la ciudad, jornada de trabajo"] ],
  relacionados => ["auto","flotas-camiones","soat"],
},

{
  slug => "utilitarios-pesados", cat => "movilidad", menu => "Utilitarios y Pesados",
  nombre => "Seguro para utilitarios y vehículos pesados",
  titulo => "Seguro para camionetas, camiones y vehículos pesados | Seguros Willisch",
  meta => "Pólizas para camionetas de trabajo, vans, camiones y volquetas: responsabilidad civil, pérdida total y parcial, asistencia y cobertura de la carga propia.",
  kicker => "Movilidad",
  h1 => "El vehículo que carga tu trabajo necesita otra póliza.",
  lead => "Una camioneta de trabajo, una van o un camión no se aseguran como un carro particular: pesan más, cargan más y responden por más. Buscamos la póliza que corresponda al uso real del vehículo.",
  coberturas => [
    ["Responsabilidad civil ampliada", "Límites más altos, acordes al daño que puede causar un vehículo pesado."],
    ["Pérdida total y parcial", "Por daños y por hurto, con el valor asegurado del vehículo y de sus equipos fijos."],
    ["Carga propia", "La mercancía que transportas por tu cuenta, si se contrata la extensión."],
    ["Asistencia para pesados", "Grúa con capacidad para el peso del vehículo, no la de un carro particular."],
  ],
  incluye => [
    "Revisamos el uso real: trabajo propio, carga de terceros o servicio especial.",
    "Te decimos si te conviene una póliza individual o entrar a una de flota.",
    "Cobertura de equipos fijos: furgón, carrocería, grúa, tanque o refrigeración.",
    "Acompañamiento en la reclamación para que el vehículo vuelva a rodar rápido.",
  ],
  faq => [
    ["¿Me sirve la póliza de un carro particular?", "No. Si el vehículo se usa para trabajo o carga, una póliza de particular puede quedar sin efecto justo cuando la necesitas. El uso hay que declararlo."],
    ["¿Cubre la mercancía que llevo?", "La carga propia se cubre con una extensión. Si transportas mercancía de terceros, lo que aplica es la póliza de transporte de mercancías."],
    ["¿Desde qué tonelaje entra como pesado?", "Cada aseguradora lo define distinto. Mándanos la tarjeta de propiedad y te decimos en qué categoría cae tu vehículo."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar el seguro de mi camioneta o vehículo de carga.",
  imgs => [ ["pesados-hero", "16/10", "Camioneta de trabajo o camión cargando"] ],
  relacionados => ["auto","flotas-camiones","transporte-mercancias"],
},

{
  slug => "soat", cat => "movilidad", menu => "SOAT",
  nombre => "SOAT",
  titulo => "SOAT: expedición y renovación | Seguros Willisch",
  meta => "Expedimos y renovamos tu SOAT para carro, moto y vehículos de servicio público. Te decimos qué cubre y qué no antes de que lo necesites.",
  kicker => "Movilidad",
  h1 => "El SOAT es obligatorio. Que además te sirva cuando lo necesites.",
  lead => "Todo vehículo que circule en Colombia debe tener SOAT vigente. Te lo expedimos y, sobre todo, te explicamos qué cubre de verdad, porque casi nadie lo sabe hasta el día del accidente.",
  coberturas => [
    ["Gastos médicos", "Atención de las personas lesionadas en un accidente de tránsito, hasta el tope que fija la ley."],
    ["Incapacidad permanente", "Indemnización para la víctima que queda con una incapacidad derivada del accidente."],
    ["Muerte y gastos funerarios", "Indemnización a los beneficiarios de la víctima."],
    ["Transporte de las víctimas", "Traslado de los lesionados hasta el centro asistencial."],
  ],
  incluye => [
    "Expedición y renovación para carro, moto, taxi y vehículos de carga.",
    "Te avisamos antes de que se venza, para que no te multen.",
    "Te explicamos la diferencia entre lo que cubre el SOAT y lo que cubre el todo riesgo.",
    "Trámite por WhatsApp: nos mandas la tarjeta de propiedad y lo resolvemos.",
  ],
  faq => [
    ["¿El SOAT cubre los daños de mi carro?", "No. El SOAT cubre exclusivamente a las personas lesionadas en el accidente. Los daños del vehículo los cubre el todo riesgo."],
    ["¿Qué pasa si circulo sin SOAT?", "Es una infracción de tránsito: hay multa e inmovilización del vehículo, además de quedar expuesto económicamente si hay un accidente."],
    ["¿Qué necesito para expedirlo?", "La tarjeta de propiedad del vehículo y los datos del propietario. Nos los mandas por WhatsApp y te lo expedimos."],
  ],
  wa => "Hola Seguros Willisch, quiero expedir o renovar mi SOAT.",
  imgs => [ ["soat-hero", "16/10", "Tarjeta de propiedad y llaves sobre una mesa"] ],
  relacionados => ["auto","moto","taxi"],
},

# ---------------------------------------------------------------- SALUD
{
  slug => "salud", cat => "salud", menu => "Póliza de Salud",
  nombre => "Póliza de salud",
  titulo => "Póliza de salud: cobertura y comparación | Seguros Willisch",
  meta => "Comparamos pólizas de salud entre las principales aseguradoras: red de clínicas, tiempos de espera, preexistencias y lo que realmente cubre cada plan.",
  kicker => "Salud",
  h1 => "Tu salud no se improvisa.",
  lead => "Una póliza de salud te da acceso directo a clínicas y especialistas sin pasar por la fila de la EPS. No todas cubren lo mismo ni aceptan lo mismo: eso es exactamente lo que comparamos por ti.",
  coberturas => [
    ["Consulta con especialista", "Acceso directo, sin remisión previa, dentro de la red de la aseguradora."],
    ["Hospitalización y cirugía", "Habitación, procedimientos y honorarios según el plan contratado."],
    ["Exámenes y diagnóstico", "Laboratorio e imágenes con los tiempos y la red de cada aseguradora."],
    ["Urgencias", "Atención en la red de clínicas del plan, en el país y, según el plan, fuera de él."],
  ],
  incluye => [
    "Comparamos la red de clínicas de cada aseguradora, que es lo que más pesa en el día a día.",
    "Te explicamos los periodos de carencia: qué puedes usar desde el primer día y qué no.",
    "Revisamos cómo trata cada aseguradora tus preexistencias antes de que firmes.",
    "Opciones individuales, para pareja y para familia.",
  ],
  faq => [
    ["¿La póliza de salud reemplaza a la EPS?", "No. La EPS sigue siendo obligatoria. La póliza es complementaria: te da acceso más rápido y a una red distinta."],
    ["¿Qué es una preexistencia?", "Una condición de salud que ya tenías antes de tomar la póliza. Cada aseguradora la trata distinto: algunas la excluyen, otras la cubren tras un periodo. Lo revisamos caso por caso."],
    ["¿Cuál es la diferencia con la medicina prepagada?", "Se parecen mucho. En general la prepagada tiene red propia y copagos más bajos; la póliza de salud suele dar más libertad de elección. Te mostramos las dos cuentas."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar una póliza de salud.",
  imgs => [ ["salud-hero", "16/10", "Consulta médica tranquila"],
            ["salud-detalle", "4/3", "Sala de espera de clínica moderna"] ],
  relacionados => ["medicina-prepagada","plan-complementario","vida"],
},

{
  slug => "medicina-prepagada", cat => "salud", menu => "Medicina Prepagada",
  nombre => "Medicina prepagada",
  titulo => "Medicina prepagada: planes y comparación | Seguros Willisch",
  meta => "Planes de medicina prepagada comparados: red propia, copagos, tiempos de espera y cobertura familiar.",
  kicker => "Salud",
  h1 => "Atención cuando la necesitas, no cuando haya cupo.",
  lead => "La medicina prepagada trabaja con red propia y tiempos de atención cortos. Es la opción de quien quiere resolver rápido y con el mismo médico de siempre.",
  coberturas => [
    ["Red propia de atención", "Centros médicos y especialistas de la entidad, con agenda preferente."],
    ["Consulta y urgencias", "Atención ambulatoria y de urgencias dentro de la red del plan."],
    ["Hospitalización y cirugía", "Según el nivel de plan que contrates."],
    ["Programas de prevención", "Chequeos y programas de control incluidos en varios planes."],
  ],
  incluye => [
    "Comparamos copagos reales: es donde más se siente la diferencia entre planes.",
    "Revisamos si tus médicos de confianza están en la red antes de que firmes.",
    "Planes individuales y familiares, con el detalle de qué cambia al sumar personas.",
    "Te explicamos los periodos de espera de cada entidad.",
  ],
  faq => [
    ["¿También necesito EPS?", "Sí. La medicina prepagada es complementaria; la afiliación a la EPS sigue siendo obligatoria."],
    ["¿Puedo pasar de una prepagada a otra sin perder antigüedad?", "Algunas entidades reconocen la antigüedad para efectos de periodos de espera. Lo revisamos antes de mover nada."],
    ["¿Cubre a mis papás?", "Depende de la edad de ingreso que maneje cada entidad. Dinos las edades y te decimos qué opciones hay."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar medicina prepagada.",
  imgs => [ ["prepagada-hero", "16/10", "Médico y paciente en consultorio"] ],
  relacionados => ["salud","plan-complementario","accidentes-personales"],
},

{
  slug => "plan-complementario", cat => "salud", menu => "Plan Complementario (PAC)",
  nombre => "Plan complementario de salud (PAC)",
  titulo => "Plan complementario de salud PAC | Seguros Willisch",
  meta => "El plan complementario mejora la atención de tu EPS a un costo menor que una póliza. Te explicamos qué cubre y para quién tiene sentido.",
  kicker => "Salud",
  h1 => "El punto medio entre la EPS y la póliza.",
  lead => "El plan complementario se apoya en tu EPS y mejora lo que más molesta: los tiempos, la habitación y el acceso al especialista. Cuesta menos que una póliza y para muchas familias es suficiente.",
  coberturas => [
    ["Consulta preferente", "Acceso más rápido a especialistas dentro de la red del plan."],
    ["Habitación individual", "Mejora las condiciones de hospitalización frente al plan básico."],
    ["Exámenes con agenda corta", "Laboratorio e imágenes con tiempos de espera menores."],
    ["Red ampliada", "Clínicas y centros adicionales a los de tu EPS."],
  ],
  incluye => [
    "Te decimos honestamente si te conviene el PAC o si vale la pena ir directo a una póliza.",
    "Comparamos el complementario de tu EPS actual con el de otras.",
    "Revisamos qué queda por fuera, que es lo que suele sorprender.",
    "Opciones individuales y para el grupo familiar.",
  ],
  faq => [
    ["¿Tengo que estar en una EPS específica?", "Sí. El plan complementario lo ofrece tu EPS y funciona sobre ella. Si cambias de EPS, cambia el plan."],
    ["¿Es lo mismo que una póliza de salud?", "No. El complementario se apoya en la red de la EPS; la póliza es independiente y suele dar más libertad, a mayor costo."],
    ["¿Cubre preexistencias?", "Depende del plan y de la entidad. Lo revisamos antes de que firmes."],
  ],
  wa => "Hola Seguros Willisch, quiero información sobre un plan complementario de salud.",
  imgs => [ ["pac-hero", "16/10", "Familia en sala de espera, ambiente tranquilo"] ],
  relacionados => ["salud","medicina-prepagada","vida"],
},

# ---------------------------------------------------------------- VIDA
{
  slug => "vida", cat => "vida", menu => "Seguro de Vida",
  nombre => "Seguro de vida",
  titulo => "Seguro de vida individual | Seguros Willisch",
  meta => "Un seguro de vida deja resuelto lo económico para quienes dependen de ti. Comparamos sumas aseguradas, coberturas por enfermedad grave e invalidez.",
  kicker => "Vida",
  h1 => "Que tu ausencia no sea también un problema de plata.",
  lead => "Nadie contrata un seguro de vida para sí mismo. Se contrata para que a quienes dependen de ti no se les caiga todo encima el mismo día. Te ayudamos a calcular cuánto necesitan de verdad.",
  coberturas => [
    ["Fallecimiento", "La suma asegurada se entrega a los beneficiarios que tú designes."],
    ["Invalidez total y permanente", "Anticipa la indemnización si quedas incapacitado para trabajar."],
    ["Enfermedades graves", "Pago anticipado ante diagnósticos como cáncer, infarto o ACV, según el plan."],
    ["Auxilio funerario", "Cubre los gastos inmediatos, que son los que más pesan los primeros días."],
  ],
  incluye => [
    "Calculamos contigo la suma asegurada: deudas, estudio de los hijos y meses de sostenimiento.",
    "Te explicamos las exclusiones reales, sin adornos.",
    "Comparamos exámenes médicos exigidos por cada aseguradora según tu edad y suma.",
    "Revisión de beneficiarios: es el error más común y el más caro.",
  ],
  faq => [
    ["¿Cuánta suma asegurada necesito?", "Una referencia común es entre 5 y 10 años de tus ingresos, ajustada por deudas y por la edad de tus hijos. Hacemos la cuenta contigo."],
    ["¿Me piden exámenes médicos?", "Depende de la edad y de la suma asegurada. Muchas pólizas se emiten solo con declaración de salud."],
    ["¿Puedo cambiar de beneficiarios después?", "Sí, cuando quieras, mientras la póliza esté vigente."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro de vida.",
  imgs => [ ["vida-hero", "16/10", "Familia reunida, varias generaciones"],
            ["vida-detalle", "4/3", "Padres e hijos en casa"] ],
  relacionados => ["vida-deudor","accidentes-personales","exequias"],
},

{
  slug => "vida-deudor", cat => "vida", menu => "Seguro de Vida Deudor",
  nombre => "Seguro de vida deudor",
  titulo => "Seguro de vida deudor para créditos | Seguros Willisch",
  meta => "El vida deudor paga tu crédito si faltas. Puedes elegir aseguradora: comparamos opciones que cumplan los requisitos del banco.",
  kicker => "Vida",
  h1 => "Si faltas, que la deuda no se herede.",
  lead => "Cuando tomas un crédito de vivienda o de vehículo, el banco exige un seguro de vida deudor. Lo que casi nadie sabe es que puedes elegir con qué aseguradora tomarlo.",
  coberturas => [
    ["Saldo insoluto", "La aseguradora paga al banco lo que quede de la deuda."],
    ["Invalidez total y permanente", "Cubre la deuda también si quedas incapacitado para trabajar."],
    ["Enfermedades graves", "Según el plan, anticipa el pago ante ciertos diagnósticos."],
    ["Cobertura conjunta", "Para créditos con dos deudores, cubre a ambos."],
  ],
  incluye => [
    "Revisamos los requisitos exactos que exige tu entidad financiera.",
    "Comparamos el costo frente al seguro que te ofrece el mismo banco.",
    "Te acompañamos en el trámite de endoso para que la entidad lo acepte.",
    "Recordatorio de renovación mientras dure el crédito.",
  ],
  faq => [
    ["¿Puedo elegir la aseguradora?", "Sí, siempre que cumpla los requisitos que exige la entidad que otorgó el crédito. Te ayudamos a compararlas."],
    ["¿Sirve el que me vendió el banco?", "Sirve, pero no siempre es el más económico. Vale la pena comparar antes de renovarlo automáticamente."],
    ["¿Qué pasa cuando termino de pagar el crédito?", "La póliza deja de tener objeto. Si quieres seguir protegido, conviene pasar a un seguro de vida individual."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro de vida deudor.",
  imgs => [ ["deudor-hero", "16/10", "Pareja joven con las llaves de su casa"] ],
  relacionados => ["vida","hogar","accidentes-personales"],
},

{
  slug => "accidentes-personales", cat => "vida", menu => "Seguro de Accidentes",
  nombre => "Seguro de accidentes personales",
  titulo => "Seguro de accidentes personales | Seguros Willisch",
  meta => "Cobertura de gastos médicos, incapacidad e indemnización por accidente. Una póliza sencilla y económica que resuelve mucho.",
  kicker => "Vida",
  h1 => "Lo que cubre el accidente que no viste venir.",
  lead => "Es una de las pólizas más económicas y de las que más se usan. Cubre gastos médicos, incapacidad y, en el peor de los casos, indemniza a tu familia. Sirve para personas, para equipos de trabajo y para grupos.",
  coberturas => [
    ["Gastos médicos por accidente", "Atención, exámenes y tratamiento derivados de un accidente."],
    ["Incapacidad temporal", "Renta diaria mientras no puedes trabajar."],
    ["Invalidez por accidente", "Indemnización por pérdida de capacidad, según la tabla de la póliza."],
    ["Muerte accidental", "Suma asegurada para los beneficiarios que designes."],
  ],
  incluye => [
    "Planes individuales y para grupos, con la misma cobertura y mejor tarifa.",
    "Te explicamos la diferencia entre accidente y enfermedad, que es la clave de esta póliza.",
    "Opciones con cobertura deportiva para quienes entrenan o compiten.",
    "Emisión rápida: para muchos planes basta con los datos básicos.",
  ],
  faq => [
    ["¿Cubre enfermedades?", "No. Esta póliza cubre exclusivamente lo que se origine en un accidente. Para enfermedad existen la póliza de salud y la prepagada."],
    ["¿Sirve para deportes?", "Hay planes con cobertura deportiva y otros que excluyen deportes de alto riesgo. Dinos qué practicas y te decimos cuál aplica."],
    ["¿Se puede contratar para un grupo?", "Sí, y suele ser bastante más económico. Es lo habitual en escuelas deportivas, colegios y empresas."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro de accidentes personales.",
  imgs => [ ["accidentes-hero", "16/10", "Persona activa, día cotidiano"] ],
  relacionados => ["vida","accidentes-colectivos","escuelas-deportivas"],
},

{
  slug => "exequias", cat => "vida", menu => "Seguro Exequial",
  nombre => "Seguro exequial",
  titulo => "Seguro exequial familiar | Seguros Willisch",
  meta => "Plan exequial que cubre el servicio funerario completo para ti y tu familia, sin que nadie tenga que resolver plata en el peor momento.",
  kicker => "Vida",
  h1 => "El día más difícil no debería empezar con una cuenta.",
  lead => "El plan exequial cubre el servicio completo y evita que la familia tenga que conseguir dinero de un momento a otro. Es de las coberturas más económicas y de las que más se agradecen.",
  coberturas => [
    ["Servicio funerario completo", "Traslado, preparación, sala de velación, cofre y destino final."],
    ["Cobertura familiar", "Un solo plan puede cubrir al titular, la pareja, los hijos y los padres."],
    ["Traslados", "Dentro del país y, según el plan, desde el exterior."],
    ["Trámites", "Acompañamiento en los trámites legales del momento."],
  ],
  incluye => [
    "Te explicamos a quiénes puedes incluir y hasta qué edad.",
    "Comparamos la red de funerarias en la ciudad donde vive cada miembro del grupo.",
    "Revisamos los periodos de carencia antes de que firmes.",
    "Planes individuales, familiares y colectivos.",
  ],
  faq => [
    ["¿Puedo incluir a mis papás?", "En la mayoría de planes sí, con un límite de edad de ingreso. Te decimos cuál aplica según sus edades."],
    ["¿Desde cuándo puedo usarlo?", "Casi todos los planes tienen un periodo de carencia para muerte natural; por accidente suele ser inmediato."],
    ["¿Funciona en otra ciudad?", "Sí, siempre que la funeraria tenga cobertura allí. Lo verificamos antes de contratar."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un plan exequial.",
  imgs => [ ["exequias-hero", "16/10", "Manos acompañando, ambiente sereno"] ],
  relacionados => ["vida","exequias-colectivas","accidentes-personales"],
},

# ---------------------------------------------------------------- HOGAR
{
  slug => "hogar", cat => "hogar", menu => "Seguro de Hogar",
  nombre => "Seguro de hogar",
  titulo => "Seguro de hogar: estructura y contenido | Seguros Willisch",
  meta => "Protege la estructura y el contenido de tu casa contra incendio, terremoto, hurto y daños por agua, con responsabilidad civil y asistencias.",
  kicker => "Hogar",
  h1 => "Tu casa es el patrimonio que más te costó.",
  lead => "Un seguro de hogar no es solo para el terremoto. Los siniestros más comunes son mucho más cotidianos: una inundación, un corto, un hurto. Te ayudamos a asegurar lo que de verdad tienes.",
  coberturas => [
    ["Incendio y terremoto", "La cobertura base de la estructura y del contenido."],
    ["Hurto", "Contenido de la vivienda, con las condiciones de cada aseguradora."],
    ["Daños por agua", "Filtraciones y rotura de tuberías, incluido el daño a vecinos."],
    ["Responsabilidad civil", "Si un daño de tu vivienda afecta a un tercero."],
  ],
  incluye => [
    "Te ayudamos a calcular el valor del contenido, que casi todo el mundo subestima.",
    "Comparamos las asistencias de plomería, cerrajería y electricidad incluidas.",
    "Opciones para vivienda propia, arrendada y para el apartamento en propiedad horizontal.",
    "Revisamos si tu crédito hipotecario ya exige una póliza y cómo se complementa.",
  ],
  faq => [
    ["¿Si vivo arrendado me sirve?", "Sí. Aseguras el contenido, que es tuyo, y la responsabilidad civil frente al propietario y los vecinos."],
    ["¿Cubre el celular y el computador?", "Suele haber una cobertura de equipos electrónicos, a veces con sublímite. Lo revisamos según lo que tengas."],
    ["¿Sirve la póliza que exige el banco?", "Esa cubre principalmente la estructura para proteger al banco. El contenido y la responsabilidad civil normalmente quedan por fuera."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro de hogar.",
  imgs => [ ["hogar-hero", "16/10", "Sala de una casa, luz natural"],
            ["hogar-detalle", "4/3", "Detalle doméstico cotidiano"] ],
  relacionados => ["arrendamiento","bicicleta-patineta","vida-deudor"],
},

{
  slug => "arrendamiento", cat => "hogar", cats => "hogar digitales", menu => "Seguro de Arrendamiento",
  nombre => "Seguro de arrendamiento",
  titulo => "Seguro de arrendamiento: canon garantizado | Seguros Willisch",
  meta => "Garantiza el pago del canon de tu inmueble arrendado, con cobertura de servicios públicos y acompañamiento jurídico. Cotiza en línea.",
  kicker => "Hogar · 100% digital",
  digital => "arrendamiento",
  h1 => "Arrienda tranquilo: el canon llega aunque el inquilino falle.",
  lead => "Si arriendas un inmueble, el riesgo no es el inquilino: es el mes que no paga y los meses que tarda la desocupación. Esta póliza cubre exactamente eso, y la cotizas en línea.",
  coberturas => [
    ["Canon de arrendamiento", "La aseguradora te paga el canon aunque el inquilino no pague."],
    ["Servicios públicos", "Cubre las facturas que quede debiendo el arrendatario."],
    ["Administración", "La cuota de administración pendiente, en propiedad horizontal."],
    ["Acompañamiento jurídico", "Gestión de cobro y proceso de restitución del inmueble."],
  ],
  incluye => [
    "Cotización y expedición en línea, sin intermediarios.",
    "Estudio del inquilino incluido en el proceso.",
    "Te explicamos qué exige la póliza del contrato de arrendamiento.",
    "Todo desde el celular o el computador, a cualquier hora.",
  ],
  faq => [
    ["¿Quién paga la póliza?", "Depende de lo que acuerden las partes. Puede asumirla el propietario o trasladarse al arrendatario dentro del contrato."],
    ["¿Cubre los daños del inmueble?", "El foco de esta póliza es el canon y los servicios. Los daños materiales se cubren con la póliza de hogar."],
    ["¿Sirve para local comercial?", "Sí, hay planes para vivienda y para comercio. En el cotizador eliges el que aplica a tu inmueble."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro de arrendamiento.",
  imgs => [ ["arrendamiento-hero", "16/10", "Llaves y contrato sobre una mesa"] ],
  relacionados => ["hogar","mascotas","viaje"],
},

{
  slug => "mascotas", cat => "hogar", cats => "hogar digitales", menu => "Seguro para Mascotas",
  nombre => "Seguro para mascotas",
  titulo => "Seguro para mascotas: salud veterinaria | Seguros Willisch",
  meta => "Consultas, urgencias, cirugías y responsabilidad civil para tu perro o gato. Cotiza y compra en línea en minutos.",
  kicker => "Hogar · 100% digital",
  digital => "mascotas",
  h1 => "Tu mascota también es familia.",
  lead => "Una urgencia veterinaria se paga completa y de contado. Este seguro cubre consultas, exámenes y cirugías, y lo compras en línea en minutos.",
  coberturas => [
    ["Consultas y urgencias", "Atención veterinaria dentro de la red del plan."],
    ["Cirugías y hospitalización", "Procedimientos cubiertos según el nivel del plan."],
    ["Responsabilidad civil", "Si tu mascota causa un daño o una lesión a un tercero."],
    ["Vacunas y prevención", "Plan preventivo incluido en varias opciones."],
  ],
  incluye => [
    "Cotización y compra en línea, sin papeleo.",
    "Planes para perros y gatos, con distintas edades de ingreso.",
    "Te explicamos las exclusiones por raza y por condición previa.",
    "Todo desde el celular o el computador, a cualquier hora.",
  ],
  faq => [
    ["¿Hay límite de edad?", "Sí, cada plan define una edad mínima y máxima de ingreso. En la cotización en línea lo verás de inmediato."],
    ["¿Cubre enfermedades que ya tiene?", "Las condiciones preexistentes suelen quedar excluidas. Conviene asegurar temprano."],
    ["¿Puedo usar mi veterinario de siempre?", "Depende de si está en la red del plan. Lo puedes revisar en el cotizador en línea antes de comprar."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro para mi mascota.",
  imgs => [ ["mascotas-hero", "16/10", "Perro o gato con su familia"] ],
  relacionados => ["hogar","arrendamiento","viaje"],
},

# ---------------------------------------------------------------- DIGITALES
{
  slug => "viaje", cat => "vida", menu => "Seguro de Viaje",
  nombre => "Seguro de viaje",
  titulo => "Seguro de viaje internacional y nacional | Seguros Willisch",
  meta => "Asistencia médica en el exterior, cancelación y equipaje. El seguro que te exigen para entrar a varios países, cotizado a la medida de tu viaje.",
  kicker => "100% digital",
  digital => "viaje",
  h1 => "Que el viaje se dañe es una cosa. Que además te cueste, otra.",
  lead => "Una urgencia médica fuera del país se paga en la moneda del país. Varios destinos exigen el seguro para dejarte entrar. Lo cotizas en línea según el destino, los días y quién viaja.",
  coberturas => [
    ["Asistencia médica en el exterior", "Atención por enfermedad o accidente durante el viaje, hasta el monto contratado."],
    ["Cancelación e interrupción", "Reembolso de lo no utilizado cuando el viaje se cancela por causa cubierta."],
    ["Equipaje", "Pérdida, demora o daño del equipaje facturado."],
    ["Asistencia 24/7", "Línea de atención en español durante todo el viaje."],
  ],
  incluye => [
    "Te decimos qué monto mínimo exige tu destino, si exige alguno.",
    "Planes por viaje o multiviaje anual, según cuánto te muevas.",
    "Opciones con cobertura para deportes y para adultos mayores.",
    "Emisión inmediata: te llega al correo.",
  ],
  faq => [
    ["¿Es obligatorio para viajar?", "Para algunos destinos sí; el espacio Schengen, por ejemplo, exige una cobertura mínima. En el cotizador en línea ves qué plan cumple con tu destino."],
    ["¿Cubre si me enfermo antes de viajar?", "La cobertura de cancelación puede aplicar si la causa está dentro de las cubiertas por la póliza. En el cotizador ves cuáles aplican a cada plan."],
    ["¿Sirve para viajes dentro de Colombia?", "Sí, hay planes nacionales con asistencia médica y equipaje."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro de viaje.",
  imgs => [ ["viaje-hero", "16/10", "Maleta y pasaporte, salida de viaje"] ],
  relacionados => ["mascotas","arrendamiento","accidentes-personales"],
},

# ---------------------------------------------------------------- COLECTIVOS
{
  slug => "vida-grupo", cat => "colectivos", menu => "Vida Grupo",
  nombre => "Seguro de vida grupo",
  titulo => "Seguro de vida grupo para empresas y colectivos | Seguros Willisch",
  meta => "Cobertura de vida para los integrantes de una empresa, fondo o asociación, con una sola póliza y mejor tarifa que la individual.",
  kicker => "Colectivos",
  h1 => "Una sola póliza para todo el grupo.",
  lead => "Cuando aseguras a varias personas bajo un mismo contrato, la tarifa baja y el trámite se simplifica. Es la fórmula habitual en empresas, fondos de empleados y asociaciones.",
  coberturas => [
    ["Fallecimiento", "Suma asegurada para los beneficiarios de cada integrante."],
    ["Invalidez total y permanente", "Indemnización por pérdida de capacidad laboral."],
    ["Enfermedades graves", "Anticipo del pago ante ciertos diagnósticos, según el plan."],
    ["Auxilio funerario", "Cubre los gastos inmediatos del grupo familiar."],
  ],
  incluye => [
    "Una sola póliza, un solo pago y un solo interlocutor.",
    "Sin exámenes médicos para la mayoría de integrantes, según la suma asegurada.",
    "Altas y bajas de personal durante la vigencia.",
    "Informe de la cobertura para que puedas comunicarla a tu equipo.",
  ],
  faq => [
    ["¿Cuántas personas se necesitan como mínimo?", "Depende de la aseguradora; suele empezar en grupos pequeños. Dinos cuántos son y te decimos qué opciones hay."],
    ["¿Todos quedan con la misma suma asegurada?", "Puede ser igual para todos o por escalas, por ejemplo según el salario. Las dos formas son posibles."],
    ["¿Qué pasa si alguien se retira?", "Se da de baja en la póliza y se ajusta la prima. Nosotros manejamos ese movimiento."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro de vida grupo.",
  imgs => [ ["vidagrupo-hero", "16/10", "Equipo de trabajo reunido"] ],
  relacionados => ["accidentes-colectivos","exequias-colectivas","todo-riesgo-empresarial"],
},

{
  slug => "escuelas-deportivas", cat => "colectivos", menu => "Escuelas Deportivas",
  nombre => "Seguro para escuelas deportivas",
  titulo => "Seguro para escuelas deportivas y clubes | Seguros Willisch",
  meta => "Accidentes personales para deportistas, entrenadores y torneos. La póliza que piden las ligas y que tranquiliza a los papás.",
  kicker => "Colectivos",
  h1 => "Que jueguen tranquilos.",
  lead => "Una lesión en entrenamiento o en torneo se atiende de inmediato y se paga de inmediato. Esta póliza cubre a deportistas, entrenadores y personal de apoyo, y suele ser requisito para inscribirse en ligas.",
  coberturas => [
    ["Gastos médicos por accidente", "Atención, exámenes y tratamiento derivados de la práctica deportiva."],
    ["Incapacidad e invalidez", "Indemnización según la tabla de la póliza."],
    ["Muerte accidental", "Suma asegurada para los beneficiarios."],
    ["Traslado y ambulancia", "Desde el escenario deportivo hasta el centro asistencial."],
  ],
  incluye => [
    "Cobertura de entrenamientos, partidos y desplazamientos a torneos.",
    "Certificado de la póliza para presentar ante ligas y federaciones.",
    "Altas y bajas de deportistas durante la temporada.",
    "Material para que la escuela pueda comunicarlo a las familias.",
  ],
  faq => [
    ["¿Cubre los torneos fuera de la ciudad?", "Sí, si se contrata con esa extensión. Dinos si viajan y lo incluimos."],
    ["¿Entra el cuerpo técnico?", "Sí. Entrenadores y personal de apoyo pueden ir en la misma póliza."],
    ["¿Sirve para deportes de contacto?", "Sí, aunque la tarifa cambia según la disciplina. Cuéntanos cuál practican."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar una póliza para una escuela deportiva.",
  imgs => [ ["escuelas-hero", "16/10", "Niños entrenando en una cancha"] ],
  relacionados => ["accidentes-colectivos","accidentes-personales","vida-grupo"],
},

{
  slug => "accidentes-colectivos", cat => "colectivos", menu => "Accidentes Colectivos",
  nombre => "Accidentes personales colectivos",
  titulo => "Accidentes personales colectivos para grupos | Seguros Willisch",
  meta => "Cobertura de accidentes para colegios, eventos, grupos de trabajo y asociaciones, bajo una sola póliza.",
  kicker => "Colectivos",
  h1 => "Un grupo, una póliza, todos cubiertos.",
  lead => "Colegios, eventos, brigadas, voluntariados y grupos de trabajo pueden asegurarse bajo un mismo contrato, con una tarifa mucho menor que la individual.",
  coberturas => [
    ["Gastos médicos por accidente", "Atención derivada de un accidente ocurrido en la actividad cubierta."],
    ["Incapacidad temporal", "Renta diaria mientras dure la incapacidad."],
    ["Invalidez y muerte accidental", "Indemnización según la tabla de la póliza."],
    ["Traslado", "Ambulancia y traslado al centro asistencial."],
  ],
  incluye => [
    "Cobertura por evento puntual o por vigencia anual.",
    "Listado de asegurados que puedes actualizar durante la vigencia.",
    "Certificado para presentar ante colegios, alcaldías u organizadores.",
    "Emisión rápida cuando el evento es en pocos días.",
  ],
  faq => [
    ["¿Sirve para un evento de un solo día?", "Sí. Hay pólizas por evento, que es lo habitual en carreras, festivales y jornadas."],
    ["¿Necesito los nombres de todos?", "Para algunos planes basta con el número de participantes; para otros se requiere el listado. Te decimos cuál aplica."],
    ["¿Cubre a los organizadores?", "Sí, si se incluyen en el listado o en el grupo asegurado."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar accidentes personales colectivos.",
  imgs => [ ["colectivos-hero", "16/10", "Grupo en una actividad organizada"] ],
  relacionados => ["escuelas-deportivas","vida-grupo","accidentes-personales"],
},

{
  slug => "exequias-colectivas", cat => "colectivos", menu => "Exequias Colectivas",
  nombre => "Exequias colectivas",
  titulo => "Plan exequial colectivo para grupos y fondos | Seguros Willisch",
  meta => "Plan exequial para los integrantes de un fondo, asociación o empresa y sus familias, con una sola administración.",
  kicker => "Colectivos",
  h1 => "El beneficio que más agradecen los afiliados.",
  lead => "Los fondos de empleados y las asociaciones lo saben: el plan exequial colectivo es de los beneficios más valorados y de los más económicos por persona.",
  coberturas => [
    ["Servicio funerario completo", "Para el afiliado y el grupo familiar que se incluya."],
    ["Cobertura del grupo familiar", "Pareja, hijos y padres, según el plan contratado."],
    ["Traslados", "Dentro del país y, según el plan, desde el exterior."],
    ["Acompañamiento en trámites", "Gestión de los trámites del momento."],
  ],
  incluye => [
    "Una sola administración para todo el grupo.",
    "Altas y bajas de afiliados durante la vigencia.",
    "Red de funerarias verificada en las ciudades donde vive el grupo.",
    "Material de comunicación para que los afiliados sepan cómo usarlo.",
  ],
  faq => [
    ["¿Cuántos afiliados se necesitan?", "Varía por entidad. Dinos el tamaño del grupo y te decimos qué opciones aplican."],
    ["¿Pueden entrar los padres de los afiliados?", "En la mayoría de planes sí, con un límite de edad de ingreso."],
    ["¿Hay periodo de carencia?", "Casi siempre, para muerte natural. Por accidente suele ser inmediato. Te lo detallamos antes de firmar."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un plan exequial colectivo.",
  imgs => [ ["exequias-col-hero", "16/10", "Reunión de un grupo o asociación"] ],
  relacionados => ["exequias","vida-grupo","accidentes-colectivos"],
},

{
  slug => "dano-material", cat => "colectivos", menu => "Póliza de Daño Material",
  nombre => "Póliza de daño material",
  titulo => "Póliza de daño material para bienes y equipos | Seguros Willisch",
  meta => "Cobertura de daño accidental para bienes, equipos y elementos de un grupo, una sede o una operación.",
  kicker => "Colectivos",
  h1 => "Los equipos del grupo también valen plata.",
  lead => "Sedes, salones, equipos de sonido, herramienta, computadores. Cuando el patrimonio del grupo está en bienes, esta es la póliza que responde por el daño accidental y por el hurto.",
  coberturas => [
    ["Daño accidental", "Golpes, caídas y daños súbitos e imprevistos a los bienes asegurados."],
    ["Incendio y eventos de la naturaleza", "Incendio, rayo, explosión y eventos de la naturaleza contratados."],
    ["Hurto", "Sustracción de los bienes, con las condiciones de la póliza."],
    ["Equipos electrónicos", "Cobertura específica para equipos de cómputo, sonido y comunicaciones."],
  ],
  incluye => [
    "Inventario y valoración de los bienes para asegurar por el valor correcto.",
    "Te explicamos la diferencia entre valor de reposición y valor real.",
    "Cobertura fija en sede o con movilidad, si los equipos se transportan.",
    "Acompañamiento en la reclamación con el soporte documental.",
  ],
  faq => [
    ["¿Qué pasa si aseguro por menos del valor real?", "Aplica el infraseguro: la aseguradora indemniza en proporción. Por eso insistimos en valorar bien el inventario."],
    ["¿Cubre los equipos fuera de la sede?", "Solo si se contrata la extensión de movilidad. Dinos si los mueven y lo incluimos."],
    ["¿Sirve para una sede arrendada?", "Sí. Aseguras los bienes que son tuyos, aunque el inmueble no lo sea."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar una póliza de daño material.",
  imgs => [ ["dano-hero", "16/10", "Equipos y bienes de una sede"] ],
  relacionados => ["todo-riesgo-empresarial","accidentes-colectivos","transporte-mercancias"],
},

# ---------------------------------------------------------------- EMPRESAS
{
  slug => "todo-riesgo-empresarial", cat => "empresas", menu => "Todo Riesgo Empresarial",
  nombre => "Todo Riesgo Empresarial",
  titulo => "Todo Riesgo Empresarial: patrimonio y operación | Seguros Willisch",
  meta => "Protege la infraestructura, la maquinaria, el inventario y la operación de tu empresa con una póliza a la medida del riesgo real.",
  kicker => "Empresas",
  h1 => "Tu empresa no puede parar.",
  lead => "El Todo Riesgo Empresarial cubre lo que sostiene la operación: la sede, la maquinaria, el inventario y lo que dejas de facturar si algo se detiene. Lo armamos a la medida de lo que realmente tienes.",
  coberturas => [
    ["Incendio y eventos de la naturaleza", "Estructura, maquinaria e inventario ante incendio, rayo, explosión y terremoto."],
    ["Hurto y sustracción", "Mercancía, equipos y dinero, con las condiciones contratadas."],
    ["Rotura de maquinaria y equipos", "Daño súbito e imprevisto de la maquinaria y de los equipos electrónicos."],
    ["Lucro cesante", "Lo que la empresa deja de percibir mientras se recupera de un siniestro cubierto."],
  ],
  incluye => [
    "Visita o levantamiento del riesgo antes de cotizar, para no asegurar de más ni de menos.",
    "Comparación entre varias aseguradoras con el mismo alcance, para que la cuenta sea justa.",
    "Te explicamos deducibles y sublímites, que es donde se define si la póliza sirve.",
    "Acompañamiento en la reclamación con el soporte documental que exige la aseguradora.",
  ],
  faq => [
    ["¿Sirve si arriendo la bodega?", "Sí. Aseguras el contenido, la maquinaria y la operación, aunque el inmueble sea de otro."],
    ["¿Qué es el lucro cesante?", "Es la cobertura que responde por lo que dejas de facturar mientras la operación está detenida por un siniestro cubierto."],
    ["¿Cuánto tarda la cotización?", "Depende del tamaño del riesgo. Con la información completa, normalmente pocos días hábiles."],
  ],
  wa => "Hola Seguros Willisch, quiero una propuesta de Todo Riesgo Empresarial.",
  imgs => [ ["empresarial-hero", "16/10", "Bodega o planta en operación"],
            ["empresarial-detalle", "4/3", "Detalle de maquinaria o inventario"] ],
  relacionados => ["responsabilidad-civil","transporte-mercancias","dano-material"],
},

{
  slug => "maquinaria-equipos", cat => "empresas", menu => "Maquinaria y Equipos",
  nombre => "Seguro de Maquinaria y Equipos",
  titulo => "Seguro de maquinaria amarilla y equipos | Seguros Willisch",
  meta => "Todo riesgo para retroexcavadoras, excavadoras, cargadores, montacargas y equipos de obra: daños, volcamiento, hurto y responsabilidad civil.",
  kicker => "Empresas",
  h1 => "Tu maquinaria trabaja. Nosotros la respaldamos.",
  lead => "Una retroexcavadora varada o robada detiene la obra y el contrato. Este seguro cubre la maquinaria amarilla y los equipos de tu empresa en la obra, en la bodega y en el traslado, para que un accidente no se convierta en una pérdida que no puedes asumir.",
  coberturas => [
    ["Daños accidentales en operación", "Volcamiento, choque, caída, hundimiento del terreno y otros daños súbitos mientras la máquina trabaja."],
    ["Hurto", "Hurto calificado de la máquina completa o de sus partes, en la obra o en la bodega."],
    ["Eventos de la naturaleza", "Incendio, rayo, inundación, avalancha y terremoto."],
    ["Responsabilidad civil", "Daños a terceros, a sus bienes o a redes de servicios públicos durante la operación."],
  ],
  incluye => [
    "Aseguramos máquinas nuevas y usadas: retroexcavadoras, excavadoras, cargadores, bulldozers, montacargas, grúas y equipos de obra.",
    "Una sola póliza para toda tu flota de maquinaria, o una máquina a la vez.",
    "Cobertura durante el traslado en cama baja entre obras, si la contratas.",
    "Acompañamiento en la reclamación, con el soporte técnico que pide la aseguradora.",
  ],
  faq => [
    ["¿Cubre la máquina si la alquilo a terceros?", "Sí, se puede. Cuéntanos cómo la operas, porque las condiciones cambian si la maneja tu operador o el de quien la alquila."],
    ["¿Qué necesito para cotizar?", "Marca, modelo, año, serie y valor comercial de cada máquina, y dónde trabaja normalmente."],
    ["¿Me sirve para cumplir un contrato de obra?", "Muchos contratos exigen asegurar la maquinaria y la responsabilidad civil. Revisamos lo que te piden y armamos la póliza para cumplirlo."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar el seguro de mi maquinaria.",
  imgs => [ ["maquinaria-hero", "16/10", "Maquinaria amarilla trabajando en obra"],
            ["maquinaria-detalle", "4/3", "Excavadora en un frente de trabajo"] ],
  relacionados => ["todo-riesgo-empresarial","responsabilidad-civil","flotas-camiones"],
},

{
  slug => "copropiedad", cat => "empresas", menu => "Todo Riesgo Copropiedad",
  nombre => "Todo Riesgo Copropiedad",
  titulo => "Seguro Todo Riesgo para copropiedades y edificios | Seguros Willisch",
  meta => "La póliza que exige la Ley 675 para los bienes comunes de tu conjunto o edificio, con cobertura todo riesgo, terremoto, equipos y hurto.",
  kicker => "Empresas",
  h1 => "La copropiedad respondió. Y tú también puedes responder.",
  lead => "La ley obliga a asegurar los bienes comunes contra incendio y terremoto. Nosotros vamos más allá: armamos una póliza todo riesgo que cubre la maquinaria, los equipos y la oficina de administración, y te la explicamos para que la asamblea la entienda.",
  coberturas => [
    ["Bienes comunes todo riesgo", "Cubre cualquier daño súbito e imprevisto que no esté expresamente excluido en la póliza."],
    ["Terremoto y eventos de la naturaleza", "Temblor, erupción volcánica y tsunami, como exige la Ley 675 de 2001."],
    ["Maquinaria y equipos", "Incluidos los daños eléctricos por cortocircuito o sobrevoltaje."],
    ["Hurto calificado", "De los bienes comunes, incluidos el dinero y los cheques de la administración."],
  ],
  incluye => [
    "Levantamiento del valor asegurable para que la copropiedad no quede infraasegurada.",
    "Te preparamos el resumen para presentar la póliza en asamblea.",
    "Comparamos entre varias aseguradoras con el mismo alcance, para que la cuenta sea justa.",
    "Acompañamiento en la reclamación con el soporte que exige la aseguradora.",
  ],
  faq => [
    ["¿Es obligatorio asegurar la copropiedad?", "Sí. La Ley 675 de 2001 obliga a asegurar los bienes comunes contra incendio y terremoto. La póliza todo riesgo cumple ese mínimo y cubre bastante más."],
    ["¿Cubre el apartamento de cada propietario?", "No. Esta póliza cubre los bienes comunes. Lo de cada apartamento se cubre con la póliza de hogar de cada propietario."],
    ["¿Qué pasa si aseguramos por menos del valor real?", "Aplica el infraseguro: la aseguradora indemniza en proporción. Por eso insistimos en hacer bien el levantamiento del valor."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar la póliza de mi copropiedad.",
  imgs => [ ["copropiedad-hero", "16/10", "Fachada de un conjunto residencial o edificio"] ],
  relacionados => ["todo-riesgo-empresarial","responsabilidad-civil","dano-material"],
},

{
  slug => "drones", cat => "empresas", menu => "Seguro de Drones",
  nombre => "Seguro de Drones",
  titulo => "Seguro para drones y operaciones RPAS | Seguros Willisch",
  meta => "Responsabilidad civil con el límite que exige la RAC 100, daños al dron, cámaras y sensores, y cobertura durante el traslado.",
  kicker => "Empresas",
  h1 => "Vuela tranquilo y cumple la norma.",
  lead => "Si operas un dron con fines comerciales, la Aerocivil te exige responsabilidad civil. Esta póliza cumple ese requisito y además cubre el equipo, que casi siempre vale más que el propio dron.",
  coberturas => [
    ["Responsabilidad civil", "Daños a terceros durante la operación, con el límite que exige la RAC 100 para las categorías específica y certificada."],
    ["Daños al dron", "Daño accidental del equipo durante la operación."],
    ["Cámaras y sensores", "El equipo que va montado: cámaras, sensores y transmisores."],
    ["Traslado", "Cobertura mientras llevas el dron al sitio de operación."],
  ],
  incluye => [
    "Revisamos tu categoría de operación antes de cotizar, para que el límite coincida con lo que exige la norma.",
    "Te decimos exactamente qué documentos necesitas para la expedición.",
    "Condiciones especiales si operas una flota de drones.",
    "Opción para uso no comercial, en categoría abierta.",
  ],
  faq => [
    ["¿Es obligatorio el seguro para volar un dron?", "Para operaciones comerciales sí: la RAC 100 exige responsabilidad civil con un límite según la categoría de la operación. Te confirmamos cuál aplica a tu caso."],
    ["¿Cubre la cámara?", "Sí. Cámaras, sensores y transmisores entran en la cobertura del equipo."],
    ["¿Cubre vuelos recreativos?", "Esta póliza está pensada para operación comercial. Para uso no comercial hay una opción en categoría abierta; cuéntanos tu caso y te asesoramos."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar el seguro de mi dron.",
  imgs => [ ["drones-hero", "16/10", "Dron profesional en operación"] ],
  relacionados => ["responsabilidad-civil","todo-riesgo-empresarial","transporte-mercancias"],
},

{
  slug => "responsabilidad-civil", cat => "empresas", menu => "Responsabilidad Civil",
  nombre => "Responsabilidad Civil Extracontractual",
  titulo => "Responsabilidad Civil Extracontractual (RCE) | Seguros Willisch",
  meta => "Cobertura por los daños que tu operación, tus productos o tus empleados le causen a terceros. Requisito frecuente en contratos y licitaciones.",
  kicker => "Empresas",
  h1 => "Responde por el daño sin que se lleve la empresa.",
  lead => "La RCE responde cuando tu operación le causa un daño a alguien que no es parte del contrato: un cliente, un vecino, un peatón. Es de las coberturas que más se exigen y de las que más se necesitan.",
  coberturas => [
    ["Predios, labores y operaciones", "Daños causados en tus instalaciones y durante tu actividad."],
    ["Responsabilidad patronal", "Daños y lesiones a tus propios trabajadores, complementando a la ARL."],
    ["Productos", "Daños causados por los productos que fabricas o comercializas."],
    ["Contratistas y subcontratistas", "Extensión a quienes trabajan para ti, si se contrata."],
  ],
  incluye => [
    "Revisamos el pliego o el contrato para que el amparo coincida con lo exigido.",
    "Te explicamos los límites por evento y por vigencia, que es lo que revisa el contratante.",
    "Opciones combinadas con Todo Riesgo Empresarial para no pagar dos veces lo mismo.",
    "Expedición rápida cuando el contrato ya tiene fecha.",
  ],
  faq => [
    ["¿Reemplaza a la ARL?", "No. La ARL cubre el riesgo laboral de tus empleados; la responsabilidad patronal de la RCE cubre lo que exceda de esa responsabilidad."],
    ["¿Me la van a exigir en una licitación?", "Con mucha frecuencia, junto con las pólizas de cumplimiento. Mándanos el pliego y te decimos exactamente qué piden."],
    ["¿Cubre a mis contratistas?", "Solo si se contrata esa extensión. Conviene revisarlo cuando parte de la operación está tercerizada."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar una póliza de Responsabilidad Civil Extracontractual.",
  imgs => [ ["rce-hero", "16/10", "Equipo de trabajo en obra o servicio"] ],
  relacionados => ["todo-riesgo-empresarial","transporte-mercancias","flotas-camiones"],
},

{
  slug => "transporte-mercancias", cat => "empresas", menu => "Transporte de Mercancías",
  nombre => "Transporte de mercancías",
  titulo => "Seguro de transporte de mercancías | Seguros Willisch",
  meta => "Cobertura de la carga desde el origen hasta el destino, por despacho o por vigencia anual, en transporte terrestre, aéreo y marítimo.",
  kicker => "Empresas",
  h1 => "La carga vale más que el flete.",
  lead => "Mientras la mercancía se mueve, el riesgo es de quien la despacha. Esta póliza cubre el daño y la pérdida durante el trayecto, por despacho puntual o por todos los despachos del año.",
  coberturas => [
    ["Daño y pérdida de la carga", "Durante el trayecto asegurado, según las condiciones contratadas."],
    ["Hurto y saqueo", "Sustracción total o parcial de la mercancía en ruta."],
    ["Eventos de la naturaleza", "Daños derivados de eventos de la naturaleza durante el transporte."],
    ["Cargue y descargue", "Daños ocurridos en las maniobras, si se contrata la extensión."],
  ],
  incluye => [
    "Póliza por despacho o automática anual, según tu volumen.",
    "Te explicamos la diferencia entre asegurar el valor de factura y el valor comercial.",
    "Cobertura para transporte terrestre, aéreo y marítimo.",
    "Acompañamiento en la reclamación con el soporte de la transportadora.",
  ],
  faq => [
    ["¿No responde la transportadora?", "Responde, pero hasta los límites que fija la ley y el contrato de transporte, que casi nunca alcanzan el valor real de la carga."],
    ["¿Sirve para importaciones?", "Sí. Hay coberturas específicas para el trayecto internacional y el tramo nacional."],
    ["¿Qué necesito para cotizar?", "El tipo de mercancía, los trayectos habituales y el valor promedio y anual despachado."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro de transporte de mercancías.",
  imgs => [ ["transporte-hero", "16/10", "Camión de carga en ruta"] ],
  relacionados => ["flotas-camiones","todo-riesgo-empresarial","responsabilidad-civil"],
},

{
  slug => "flotas-camiones", cat => "empresas", menu => "Flotas y Camiones",
  nombre => "Flotas y camiones",
  titulo => "Seguro para flotas de vehículos y camiones | Seguros Willisch",
  meta => "Una sola póliza para todo el parque automotor de tu empresa, con mejor tarifa y una administración centralizada.",
  kicker => "Empresas",
  h1 => "Todo el parque automotor, bajo un mismo contrato.",
  lead => "Asegurar los vehículos uno por uno cuesta más y se administra peor. Con una póliza de flota tienes una sola vigencia, una sola renovación y una tarifa por volumen.",
  coberturas => [
    ["Responsabilidad civil", "Daños y lesiones a terceros causados por cualquier vehículo de la flota."],
    ["Pérdida total y parcial", "Por daños y por hurto, para cada vehículo asegurado."],
    ["Asistencia en vía", "Grúa y auxilio para toda la flota."],
    ["Accidentes del conductor", "Gastos médicos e indemnización para quien conduce."],
  ],
  incluye => [
    "Altas y bajas de vehículos durante la vigencia, sin rehacer la póliza.",
    "Una sola renovación al año en lugar de una por vehículo.",
    "Informe del estado de la flota y de la siniestralidad.",
    "Atención directa cuando un vehículo queda fuera de servicio.",
  ],
  faq => [
    ["¿Desde cuántos vehículos aplica?", "Depende de la aseguradora, pero suele empezar en pocas unidades. Dinos cuántos tienes y lo revisamos."],
    ["¿Puedo mezclar carros y camiones?", "Sí. La flota puede incluir distintos tipos de vehículo, con tarifas diferenciadas."],
    ["¿Qué pasa si vendo un vehículo?", "Se da de baja y se ajusta la prima. Nosotros hacemos ese movimiento."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar el seguro de la flota de mi empresa.",
  imgs => [ ["flotas-hero", "16/10", "Parque automotor de una empresa"] ],
  relacionados => ["transporte-mercancias","taxi","todo-riesgo-empresarial"],
},

{
  slug => "energia-solar", cat => "empresas", menu => "Energía y Paneles Solares",
  nombre => "Energía y paneles solares",
  titulo => "Seguro para proyectos de energía y paneles solares | Seguros Willisch",
  meta => "Cobertura para instalaciones fotovoltaicas y proyectos de energía: montaje, daño material, rotura de maquinaria y lucro cesante.",
  kicker => "Empresas",
  h1 => "La inversión en energía se paga en años. Protégela desde el primer día.",
  lead => "Un proyecto solar es infraestructura expuesta al clima y a la operación. Existen coberturas específicas para el montaje y para la operación, y conviene tomarlas desde el inicio.",
  coberturas => [
    ["Todo riesgo de montaje", "Cubre la etapa de instalación del proyecto."],
    ["Daño material", "Paneles, inversores y estructura ante eventos de la naturaleza, incendio y daño accidental."],
    ["Rotura de maquinaria", "Daño súbito e imprevisto de los equipos del sistema."],
    ["Lucro cesante", "Lo que deja de generar el proyecto mientras está fuera de servicio."],
  ],
  incluye => [
    "Coordinación con el instalador para que la cobertura empiece en el momento correcto.",
    "Revisión de las garantías del fabricante para no duplicar coberturas.",
    "Opciones para instalación en cubierta, en piso y para granjas solares.",
    "Acompañamiento en la reclamación con el soporte técnico.",
  ],
  faq => [
    ["¿La garantía del fabricante no es suficiente?", "Cubre defectos del equipo, no granizo, vendaval, incendio ni hurto. Son cosas distintas y se complementan."],
    ["¿Se asegura durante la instalación?", "Sí, con el todo riesgo de montaje. Es la etapa de mayor exposición."],
    ["¿Aplica para instalaciones residenciales?", "Sí, aunque en vivienda suele resolverse dentro de la póliza de hogar. Te decimos cuál conviene."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar el seguro de un proyecto de energía solar.",
  imgs => [ ["energia-hero", "16/10", "Paneles solares en cubierta"] ],
  relacionados => ["todo-riesgo-empresarial","dano-material","cultivos-agro"],
},

{
  slug => "cultivos-agro", cat => "empresas", menu => "Cultivos y Agro",
  nombre => "Cultivos y agro",
  titulo => "Seguro agrícola para cultivos | Seguros Willisch",
  meta => "Cobertura de la cosecha frente a eventos climáticos y plagas, y de la maquinaria e infraestructura del campo.",
  kicker => "Empresas",
  h1 => "La cosecha depende del clima. La empresa, no.",
  lead => "Un evento climático puede llevarse el trabajo de todo un ciclo. El seguro agrícola cubre la inversión del cultivo y, si lo necesitas, también la maquinaria y la infraestructura de la finca.",
  coberturas => [
    ["Eventos climáticos", "Exceso o déficit de lluvia, vendaval, granizo y helada, según el cultivo."],
    ["Plagas y enfermedades", "Cobertura para los eventos fitosanitarios que admita la póliza."],
    ["Incendio", "Pérdida del cultivo por incendio."],
    ["Maquinaria e infraestructura", "Tractores, equipos de riego y construcciones de la finca."],
  ],
  incluye => [
    "Te decimos qué cultivos son asegurables y bajo qué condiciones.",
    "Revisamos si aplica algún incentivo al seguro agropecuario en tu caso.",
    "Cobertura de la inversión o del valor esperado de la cosecha, según el plan.",
    "Acompañamiento en el peritaje cuando ocurre el evento.",
  ],
  faq => [
    ["¿Todos los cultivos son asegurables?", "No todos. Depende del cultivo, de la zona y del historial. Cuéntanos qué siembras y dónde, y lo revisamos."],
    ["¿Cubre la sequía?", "Varias pólizas cubren déficit de lluvia. Depende del cultivo y del esquema contratado."],
    ["¿Hay apoyo del Estado?", "Existen incentivos al seguro agropecuario. Revisamos si tu caso aplica antes de cotizar."],
  ],
  wa => "Hola Seguros Willisch, quiero cotizar un seguro agrícola para mi cultivo.",
  imgs => [ ["cultivos-hero", "16/10", "Cultivo extenso, jornada de campo"] ],
  relacionados => ["energia-solar","todo-riesgo-empresarial","transporte-mercancias"],
},

);

# Palabras con las que la gente busca cada producto en el buscador del inicio.
# Se suman al nombre del producto. Añade aquí los sinónimos que se te ocurran:
# el buscador compara por inicio de palabra, así que "carro" encuentra "carros".
our %CLAVES = (
  "auto"                    => "carro carros vehiculo automovil todo riesgo particular",
  "moto"                    => "motos motocicleta scooter dos ruedas",
  "bicicleta-patineta"      => "bici bicicletas patineta patinetas electrica scooter ciclista",
  "taxi"                    => "taxis servicio publico amarillo",
  "utilitarios-pesados"     => "camioneta camion van furgon volqueta pesado carga utilitario pickup",
  "soat"                    => "obligatorio tramite renovacion transito",
  "salud"                   => "clinica medico especialista eps hospitalizacion",
  "medicina-prepagada"      => "prepagada colsanitas sanitas medisanitas red propia",
  "plan-complementario"     => "pac complementario eps habitacion",
  "vida"                    => "fallecimiento beneficiarios familia proteccion",
  "vida-deudor"             => "credito hipoteca banco deuda saldo",
  "accidentes-personales"   => "accidente gastos medicos incapacidad",
  "exequias"                => "funerario funeraria exequial velacion",
  "hogar"                   => "casa apartamento vivienda contenido terremoto incendio",
  "arrendamiento"           => "arriendo canon inmobiliaria inquilino arrendatario",
  "mascotas"                => "perro gato veterinario animal",
  "viaje"                   => "viajes viajero internacional asistencia equipaje schengen",
  "vida-grupo"              => "colectivo grupo empleados fondo asociacion",
  "escuelas-deportivas"     => "deporte club academia torneo futbol liga deportistas",
  "accidentes-colectivos"   => "colegios eventos grupos brigada voluntarios",
  "exequias-colectivas"     => "funerario colectivo fondo asociacion afiliados",
  "dano-material"           => "bienes equipos sede electronicos hurto",
  "todo-riesgo-empresarial" => "empresa pyme bodega maquinaria inventario lucro cesante",
  "maquinaria-equipos"      => "maquinaria amarilla retroexcavadora excavadora cargador bulldozer montacargas grua obra equipo pesado",
  "copropiedad"             => "conjunto edificio propiedad horizontal bienes comunes ley 675 administracion asamblea",
  "drones"                  => "dron drone rpas aerocivil rac100 vuelo piloto fotografia aerea",
  "responsabilidad-civil"   => "rce extracontractual terceros licitacion patronal",
  "transporte-mercancias"   => "carga despacho mercancia logistica importacion",
  "flotas-camiones"         => "flota camion parque automotor vehiculos empresa",
  "energia-solar"           => "paneles solares fotovoltaico energia montaje",
  "cultivos-agro"           => "agricola cosecha campo finca agro clima",
);
for my $p (@PRODUCTOS) { $p->{claves} = $CLAVES{$p->{slug}} if $CLAVES{$p->{slug}}; }


# =========================================================
#  PROPUESTA DE VALOR Y COTIZADOR POR PRODUCTO
#
#  frase       : la línea que encabeza la ficha del cotizador.
#  destacados  : los beneficios que se ven arriba, con check.
#  adicionales : tarjetas de "Lo que hace diferente este seguro".
#  ideal       : para quién es.
#  campos      : los dos datos que pide el formulario, además del nombre.
#                [ clave, etiqueta, tipo, ejemplo, opciones ]
#                tipo: texto | numero | fecha | lista
#  extra       : casilla opcional al final del formulario.
#  aviso       : nota de condiciones propia, si el producto la necesita.
#
#  Los productos que no estén aquí usan su propio texto: el generador
#  arma la ficha con su "lead" y sus coberturas.
# =========================================================
our %VALOR = (

"auto" => {
  frase => "Mucho más que un seguro: te acompañamos desde el choque hasta que tu carro vuelve a rodar.",
  destacados => [
    "Abogado y acompañamiento en el sitio del choque, con conciliación para evitarte audiencias y multas.",
    "Daños a terceros con límite por evento: si tienes otro accidente, el valor asegurado se recarga.",
    "Grúa de amplio alcance, taller móvil ilimitado y conductor elegido.",
    "Si tu carro es pérdida total, anticipo de hasta el 90%, según el plan, para que cambies de carro o pagues tu crédito.",
  ],
  adicionales => [
    ["Pequeños eventos, sin tocar tu póliza", "Retrovisores, emblemas y accesorios sin deducible; llantas estalladas sin deducible; golpes menores en bómper, capó o farolas con un deducible bajo. Disponible en algunos planes y ciudades."],
    ["Carro de reemplazo", "Un vehículo mientras reparan el tuyo, si contratas esa cobertura."],
    ["Si te varas de viaje", "Hotel hasta 3 noches o transporte para ti y tus pasajeros."],
    ["Revisión preventiva", "Revisión y asesoría de mecánico sin costo en centros de servicio y talleres aliados, según el plan y la ciudad."],
    ["Tu mascota, también", "Queda cubierta si se lesiona en un accidente dentro del carro."],
    ["Protección de tu patrimonio", "Pagamos los daños sin cobrarte después, aun si infringiste una norma de tránsito."],
    ["Reparación en el concesionario", "Opción de reparar en el taller de la marca de tu carro."],
    ["Reposición de llaves", "Si las pierdes o te las roban."],
  ],
  ideal => "Carros particulares, camionetas y pickups de uso personal.",
  campos => [
    ["placa", "Placa del vehículo", "texto", "ABC123"],
    ["ciudad", "Ciudad", "texto", "Pasto"],
  ],
},

"moto" => {
  frase => "Tu moto protegida en cada trayecto, y tú también.",
  destacados => [
    "Retrovisores, direccionales, farolas, stops y maniguetas cubiertos sin deducible y sin afectar tu póliza.",
    "Llanta estallada: te la reemplazamos sin deducible, y también rines y suspensión.",
    "Renta diaria si quedas hospitalizado por un accidente en tu moto, desde el tercer día y hasta 30 días al año.",
    "Grúa, taller móvil, abogado y conductor elegido.",
  ],
  adicionales => [
    ["Daños a terceros", "Responde por el daño que causes, con gastos de defensa judicial."],
    ["Daños y hurto de la moto", "Coberturas opcionales, según lo que necesites."],
    ["Conductor y pasajero", "Accidentes personales para los dos."],
  ],
  ideal => "Motos de trabajo o de uso personal.",
  aviso => "Los beneficios de accesorios pequeños y llantas aplican en algunos planes, sobre todo para motos de bajo cilindraje.",
  campos => [
    ["placa", "Placa de la moto", "texto", "ABC12D"],
    ["ciudad", "Ciudad", "texto", "Pasto"],
  ],
},

"salud" => {
  frase => "Atención médica sin filas, con especialistas y clínicas de primer nivel, para ti y tu familia.",
  destacados => [
    "Especialistas sin remisión de la EPS.",
    "Clínicas en convenio en todo el país.",
    "Te ayudamos a elegir el plan según tu edad y tu presupuesto.",
    "Comparamos los planes de varias aseguradoras antes de recomendarte uno.",
  ],
  adicionales => [
    ["Plan para dos", "Para compartir con una persona: consultas virtuales prioritarias ilimitadas con médico general —y con pediatra si compartes con un menor— todos los días; especialistas en medicina interna, ginecología, dermatología, ortopedia, oftalmología, urología, otorrino y nutrición; médico a domicilio y urgencias odontológicas en tu casa; psicología y psiquiatría incluidas."],
    ["Plan esencial", "Hospitalización y cirugías en habitación individual con cama de acompañante, UCI, maternidad, tratamiento de cáncer y leucemia, atención hospitalaria domiciliaria y asistencia en el exterior. Con anexos opcionales de urgencias ilimitadas y odontología."],
    ["Plan integral", "Todo lo del plan esencial, con opción de habitación suite, cobertura más amplia y asistencia en el exterior."],
    ["Plan premium internacional", "Telemedicina ilimitada en varias especialidades, cobertura en el exterior, maternidad también fuera del país, trasplantes, tratamiento del cáncer y enfermera o cuidador a domicilio."],
  ],
  ideal => "Personas y familias que quieren resolver rápido y elegir a su médico.",
  campos => [
    ["edad", "Tu edad", "numero", "38"],
    ["ciudad", "Ciudad", "texto", "Pasto"],
    ["personas", "¿Para cuántas personas?", "numero", "3"],
  ],
},

"vida" => {
  frase => "Protege a quienes dependen de ti, y úsalo también en vida.",
  destacados => [
    "Ambulancia sin límite de costo.",
    "Médico, enfermera y pediatra a domicilio.",
    "Orientación psicológica telefónica sin límite.",
    "Asistencia dental de emergencia y veterinario a domicilio por emergencia para tus mascotas.",
  ],
  adicionales => [
    ["Orientación telefónica", "Médica y nutricional, cuando la necesites."],
    ["A domicilio", "Exámenes de laboratorio y terapias físicas en tu casa."],
    ["Contratación 100% digital", "Sin desplazamientos ni papeleo."],
  ],
  ideal => "Quien tiene hijos, pareja o padres que dependen de su ingreso.",
  aviso => "Las asistencias cubren a tu grupo familiar que vive contigo, según el plan contratado.",
  campos => [
    ["edad", "Tu edad", "numero", "38"],
    ["ciudad", "Ciudad", "texto", "Pasto"],
  ],
},

"hogar" => {
  frase => "Tu casa y todo lo que hay en ella, protegidos frente a lo inesperado.",
  destacados => [
    "Incendio, terremoto, daños por agua, granizo y vientos fuertes.",
    "Hurto con violencia de tus bienes.",
    "Responsabilidad civil si causas daños a tus vecinos o a terceros.",
    "Si tienes que desalojar la casa para repararla, te cubrimos el arriendo o la pérdida de arrendamiento.",
  ],
  adicionales => [
    ["Vidrios", "Rotura accidental de vidrios."],
    ["Empleada del servicio", "Gastos médicos si sufre un accidente en tu casa."],
    ["Si quedas inválido", "Exoneración del pago de la prima antes de los 60 años."],
    ["Después del siniestro", "Remoción de escombros."],
  ],
  ideal => "Propietarios e inquilinos.",
  campos => [
    ["ciudad", "Ciudad", "texto", "Pasto"],
    ["vivienda", "Tipo de vivienda", "lista", "", ["Propia", "Arrendada"]],
  ],
},

"todo-riesgo-empresarial" => {
  frase => "Que un imprevisto no frene tu negocio.",
  destacados => [
    "Incendio, terremoto, inundación, actos vandálicos y daños internos a maquinaria y equipos.",
    "Robo de mercancía, equipos y bienes, incluso por parte de empleados.",
    "Pérdida de utilidad: hasta 3 meses de ingresos si el negocio tiene que parar, sin deducible.",
    "Daños a terceros.",
  ],
  adicionales => [
    ["Bienes nuevos, cubiertos solos", "Lo que compres durante la vigencia queda cubierto automáticamente, sin aumento de prima."],
    ["Equipos portátiles", "Cubiertos también fuera del local."],
    ["Pertenencias de tus empleados", "Daño y robo, sin aumento de prima."],
    ["Mercancía y dinero en tránsito", "Cubiertos durante el transporte."],
    ["Asistencia Pyme", "Plomero, electricista, cerrajero, gas y vidrios para tu local."],
    ["Vigilancia tras un siniestro", "Hasta 48 horas si el local queda inseguro."],
    ["Orientación profesional", "Jurídica, laboral, tributaria y de importaciones, por teléfono."],
    ["Apoyo administrativo", "Revisión de contratos y documentos legales, y soporte informático remoto."],
  ],
  ideal => "Comercios, restaurantes, oficinas, talleres y pymes en general.",
  campos => [
    ["negocio", "Tipo de negocio", "texto", "Restaurante"],
    ["ciudad", "Ciudad", "texto", "Pasto"],
  ],
},

"utilitarios-pesados" => {
  frase => "Tu flota siempre en movimiento.",
  destacados => [
    "Grúa de amplio alcance, taller móvil y cerrajería.",
    "Envío de repuestos y desplazamiento del mecánico si el vehículo se vara lejos.",
    "Hotel o transporte para el conductor si el vehículo no se puede reparar el mismo día.",
    "Atención integral en el sitio del choque y protección del patrimonio de tu empresa.",
  ],
  adicionales => [
    ["Revisión preventiva", "Revisión y asesoría de mecánico sin costo, 2 por vehículo al año, para utilitarios livianos de menos de 3.000 kg."],
    ["Daños a terceros", "Con límite por evento."],
    ["Si hay pérdida total", "Anticipo para que la operación no se detenga."],
  ],
  ideal => "Empresas con camionetas, furgones, camiones o flotas.",
  campos => [
    ["tipo", "Tipo de vehículo", "texto", "Furgón / camión / camioneta"],
    ["cuantos", "¿Cuántos vehículos?", "numero", "4"],
  ],
},

"copropiedad" => {
  frase => "Protección completa para tu conjunto o edificio, y tranquilidad para la administración.",
  gancho => "¿Tu copropiedad cumple con la póliza obligatoria? La Ley 675 de 2001 obliga a asegurar los bienes comunes contra incendio y terremoto.",
  destacados => [
    "Todo riesgo para zonas y bienes comunes: cualquier daño súbito e imprevisto que no esté expresamente excluido, incluidos incendio, rayo, explosión, daños por agua, inundación, granizo, vientos fuertes, impacto de vehículos, actos mal intencionados y terrorismo.",
    "Terremoto, temblor, erupción volcánica y tsunami, como exige la ley.",
    "Daños a la maquinaria y los equipos de la copropiedad, incluidos los daños eléctricos por cortocircuito o sobrevoltaje.",
    "Hurto calificado de los bienes comunes, incluidos el dinero y los cheques de la oficina de administración.",
  ],
  adicionales => [
    ["Después del siniestro", "Remoción de escombros."],
    ["Para reconstruir", "Honorarios de arquitectos, ingenieros e interventores."],
    ["Proteger y reponer", "Gastos para proteger los bienes y para reponer la información perdida."],
    ["Más bienes cubiertos", "Bienes de los empleados, bienes a la intemperie, traslados temporales y construcciones nuevas."],
    ["Equipos de la administración", "Equipos móviles y portátiles, y hurto simple de los equipos electrónicos de la oficina."],
  ],
  complementa => [
    "Responsabilidad civil frente a terceros.",
    "Responsabilidad civil para administradores y consejo de administración.",
    "Manejo, ante pérdidas causadas por empleados.",
    "Cuotas de administración.",
    "Transporte de valores.",
    "Asistencia para copropiedades.",
  ],
  ideal => "Conjuntos residenciales, edificios, centros comerciales y administradores de propiedad horizontal.",
  campos => [
    ["conjunto", "Nombre del conjunto o edificio", "texto", "Conjunto Los Robles"],
    ["unidades", "Número de unidades", "numero", "120"],
  ],
  extra => "Soy administrador(a) de la copropiedad",
},

"maquinaria-equipos" => {
  frase => "Que una máquina varada no pare la obra.",
  destacados => [
    "Daños accidentales en operación: volcamiento, choque, caída y hundimiento del terreno.",
    "Hurto calificado de la máquina o de sus partes, en la obra o en la bodega.",
    "Incendio, inundación, avalancha, terremoto y demás eventos de la naturaleza.",
    "Responsabilidad civil por daños a terceros y a redes de servicios públicos.",
  ],
  adicionales => [
    ["Traslado entre obras", "Cobertura mientras la máquina viaja en cama baja, si la contratas."],
    ["Toda la flota en una póliza", "Una sola vigencia y un solo pago para todas tus máquinas."],
    ["Máquinas usadas", "También aseguramos equipos con años de trabajo, según su estado y valor comercial."],
  ],
  ideal => "Constructoras, contratistas de obra civil, minería, agroindustria, alquiladoras de maquinaria y dueños de una sola máquina.",
  campos => [
    ["maquina", "Tipo de máquina", "texto", "Retroexcavadora CAT 416"],
    ["ciudad", "Ciudad donde trabaja", "texto", "Pasto"],
  ],
},

"drones" => {
  frase => "Vuela tranquilo y cumple la norma de la Aerocivil.",
  destacados => [
    "Responsabilidad civil por daños a terceros durante la operación, con el límite que exige la norma RAC 100 para operaciones comerciales en las categorías específica y certificada.",
    "Daños accidentales al dron.",
    "Cámaras, sensores y transmisores cubiertos.",
    "Cobertura durante el traslado del dron al sitio de operación.",
  ],
  adicionales => [
    ["Privacidad y ruido", "Cobertura por invasión a la privacidad y por ruido, con sublímite."],
    ["Flotas de drones", "Condiciones especiales si operas varios equipos."],
    ["Uso no comercial", "Opción para la categoría abierta."],
  ],
  ideal => "Fotografía y video, agricultura y ganadería, topografía y cartografía, catastro, arquitectura, ingeniería e investigación.",
  tenAMano => [
    "El formulario diligenciado.",
    "Fotos del dron y de su número de serie.",
    "Cédula del piloto.",
  ],
  aviso => "No cubre actividades recreativas, deportivas, en interiores ni de seguridad. Si tu caso es otro, cuéntanoslo en el formulario y te asesoramos.",
  campos => [
    ["modelo", "Modelo del dron", "texto", "DJI Mavic 3"],
    ["uso", "¿Para qué lo usas?", "texto", "Fotografía, agricultura, topografía…"],
  ],
},

# Los tres que se compran en línea (mascotas, viaje, arrendamiento) no llevan
# formulario: su página manda directo al cotizador de la aseguradora.

);

# Vuelca la propuesta de valor sobre el catálogo.
for my $p (@PRODUCTOS) {
  my $v = $VALOR{$p->{slug}} or next;
  $p->{$_} = $v->{$_} for keys %$v;
}
# Los que no tienen formulario propio piden ciudad y una nota libre.
for my $p (@PRODUCTOS) {
  $p->{campos} ||= [
    ["ciudad", "Ciudad", "texto", "Pasto"],
    ["detalle", "Cuéntanos qué necesitas", "texto", "En una línea"],
  ];
}


# Productos que ya tienen su propia página y solo se enlazan desde el menú.
our @EXTERNOS = (
  { id => "cumplimiento", cat => "empresas", menu => "Pólizas de Cumplimiento", url => "cumplimiento/" },
  { id => "arl",          cat => "empresas", menu => "ARL",                     url => "arl/" },
);

# =========================================================
#  EL MENÚ DE ARRIBA
#  Tres grupos por tipo de cliente, y de cada uno cuelgan sus subgrupos.
#  Un mismo seguro puede aparecer en varios sitios: por ejemplo el de
#  arrendamiento está en Hogar y también en Seguros 100% digitales.
#  Para enlazar una página que no sale del catálogo, usa "ext:<id>"
#  con un id de la lista @EXTERNOS de arriba.
# =========================================================
our @MENU = (
  { id => "personas", nombre => "Personas", subs => [
      { nombre => "Movilidad",
        items => [qw(auto moto bicicleta-patineta taxi utilitarios-pesados soat)] },
      { nombre => "Salud",
        items => [qw(salud medicina-prepagada plan-complementario)] },
      { nombre => "Vida",
        items => [qw(vida vida-deudor accidentes-personales exequias)] },
      { nombre => "Hogar",
        items => [qw(hogar arrendamiento mascotas)] },
      { nombre => "Seguros 100% digitales",
        items => [qw(viaje arrendamiento mascotas)] },
  ]},

  { id => "empresas", nombre => "Empresas", subs => [
      { nombre => "Patrimonio",
        items => [qw(todo-riesgo-empresarial maquinaria-equipos copropiedad dano-material energia-solar cultivos-agro)] },
      { nombre => "Cumplimiento y RCE",
        items => ["ext:cumplimiento", "responsabilidad-civil"] },
      { nombre => "Operación especializada",
        items => [qw(maquinaria-equipos drones energia-solar cultivos-agro)] },
      { nombre => "Transporte y flotas",
        items => [qw(transporte-mercancias flotas-camiones utilitarios-pesados)] },
      { nombre => "Personas de tu empresa",
        items => ["ext:arl", "vida-grupo", "accidentes-colectivos"] },
  ]},

  { id => "colectivos", nombre => "Colectivos", subs => [
      { nombre => "Vida y protección",
        items => [qw(vida-grupo accidentes-colectivos exequias-colectivas)] },
      { nombre => "Deporte y educación",
        items => [qw(escuelas-deportivas accidentes-colectivos)] },
      { nombre => "Bienes del grupo",
        items => [qw(dano-material)] },
  ]},
);

1;
