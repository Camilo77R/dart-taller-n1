import 'dart:io';



List<String>validarPass(String pass){//retorno una lista de  tipo String
  // creo una lista para guardar sugerencias 
  List<String> sugerencias = []; //si la pass esta perfecta o esto se queda vacio

  // si se cumple que no esta pues le agrego la sugerencia
  if(!(pass.contains(RegExp(r'[A-Z]')))){
    sugerencias.add("La contraseña debe tener almenos una letra mayuscula");
  }
  if(!(pass.contains(RegExp(r'[a-z]')))){
    sugerencias.add("La contraseña debe tener almenos una letra minuscula");
  }
  if(!(pass.contains(RegExp(r'[0-9]')))){
    sugerencias.add("La contraseña debe tener almenos un numero");
  }
  if(!(pass.contains(RegExp(r'[!@#\$%\^&\*(),\."{}\[\]|<>/?]')))){
    sugerencias.add("La contraseña debe tener almenos un caracter  especial (-*?/)");
  }

  return sugerencias;

}




void main(){
  //recibir las contrasenia
  stdout.write("Digite una contraseña para validar  ");
  String? pass = stdin.readLineSync(); //? es por que el dato que viene puede ser nulo o no
  // verifico que la pass no se null para poder trabaar con el dato
  if(pass != null){
    // llamo la fn aca si es null pues no entra  aqui

    List<String>misSugerencias =  validarPass(pass);
    // verifico que la pass sea >= 8 

    if(pass.length >= 8){

      // ver cuantas sugerencias hay en las lista y segun eso dar una categoria
      if(misSugerencias.isEmpty){
        print("Tu contraseña es MUY FUERTE Felicidades!!");


      }else if(misSugerencias.length ==1){//tiene lenth 1 pero el index es 0 => tiene una sugerencia
        print("Tu contraseña es FUERTE ");
        print("Sugerencia: ${misSugerencias[0]}");


      }else if(misSugerencias.length == 2){
        print("Tu contraseña es MEDIA ");
        print("Sugerencia: ${misSugerencias[0]}");
        print("Sugerencia: ${misSugerencias[1]}");


      }else if(misSugerencias == 3){
        print("Tu contraseña es DEBIL ");
        print("Sugerencia: ${misSugerencias[0]}");
        print("Sugerencia: ${misSugerencias[1]}");
        print("Sugerencia: ${misSugerencias[2]}");
      };

    }else{
      print("La contraseña deber tener minimo 8 caracteres ");
      };
  }
    

    
}

