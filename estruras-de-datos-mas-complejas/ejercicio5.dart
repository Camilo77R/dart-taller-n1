// Ejercicio 10: Sistema de Valoraciones y Reseñas
// Desarrolle un sistema de reseñas tipo app store. Cree clase Reseña con usuario, calificación (1-5 estrellas),
// comentario, fecha y utilidad. Implemente funciones para agregar reseñas, calcular promedio de calificaciones,
// filtrar por estrellas, mostrar reseñas más útiles y generar estadísticas.


class Resena {
  String usuario;
  int calificacion;  // 1-5 estrellas
  String comentario;
  DateTime fecha;
  int utilidad;      // cuentoo los votos útiles

 
  Resena(this.usuario, this.calificacion, this.comentario, this.fecha, this.utilidad);
}


class SistemaResenas {
 
  List<Resena> misResenas = [];

  // agregar una nueva reseña
  void agregarResena(Resena nuevaResena) {
    if (nuevaResena.calificacion >= 1 && nuevaResena.calificacion <= 5) {
      misResenas.add(nuevaResena);
      print("Reseña agregada correctamente");
    } else {
      print("Error: La calificación debe estar entre 1 y 5 estrellas");
    }
  }

  // calcular promedio de calificaciones
  double calcularPromedio() {
    if (misResenas.isEmpty) return 0;
    
    double suma = 0;
    for (var resena in misResenas) {
      suma += resena.calificacion;
    }
    return suma / misResenas.length;
  }

  // filtrar por número de estrellas
  List<Resena> filtrarPorEstrellas(int estrellas) {
    return misResenas.where((resena) => resena.calificacion == estrellas).toList();
  }

  // mostrar reseñas más útiles (top 3)
  List<Resena> resenasTopUtiles() {
    var resenasPorUtilidad = List<Resena>.from(misResenas);
    resenasPorUtilidad.sort((a, b) => b.utilidad.compareTo(a.utilidad));
    return resenasPorUtilidad.take(3).toList();
  }

  // generar estadísticas
  Map<String, dynamic> obtenerEstadisticas() {
    if (misResenas.isEmpty) {
      return {
        'total_resenas': 0,
        'promedio': 0,
        'mejor_calificacion': 0,
        'peor_calificacion': 0
      };
    }

    int mejor = misResenas[0].calificacion;
    int peor = misResenas[0].calificacion;

    for (var resena in misResenas) {
      if (resena.calificacion > mejor) mejor = resena.calificacion;
      if (resena.calificacion < peor) peor = resena.calificacion;
    }

    return {
      'total_resenas': misResenas.length,
      'promedio': calcularPromedio(),
      'mejor_calificacion': mejor,
      'peor_calificacion': peor
    };
  }
}

void main() {
  // creo el sistema
  SistemaResenas miSistema = SistemaResenas();

 
  Resena resena1 = Resena("Juan123", 5, "¡Excelente app!", DateTime.now(), 10);
  Resena resena2 = Resena("Maria_89", 3, "Regular, puede mejorar", DateTime.now(), 5);
  Resena resena3 = Resena("Pedro_Dev", 4, "Muy buena, pero falta pulir", DateTime.now(), 8);
  
  // agrego las reseñas
  miSistema.agregarResena(resena1);
  miSistema.agregarResena(resena2);
  miSistema.agregarResena(resena3);

  // pruebo las funcionalidades
  print("\n=== Promedio de Calificaciones ===");
  print("Promedio: ${miSistema.calcularPromedio()} estrellas");

  print("\n=== Reseñas de 4 Estrellas ===");
  var resenas4Estrellas = miSistema.filtrarPorEstrellas(4);
  for (var resena in resenas4Estrellas) {
    print("${resena.usuario}: ${resena.comentario}");
  }

  print("\n=== Top 3 Reseñas más Útiles ===");
  var resenasUtiles = miSistema.resenasTopUtiles();
  for (var resena in resenasUtiles) {
    print("${resena.usuario} - Utilidad: ${resena.utilidad} votos");
  }

  print("\n=== Estadísticas Generales ===");
  var stats = miSistema.obtenerEstadisticas();
  print("Total de reseñas: ${stats['total_resenas']}");
  print("Calificación promedio: ${stats['promedio']}");
  print("Mejor calificación: ${stats['mejor_calificacion']}");
  print("Peor calificación: ${stats['peor_calificacion']}");
}