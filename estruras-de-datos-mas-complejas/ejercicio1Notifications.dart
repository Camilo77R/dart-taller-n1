void main(){
  // creo o isntacio el gestor de notificaciones
  var gestor = GestorNotificaciones();


  //instacion las notificaciones
  var mensaje1  = Notificacion('Actualizacion del sistema', 'Hay una nueva version del sistema disponible',TipoNotificacion.info, DateTime.now(), false);
  var mensaje2  = Notificacion('¡Advertencia!', 'Bateria baja!',TipoNotificacion.advertencia, DateTime.now(), false);
  var mensaje3  = Notificacion('Error crítico', 'Fallo en la conexion',TipoNotificacion.error, DateTime.now(), false);
  


  gestor.agregarNotificacion(mensaje1);
  gestor.agregarNotificacion(mensaje2);
  gestor.agregarNotificacion(mensaje3);


  print('La notificacion esta leida ? ${mensaje1.marcarComoLeida()}');
  print('*******************************');
  print('Las notificaciones de tipo info son: ');
  var notificacionesInfo = gestor.filtrarPorTipo(TipoNotificacion.info);
  for (var notif in notificacionesInfo) {
    print('- Título: ${notif.titulo}, Mensaje: ${notif.mensaje}');
  }
  print('**************Todas las notificaciones*****************');



  // muestro todas las notificaciones
  var todasLasNotificaciones = gestor.obtenerTodas();
  for(var cadaUna in todasLasNotificaciones){
    print('Titulo: ${cadaUna.titulo}, Mensaje: ${cadaUna.mensaje}');
  }

  print('**************Estadisticas****************');

  gestor.mostrarEstadisticas();

}

enum TipoNotificacion { info, advertencia, error }

class Notificacion{
  String titulo;
  String mensaje;
  TipoNotificacion tipo;
  DateTime fechHora;
  bool leida;


  // contructor para incicilizar
  Notificacion(this.titulo,this.mensaje, this.tipo, this.fechHora, this.leida);


  // metodos  //crear // filtrar
  // void crearNotificacion(){}
  bool marcarComoLeida(){ // si se lla al metodo significa que se leyo
    return leida = true;
  }

}


class GestorNotificaciones{
  // es una lista que solo puede ob de la clase notificacion
  List<Notificacion> listaNotificaciones = [];

  // este metodo es para agregar las notificaciones a as lista de estas 
  void agregarNotificacion(Notificacion notificacion){
    listaNotificaciones.add(notificacion);
  }

  List<Notificacion> filtrarPorTipo(TipoNotificacion tipo){
    //retorno una lista con las notificacines que sean igual al tipo 
    return listaNotificaciones.where((notificacion) => notificacion.tipo == tipo).toList();
  }


  List<Notificacion>obtenerTodas(){
    return listaNotificaciones;
  }


   void mostrarEstadisticas() {
    // Contador por tipo
    int cantidadInfo = 0;
    int cantidadAdvertencia = 0;
    int cantidadError = 0;
    
    // Contador por estado
    int cantidadLeidas = 0;
    int cantidadNoLeidas = 0;

    for (var notificacion in listaNotificaciones) {
      // Contar por tipo
      if (notificacion.tipo == TipoNotificacion.info) cantidadInfo++;
      if (notificacion.tipo == TipoNotificacion.advertencia) cantidadAdvertencia++;
      if (notificacion.tipo == TipoNotificacion.error) cantidadError++;

      // Contar por estadoss 
      if (notificacion.leida) { //si esta leida etra aqui y aumenta el contadror
        cantidadLeidas++;
      } else {
        cantidadNoLeidas++;
      }
    }

    // Mostrar resultados
    print('Estadísticas de notificaciones:');
    print('Total de notificaciones: ${listaNotificaciones.length}');
    print('Por tipo:');
    print('- Info: $cantidadInfo');
    print('- Advertencia: $cantidadAdvertencia');
    print('- Error: $cantidadError');
    print('Por estado:');
    print('- Leídas: $cantidadLeidas');
    print('- No leídas: $cantidadNoLeidas');
  }

  

}


