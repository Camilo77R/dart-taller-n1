import 'dart:io';
void main(){

  stdout.write("Digite el nombre de la red wifi\n");
  String? nombreRed = stdin.readLineSync();
  if(nombreRed != null && nombreRed.trim().isNotEmpty){//valido que no sea null y que no este vacio
    
    stdout.write("Digite la contraseña de la red wifi \n");
    String? passwordRed = stdin.readLineSync(); //el ? indica que puede ser null o no
    if(passwordRed != null && passwordRed.trim().isNotEmpty){//valido que no
      stdout.write("Digite el tipo de seguridad de la red wifi\n");
      String? tipoSeguridad = stdin.readLineSync();
      
      if(tipoSeguridad != null && tipoSeguridad.trim().isNotEmpty){//valido que no sea null y que no este vacio
        stdout.write("Digite el tipo de dispositivo (android/ios)\n");
        String? tipoDispositivo = stdin.readLineSync();
      
        if(tipoDispositivo != null && tipoDispositivo.trim().isNotEmpty){//valido
          String validacionContrasenia = validarContrasenia(passwordRed, tipoSeguridad, nombreRed);
          print(validacionContrasenia);
          String indicaciones = indicacionesDp(nombreRed, tipoDispositivo.toLowerCase());
          print(indicaciones);
        } else {
          print("El tipo de dispositivo no puede estar vacio");  
        }
      }
    }
  }
}


String validarContrasenia(String? passwordRed, String? tipoSeguridad, String? nombreRed){
  String mensaje = "";
  
  if(passwordRed != null && passwordRed.trim().isNotEmpty){//valido que no
    if(passwordRed.length >=8 ){
      if(tipoSeguridad != null && tipoSeguridad.trim().isNotEmpty){//valido que no sea null y que no este vacio
        if(tipoSeguridad.toLowerCase() == "wpa" || tipoSeguridad.toLowerCase() == "web" ){
          
          mensaje = "La red wifi $nombreRed es segura";
        } else {
          mensaje = "La red wifi $nombreRed no es segura su tipo de seguridad es $tipoSeguridad";
        }
      } 
    } else {
      mensaje = "La contraseña de la red wifi $nombreRed es insegura, debe tener al menos 8 caracteres";
    }
  }

  return mensaje;

}



String indicacionesDp(String? nombreRed, String? tipoDispositivo){
  String mensaje = "";
  if(tipoDispositivo == "android"){
    mensaje = "Para conectarte a la red wifi $nombreRed en tu dispositivo Android, ve a Configuración > Wi-Fi, selecciona la red $nombreRed e ingresa la contraseña.";
  } else if (tipoDispositivo == "ios"){
    mensaje = "Para conectarte a la red wifi $nombreRed en tu dispositivo iOS, ve a Configuración > Wi-Fi, selecciona la red $nombreRed e ingresa la contraseña.";
  } else {
    mensaje = "Tipo de dispositivo no reconocido. Por favor, sigue las instrucciones generales para conectarte a una red Wi-Fi.";
  }

  return mensaje;

}