import 'dart:math';

void main() {
  var gestor = gestorDeUbicaciones();

  // 2. Crear ubicaciones
  var casa = Ubicacion("Mi Casa", 10.0, 12.0, Categoria.Casa);
  var trabajo = Ubicacion("Oficina", 15.0, 18.0, Categoria.Trabajo);
  var hospital = Ubicacion("Hospital Central", 20.0, 22.0, Categoria.Hospital);

  gestor.agregarUbicacion(casa);
  gestor.agregarUbicacion(trabajo);
  gestor.agregarUbicacion(hospital);

  var resultados = gestor.buscaPorCategoria(Categoria.Trabajo);
  print("Ubicaciones en categoría Trabajo:");
  resultados.forEach((u) => print(u.nombre));

  // 5. Calcular distancia entre dos ubicaciones
  var distancia = gestor.calcularDistancia("Mi Casa", "Oficina");
  print("Distancia entre Casa y Oficina: $distancia");

  // 6. Eliminar una ubicación
  gestor.EliminarUbicacion("Hospital Central");
  print("Lista después de eliminar hospital:");
  gestor.listaUbicacion.forEach((u) => print(u.nombre));
}

// para la categoria creo un enum
enum Categoria { Casa, Trabajo, Restaurante, Hospital }

class Ubicacion {
  String nombre;
  double latitud;
  double longitud;
  Categoria tipo;

  // constructor
  Ubicacion(this.nombre, this.latitud, this.longitud, this.tipo);

  //  metodos
}

class gestorDeUbicaciones {
  List<Ubicacion> listaUbicacion = [];

  // agragar ubicacion metodo
  void agregarUbicacion(Ubicacion ubicacion) {
    listaUbicacion.add(ubicacion);
  }

  // eliminar ubicacion
  void EliminarUbicacion(String nombreUbi) {
    //recorro la lista  uno a uno y le llamo a cada elemento 'ubicacion', y este
    //removeWhere lo usamos para la condicion que si encuetra algo  en la lista igual a lo que le paso como arg pues lo borra
    listaUbicacion.removeWhere((ubicacion) => ubicacion.nombre == nombreUbi);
  }

  List<Ubicacion> buscaPorCategoria(Categoria categoriaABuscar) {
    // itero la lista y llama a cada elemento ubicacion, y donde ubicacion.tipo sea igual que lo que le paso lo guardo en una lista que retorno con las coincidencias
    return listaUbicacion
        .where((ubicacion) => ubicacion.tipo == categoriaABuscar)
        .toList();
  }

  double calcularDistancia(String nombre1, String nombre2) {
    // Buscar ubicaciones
    var ubi1 = listaUbicacion.firstWhere(
      (ubicacion) => ubicacion.nombre == nombre1,
      orElse: () => throw Exception("Ubicación $nombre1 no encontrada"),
    );

    var ubi2 = listaUbicacion.firstWhere(
      (ubicacion) => ubicacion.nombre == nombre2,
      orElse: () => throw Exception("Ubicación $nombre2 no encontrada"),
    );

    // Diferencias
    double dLat = ubi2.latitud - ubi1.latitud;
    double dLon = ubi2.longitud - ubi1.longitud;

    // Distancia aproximada (teorema de Pitágoras)
    return sqrt(dLat * dLat + dLon * dLon);
  }
}