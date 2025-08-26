enum EstadoLibro {
  Nuevo,
  ComoNuevo,
  BuenEstado,
  Usado
}

class Usuario {
  String nombre;
  String ciudad;
  double reputacion = 5.0;
  List<Libro> librosDisponibles = [];
  List<Intercambio> historialIntercambios = [];

  Usuario(this.nombre, this.ciudad);

  void publicarLibro(Libro libro) {
    librosDisponibles.add(libro);
    print("Libro publicado: ${libro.titulo}");
  }
}

class Libro {
  String titulo;
  String autor;
  EstadoLibro estado;
  Usuario propietario;
  List<Resena> resenas = [];

  Libro(this.titulo, this.autor, this.estado, this.propietario);
}

class Intercambio {
  Usuario solicitante;
  Usuario propietario;
  Libro libroSolicitado;
  bool aceptado = false;
  bool completado = false;

  Intercambio(this.solicitante, this.propietario, this.libroSolicitado);
}

class Resena {
  Usuario autor;
  int calificacion;
  String comentario;
  DateTime fecha;

  Resena(this.autor, this.calificacion, this.comentario) : fecha = DateTime.now();
}

class RedIntercambio {
  List<Usuario> usuarios = [];
  List<Intercambio> intercambiosPendientes = [];

  void registrarUsuario(Usuario usuario) {
    usuarios.add(usuario);
  }

  void solicitarIntercambio(Usuario solicitante, Libro libro) {
    var intercambio = Intercambio(solicitante, libro.propietario, libro);
    intercambiosPendientes.add(intercambio);
    print("Intercambio solicitado para: ${libro.titulo}");
  }

  List<Libro> buscarPorTitulo(String titulo) {
    List<Libro> resultados = [];
    for (var usuario in usuarios) {
      resultados.addAll(
        usuario.librosDisponibles.where(
          (libro) => libro.titulo.toLowerCase().contains(titulo.toLowerCase())
        )
      );
    }
    return resultados;
  }

  List<Libro> busquedaAvanzada({
    String? titulo,
    String? autor,
    EstadoLibro? estado,
    String? ciudad
  }) {
    return usuarios.expand((u) => u.librosDisponibles)
      .where((libro) =>
        (titulo == null || libro.titulo.toLowerCase().contains(titulo.toLowerCase())) &&
        (autor == null || libro.autor.toLowerCase().contains(autor.toLowerCase())) &&
        (estado == null || libro.estado == estado) &&
        (ciudad == null || libro.propietario.ciudad == ciudad)
      ).toList();
  }

  void enviarNotificacion(Usuario usuario, String mensaje) {
    print("📱 Notificación para ${usuario.nombre}: $mensaje");
  }
}

void main() {
  var redLibros = RedIntercambio();

  // crear usuarios
  var usuario1 = Usuario("Ana", "Madrid");
  var usuario2 = Usuario("Carlos", "Barcelona");
  
  redLibros.registrarUsuario(usuario1);
  redLibros.registrarUsuario(usuario2);

  // publicar libros
  var libro1 = Libro("El Quijote", "Cervantes", EstadoLibro.BuenEstado, usuario1);
  var libro2 = Libro("Cien años de soledad", "García Márquez", EstadoLibro.ComoNuevo, usuario2);

  usuario1.publicarLibro(libro1);
  usuario2.publicarLibro(libro2);

  // probar búsqueda
  print("\n=== Búsqueda de Libros ===");
  var resultados = redLibros.buscarPorTitulo("quijote");
  for (var libro in resultados) {
    print("${libro.titulo} - ${libro.propietario.nombre}");
  }

  // solicitar intercambio
  print("\n=== Solicitud de Intercambio ===");
  redLibros.solicitarIntercambio(usuario2, libro1);
}