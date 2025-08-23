// Ejercicio 3: Calculadora de Tiempo de Viaje Urbano
// Implemente una calculadora que estime tiempos de viaje considerando diferentes medios de transporte y
// condiciones de tráfico. Solicite origen, destino (distancia en km), medio de transporte (a pie, bicicleta, carro,
// transporte público) y hora del día (hora pico, normal). Calcule tiempo estimado y costo total.


import 'dart:io';

void main() {

  // valores fijos vlocidades y precios.
  const double VELOCIDAD_A_PIE = 5.0; // km/h
  const double VELOCIDAD_BICICLETA = 15.0; // km/h
  const double VELOCIDAD_BUS = 20.0; // km/h
  const double COSTO_BUS_FIJO = 1.50; // Costo del pasaje fijo



  stdout.write("Buenos dias!!\n");
  stdout.write(
    "Digite desde donde será el viaje",); //solo para saber el nombre desde donde inicia
  String? lugarOrigen = stdin.readLineSync(); // puede o no ser null (?)

  // verifico que los valores no sean null

  if (lugarOrigen != null && lugarOrigen.trim().isNotEmpty) {
    stdout.write("Digite hasta donde será el viaje en km"); //para calcular
    String lugarDestino = stdin.readLineSync() ?? '0';

    if (lugarDestino != null) {
      //si no es null sigo preguntando
      double lugarDestinoKm = double.parse(lugarDestino);
      // medio de transporte
      stdout.write("En que desea viajar?\n");
      print("1. A pie");
      print("2. En bicicleta");
      print("3. En bus");

      String? medioTransporte = stdin.readLineSync();

      if (medioTransporte != null && medioTransporte.trim().isNotEmpty) {
        int medioTransporteOpt = int.parse(medioTransporte);
        // hora del dia en la que viajará
        stdout.write("En que hora de dia va a viajar\n ");
        print("1. Hora pico ");
        print("2. Hora normal");
        String? horaDeViaje = stdin.readLineSync();
        if (horaDeViaje != null && horaDeViaje.trim().isNotEmpty){

          int horaViajeOpt = int.parse(horaDeViaje);
          double timeResult = tiempoEstimado(VELOCIDAD_A_PIE,lugarDestinoKm, horaViajeOpt );
          double resultCosto = costoViaje(medioTransporteOpt);

          print("El tiempo estado es de $timeResult horas");
          print("El costo estimado es de $resultCosto pesos");
        }else{
          print("Debe escoger la opcion 1 o 2");
        }
      } else {
        print("Escrba el lugar de destino en km");
      }
    } else {
      print("El lugar de origen node ser null");
    }
  } else {
    print("el lugar de origen no debe estar vacio");
  }




  
}


double tiempoEstimado(double velocidad, double distancia, int horaDia){
  // tiempo = distancia /velocidad 
  double tiempoEstimado = 0;
  if(horaDia == 1){
    tiempoEstimado = distancia /velocidad;
    tiempoEstimado *=  1.5 ; // le agrego 1.5 como tiemp de retraso que tendra por ser hora pico 
  }else if(horaDia == 2){
    tiempoEstimado =  distancia / velocidad; // no cambia si es hora normal
  }
  return tiempoEstimado;
}

double costoViaje (int medioTransporte ){
  double costoTotal = 0;
  double velocidad = 0;
  if (medioTransporte == 1) { // A pie
    costoTotal = 0.0;
  } else if (medioTransporte == 2) { // En bicicleta
    costoTotal = 0.0;
  } else if (medioTransporte == 3) { // En bus
    costoTotal =  1.50 ;
  }

  return costoTotal;
}