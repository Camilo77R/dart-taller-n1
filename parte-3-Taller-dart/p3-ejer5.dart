enum EstadoServicio {
  Pendiente,
  Aceptado,
  EnProceso,
  Completado,
  Cancelado
}

class Cliente {
  String nombre;
  String direccion;
  String telefono;
  List<Solicitud> historialSolicitudes = [];
  double saldo = 0;

  Cliente(this.nombre, this.direccion, this.telefono);

  void agregarSaldo(double monto) {
    saldo += monto;
  }
}

class Prestador {
  String nombre;
  String especialidad;
  double calificacionPromedio = 5.0;
  List<Servicio> servicios = [];
  List<Calificacion> calificaciones = [];

  Prestador(this.nombre, this.especialidad);

  void agregarServicio(String nombre, String descripcion, double precio) {
    servicios.add(Servicio(nombre, descripcion, precio, this));
  }

  void recibirCalificacion(Calificacion calificacion) {
    calificaciones.add(calificacion);
    actualizarPromedio();
  }

  void actualizarPromedio() {
    double suma = 0;
    for (var cal in calificaciones) {
      suma += cal.estrellas;
    }
    calificacionPromedio = suma / calificaciones.length;
  }
}

class Servicio {
  String nombre;
  String descripcion;
  double precio;
  Prestador prestador;

  Servicio(this.nombre, this.descripcion, this.precio, this.prestador);
}

class Solicitud {
  Cliente cliente;
  Servicio servicio;
  DateTime fecha;
  EstadoServicio estado;
  List<String> seguimiento = [];
  Calificacion? calificacion;

  Solicitud(this.cliente, this.servicio) 
    : fecha = DateTime.now(),
      estado = EstadoServicio.Pendiente {
    actualizarSeguimiento("Solicitud creada");
  }

  void actualizarSeguimiento(String mensaje) {
    seguimiento.add("${DateTime.now()}: $mensaje");
  }
}

class Calificacion {
  int estrellas;
  String comentario;
  DateTime fecha;

  Calificacion(this.estrellas, this.comentario) : fecha = DateTime.now();
}

class Marketplace {
  List<Prestador> prestadores = [];
  List<Cliente> clientes = [];
  List<Solicitud> solicitudesActivas = [];

  void registrarPrestador(Prestador prestador) {
    prestadores.add(prestador);
  }

  void registrarCliente(Cliente cliente) {
    clientes.add(cliente);
  }

  List<Servicio> buscarServicios(String especialidad) {
    List<Servicio> resultados = [];
    for (var prestador in prestadores) {
      if (prestador.especialidad.toLowerCase().contains(especialidad.toLowerCase())) {
        resultados.addAll(prestador.servicios);
      }
    }
    return resultados;
  }

  bool crearSolicitud(Cliente cliente, Servicio servicio) {
    if (cliente.saldo >= servicio.precio) {
      var solicitud = Solicitud(cliente, servicio);
      solicitudesActivas.add(solicitud);
      cliente.historialSolicitudes.add(solicitud);
      return true;
    }
    print("Saldo insuficiente");
    return false;
  }

  void completarServicio(Solicitud solicitud, int estrellas, String comentario) {
    solicitud.estado = EstadoServicio.Completado;
    solicitud.actualizarSeguimiento("Servicio completado");
    
    var calificacion = Calificacion(estrellas, comentario);
    solicitud.calificacion = calificacion;
    solicitud.servicio.prestador.recibirCalificacion(calificacion);
    
    // Procesar pago
    solicitud.cliente.saldo -= solicitud.servicio.precio;
  }
}

void main() {
  var marketplace = Marketplace();

  // Crear prestador
  var prestador = Prestador("Juan", "Plomero");
  prestador.agregarServicio("Reparación", "Arreglo de tuberías", 100);
  prestador.agregarServicio("Instalación", "Instalación de grifería", 150);
  marketplace.registrarPrestador(prestador);

  // Crear cliente
  var cliente = Cliente("María", "Calle 123", "555-0123");
  cliente.agregarSaldo(200);  // Agregar saldo para pagar
  marketplace.registrarCliente(cliente);

  print("\n=== Servicios Disponibles ===");
  var servicios = marketplace.buscarServicios("plomero");
  for (var servicio in servicios) {
    print("${servicio.nombre} - \$${servicio.precio}");
  }

  print("\n=== Crear Solicitud ===");
  if (marketplace.crearSolicitud(cliente, servicios[0])) {
    print("Solicitud creada exitosamente");
    
    var solicitud = cliente.historialSolicitudes.last;
    print("\n=== Completar Servicio ===");
    marketplace.completarServicio(solicitud, 5, "Excelente servicio");
    
    print("\n=== Estado Final ===");
    print("Calificación del prestador: ${prestador.calificacionPromedio}");
    print("Saldo del cliente: \$${cliente.saldo}");
    print("Estado de la solicitud: ${solicitud.estado}");
    print("\nSeguimiento:");
    for (var paso in solicitud.seguimiento) {
      print("  $paso");
    }
  }
}