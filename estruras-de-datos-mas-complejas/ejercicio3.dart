
import 'dart:math';
void main(){
  // creo una playlist
  PlayList miPlaylist = PlayList();

  // ccreare algunas canciones
  Cancion cancion1 = Cancion('Despacito', 'Luis Fonsi', Genero.Pop, 3.48, 4);
  Cancion cancion2 = Cancion("Vivir Mi Vida", "Marc Anthony", Genero.Salsa, 4.12, 5);
  Cancion cancion3 = Cancion("La Bicicleta", "Shakira", Genero.Pop, 3.48, 3);
  Cancion cancion4 = Cancion("Hawái", "Maluma", Genero.urbano, 3.19, 4);

  //Agrego la canciones ala playList
  miPlaylist.agregarCancion(cancion1);
  miPlaylist.agregarCancion(cancion2);
  miPlaylist.agregarCancion(cancion3);
  miPlaylist.agregarCancion(cancion4);

  // probar funcionalidades
  print("\n === Reproduccion Aleatoria ===");
  miPlaylist.reproducirAleatoriamente();

  print("\n=== Duracion Total ===");
  print(miPlaylist.duracionTotalCanciones());

  print("\n=== Filtrar por Género Pop ===");
  List<Cancion> CancionesPop = miPlaylist.filtrarPorGenero(Genero.Pop);
  // recorro la lista que retorno para ver que hay
  for(var cancion in CancionesPop){
    print("${cancion.titulo} - ${cancion.artista}");
  }

    print("\n=== Estadísticas de la Playlist ===");
  Map<String, dynamic> estadisticas = miPlaylist.obtenerEstadisticas();
  print("Total de canciones: ${estadisticas['total_canciones']}");
  print("Calificación promedio: ${estadisticas['calificacion_promedio']}");
  print("Duración total: ${estadisticas['duracion_total']} minutos");
  
  print("\n=== Quitar una canción ===");
  miPlaylist.quitarCancion("Despacito");
  print("Canción 'Despacito' eliminada");
  print("Nueva cantidad de canciones: ${miPlaylist.playListMisFavoritos.length}");
}


// hago un enumeration para guardar los generos
enum Genero {
  Salsa,Popular,Clasico,Pop,Romantico,urbano
}



class Cancion{
  String titulo;
  String artista;
  Genero tipo ;
  double duracion;
  int calificacion;


  // constructor de la clase
  Cancion(this.titulo,this.artista,this.tipo,this.duracion,this.calificacion);

}

class PlayList{
  // crear playlist
  List<Cancion> playListMisFavoritos = [];

  // agregar canciones
  void agregarCancion(Cancion temazo){
    playListMisFavoritos.add(temazo); //le agraguo lo que paso como arg a la lista
  }
  // quitar canciones
  void quitarCancion(String tituloTema){
    playListMisFavoritos.removeWhere((cancionIndividual)=> cancionIndividual.titulo == tituloTema);
  }
  // reproducir aleatoria
  // necesito instaciar random
  final random = Random();
  
  
  Cancion reproducirAleatoriamente(){
    if (playListMisFavoritos.isEmpty) {
    throw Exception('La playlist está vacía');
  }
    int cancionAleatoria = random.nextInt(playListMisFavoritos.length);
    // la variables es de tipo Cancion y esta buscara en la playlist la cancionAleatoria(posicion dela lista) y a pondre
    Cancion cancionAReproducir = playListMisFavoritos[cancionAleatoria];

    print('Reproduciendo: ${cancionAReproducir.titulo} - ${cancionAReproducir.artista}');
    return cancionAReproducir;
  }
  // calcular la duracion tota => supongo es la suma de todas las canciones

  double duracionTotalCanciones(){
    double sumaTotal =0;
    for (var cancion in playListMisFavoritos) {
        sumaTotal+= cancion.duracion;
    }
    return sumaTotal;
  }

  // filtar genero
  List<Cancion> filtrarPorGenero(Genero generoAFiltrar){
    // recorro la lista, en cada iteracion donde cancionIndividual se igual que el geneAFiltra lo agrego en una lista esa cancion
    return playListMisFavoritos.where((cancionIndividual)=> cancionIndividual.tipo == generoAFiltrar).toList();

  }

  // estadisticas
  Map<String, dynamic> obtenerEstadisticas() {
  // Contador de canciones por género
  Map<Genero, int> cancionesPorGenero = {};
  // Para calcular promedio de calificaciones
  double calificacionTotal = 0;
  
  for (var cancion in playListMisFavoritos) {
    // Contar géneros
    cancionesPorGenero[cancion.tipo] = (cancionesPorGenero[cancion.tipo] ?? 0) + 1;
    // Sumar calificaciones
    calificacionTotal += cancion.calificacion;
  }

  double calificacionPromedio = playListMisFavoritos.isEmpty ? 
      0 : calificacionTotal / playListMisFavoritos.length;

  return {
    'total_canciones': playListMisFavoritos.length,
    'canciones_por_genero': cancionesPorGenero,
    'calificacion_promedio': calificacionPromedio,
    'duracion_total': duracionTotalCanciones()
  };
}



}