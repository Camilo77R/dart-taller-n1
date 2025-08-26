enum CategoriaEvento {
  Deportivo,
  Cultural,
  Educativo,
  Social,
  Benefico
}

class Ubicacion {
  String nombre;
  String direccion;
  int capacidad;

  Ubicacion(this.nombre, this.direccion, this.capacidad);
}

class Organizador {
  String nombre;
  String contacto;
  List<Evento> eventosCreados = [];

  Organizador(this.nombre, this.contacto);

  void crearEvento(Evento evento) {
    eventosCreados.add(evento);
    print("Evento creado: ${evento.nombre}");
  }
}

class Participante {
  String nombre;
  String email;
  List<Evento> eventosRegistrados = [];

  Participante(this.nombre, this.email);
}

class Evento {
  String nombre;
  DateTime fecha;
  Ubicacion lugar;
  CategoriaEvento categoria;
  double precio;
  Organizador organizador;
  List<Participante> participantes = [];
  int aforoMaximo;
  String? codigoQR;
  Map<String, bool> checkIns = {};

  Evento(this.nombre, this.fecha, this.lugar, this.categoria, 
         this.precio, this.organizador, this.aforoMaximo) {
    generarCodigoQR();
  }

  bool registrarParticipante(Participante participante) {
    if (participantes.contains(participante)) {
      print("El participante ya está registrado");
      return false;
    }
    
    if (participantes.length < aforoMaximo) {
      participantes.add(participante);
      participante.eventosRegistrados.add(this);
      return true;
    }
    print("Evento lleno");
    return false;
  }

  double calcularRecaudacion() {
    return participantes.length * precio;
  }

  void generarCodigoQR() {
    codigoQR = 'EVT-${DateTime.now().millisecondsSinceEpoch}-${nombre.substring(0, 3)}';
  }

  bool procesarCheckIn(String codigo, Participante participante) {
    if (codigoQR == null) {
      print("Error: Código QR no generado");
      return false;
    }
    
    if (!participantes.contains(participante)) {
      print("Error: Participante no registrado");
      return false;
    }
    
    if (codigo != codigoQR) {
      print("Error: Código QR inválido");
      return false;
    }

    checkIns[participante.nombre] = true;
    print("Check-in exitoso para ${participante.nombre}");
    return true;
  }

  void procesarPago(Participante participante, double monto) {
    if (monto < precio) {
      print("Error: Monto insuficiente");
      return;
    }
    
    if (participantes.contains(participante)) {
      print("Error: Participante ya registrado");
      return;
    }

    print("Pago procesado para ${participante.nombre}");
    registrarParticipante(participante);
  }
}

class SistemaEventos {
  List<Evento> eventos = [];
  List<Organizador> organizadores = [];
  List<Participante> participantes = [];

  void registrarEvento(Evento evento) {
    eventos.add(evento);
  }

  void registrarOrganizador(Organizador organizador) {
    organizadores.add(organizador);
  }

  List<Evento> buscarPorCategoria(CategoriaEvento categoria) {
    return eventos.where((evento) => evento.categoria == categoria).toList();
  }

  List<Evento> eventosProximos() {
    var hoy = DateTime.now();
    return eventos.where((evento) => evento.fecha.isAfter(hoy)).toList();
  }
}

void main() {
  var sistema = SistemaEventos();

  var organizador = Organizador("Ana", "ana@mail.com");
  sistema.registrarOrganizador(organizador);

  var ubicacion = Ubicacion("Centro Cultural", "Calle Principal 123", 100);
  
  var evento = Evento(
    "Taller de Arte", 
    DateTime.now().add(Duration(days: 7)),
    ubicacion,
    CategoriaEvento.Cultural,
    25.0,
    organizador,
    30
  );

  organizador.crearEvento(evento);
  sistema.registrarEvento(evento);

  print("\n=== Eventos Próximos ===");
  var proximos = sistema.eventosProximos();
  for (var e in proximos) {
    print("${e.nombre} - ${e.fecha}");
  }

  var participante = Participante("Carlos", "carlos@mail.com");
  print("\n=== Registro de Participante ===");
  if (evento.registrarParticipante(participante)) {
    print("${participante.nombre} registrado en ${evento.nombre}");
  }

  print("\n=== Prueba de Check-in ===");
  evento.procesarCheckIn(evento.codigoQR!, participante);

  print("\n=== Estadísticas del Evento ===");
  print("Participantes: ${evento.participantes.length}");
  print("Recaudación: \$${evento.calcularRecaudacion()}");
}