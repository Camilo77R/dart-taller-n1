// guardo los tipos de cursos que puede haber
enum NivelCurso {
  Principiante,
  Intermedio,
  Avanzado
}

class Usuario {
  String nombre;
  String email;
  List<Curso> cursosInscritos = [];
  Map<String, double> progresoPorCurso = {};
  Map<String, List<String>> intereses = {};

  Usuario(this.nombre, this.email);

  void inscribirCurso(Curso curso) {
    cursosInscritos.add(curso);
    progresoPorCurso[curso.titulo] = 0;
    print("Te has inscrito en: ${curso.titulo}");
  }

  void agregarInteres(String categoria, String tema) {
    if (!intereses.containsKey(categoria)) {
      intereses[categoria] = [];
    }
    intereses[categoria]!.add(tema);
  }
}

class Leccion {
  String titulo;
  bool completada = false;
  int duracionMinutos;

  Leccion(this.titulo, this.duracionMinutos);
}

class Curso {
  String titulo;
  String profesor;
  NivelCurso nivel;
  List<Leccion> lecciones = [];
  double calificacionPromedio = 0;
  String categoria;

  Curso(this.titulo, this.profesor, this.nivel, this.categoria);

  void agregarLeccion(Leccion leccion) {
    lecciones.add(leccion);
  }
}

class PlataformaCursos {
  List<Usuario> usuarios = [];
  List<Curso> cursos = [];

  void registrarUsuario(Usuario usuario) {
    usuarios.add(usuario);
  }

  void agregarCurso(Curso curso) {
    cursos.add(curso);
  }

  void marcarLeccionCompletada(Usuario usuario, Curso curso, int indice) {
    if (indice < curso.lecciones.length) {
      curso.lecciones[indice].completada = true;
      actualizarProgreso(usuario, curso);
    }
  }

  void actualizarProgreso(Usuario usuario, Curso curso) {
    int completadas = 0;
    for (var leccion in curso.lecciones) {
      if (leccion.completada) completadas++;
    }
    
    double progreso = (completadas / curso.lecciones.length) * 100;
    usuario.progresoPorCurso[curso.titulo] = progreso;
  }

  bool puedeObtenerCertificado(Usuario usuario, Curso curso) {
    return usuario.progresoPorCurso[curso.titulo] == 100;
  }

  Map<String, dynamic> obtenerEstadisticas(Usuario usuario) {
    int cursosCompletados = 0;
    int leccionesVistas = 0;
    
    for (var curso in usuario.cursosInscritos) {
      if (usuario.progresoPorCurso[curso.titulo] == 100) {
        cursosCompletados++;
      }
      for (var leccion in curso.lecciones) {
        if (leccion.completada) leccionesVistas++;
      }
    }
    
    return {
      'cursos_completados': cursosCompletados,
      'lecciones_vistas': leccionesVistas,
      'tiempo_total': leccionesVistas * 30 // promedio minutos por lección
    };
  }

  List<Curso> obtenerRecomendaciones(Usuario usuario) {
    return cursos.where((curso) => 
      usuario.intereses.containsKey(curso.categoria) &&
      !usuario.cursosInscritos.contains(curso)
    ).toList();
  }
}

void main() {
  var plataforma = PlataformaCursos();

  // crear usuario
  var usuario1 = Usuario("Juan", "juan@mail.com");
  plataforma.registrarUsuario(usuario1);

  // crear curso con lecciones
  var cursoDart = Curso("Dart para Principiantes", "Ana", NivelCurso.Principiante, "Programación");
  cursoDart.agregarLeccion(Leccion("Introducción", 10));
  cursoDart.agregarLeccion(Leccion("Variables", 15));
  cursoDart.agregarLeccion(Leccion("Funciones", 20));

  plataforma.agregarCurso(cursoDart);

  // probar funcionalidades
  usuario1.inscribirCurso(cursoDart);
  usuario1.agregarInteres("Programación", "Dart");
  
  print("\n=== Progreso Inicial ===");
  print("Progreso en ${cursoDart.titulo}: ${usuario1.progresoPorCurso[cursoDart.titulo]}%");

  plataforma.marcarLeccionCompletada(usuario1, cursoDart, 0);
  plataforma.marcarLeccionCompletada(usuario1, cursoDart, 1);

  print("\n=== Progreso Actualizado ===");
  print("Progreso en ${cursoDart.titulo}: ${usuario1.progresoPorCurso[cursoDart.titulo]}%");

  print("\n=== Estado Certificado ===");
  print("¿Puede obtener certificado? ${plataforma.puedeObtenerCertificado(usuario1, cursoDart)}");

  print("\n=== Estadísticas ===");
  var stats = plataforma.obtenerEstadisticas(usuario1);
  print("Cursos completados: ${stats['cursos_completados']}");
  print("Lecciones vistas: ${stats['lecciones_vistas']}");
  print("Tiempo total (min): ${stats['tiempo_total']}");

  print("\n=== Recomendaciones ===");
  var recomendaciones = plataforma.obtenerRecomendaciones(usuario1);
  for (var curso in recomendaciones) {
    print("Curso recomendado: ${curso.titulo}");
  }
}