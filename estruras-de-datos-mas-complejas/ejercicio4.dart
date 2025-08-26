// Ejercicio 9: Gestor de Archivos Móvil
// Cree un simulador de gestor de archivos para dispositivos móviles. Defina clase Archivo con nombre, tamaño,
// tipo, fecha creación y ruta. Implemente operaciones: listar archivos, buscar por nombre/tipo, calcular espacio
// usado, organizar por fecha/tamaño y simular transferencias entre carpetas.


enum TipoArchivo {
  Imagen,
  Documento,
  Audio,
  Video,
  Otro
}

class Archivo {
  String nombre;
  double tamano;
  TipoArchivo tipo;
  DateTime fechaCreacion;
  String ruta;

  
  Archivo(this.nombre, this.tamano, this.tipo, this.fechaCreacion, this.ruta);
}

class GestorArchivos {
  // lista para guardar todos los archivos
  List<Archivo> misArchivos = [];


  void agregarArchivo(Archivo archivo) {
    misArchivos.add(archivo);
  }

 
  void listarArchivos() {
    for (var archivo in misArchivos) {
      print("Nombre: ${archivo.nombre} - Tamaño: ${archivo.tamano}MB - Tipo: ${archivo.tipo}");
    }
  }


  List<Archivo> buscarPorNombre(String nombre) {
    return misArchivos.where((archivo) => 
      archivo.nombre.toLowerCase().contains(nombre.toLowerCase())).toList();
  }


  List<Archivo> buscarPorTipo(TipoArchivo tipo) {
    return misArchivos.where((archivo) => archivo.tipo == tipo).toList();
  }

  
  double calcularEspacioUsado() {
    double espacioTotal = 0;
    for (var archivo in misArchivos) {
      espacioTotal += archivo.tamano;
    }
    return espacioTotal;
  }

  // mover archivo
  void moverArchivo(String nombreArchivo, String nuevaRuta) {
    for (var archivo in misArchivos) {
      if (archivo.nombre == nombreArchivo) {
        archivo.ruta = nuevaRuta;
        print("Archivo ${archivo.nombre} movido a $nuevaRuta");
        return;
      }
    }
  }
}

void main() {
 
  GestorArchivos miGestor = GestorArchivos();


  Archivo archivo1 = Archivo("foto_playa.jpg", 2.5, TipoArchivo.Imagen, DateTime.now(), "/fotos");
  Archivo archivo2 = Archivo("tarea_mate.pdf", 1.2, TipoArchivo.Documento, DateTime.now(), "/documentos");
  Archivo archivo3 = Archivo("cancion.mp3", 3.8, TipoArchivo.Audio, DateTime.now(), "/musica");

  
  miGestor.agregarArchivo(archivo1);
  miGestor.agregarArchivo(archivo2);
  miGestor.agregarArchivo(archivo3);

  // pruebo las funcionalidades
  print("\n=== Listar Archivos ===");
  miGestor.listarArchivos();

  print("\n=== Buscar por Nombre 'tarea' ===");
  var resultadoBusqueda = miGestor.buscarPorNombre("tarea");
  for (var archivo in resultadoBusqueda) {
    print("Encontrado: ${archivo.nombre}");
  }

  print("\n=== Espacio Total Usado ===");
  print("${miGestor.calcularEspacioUsado()} MB");

  print("\n=== Mover Archivo ===");
  miGestor.moverArchivo("foto_playa.jpg", "/fotos/vacaciones");
}