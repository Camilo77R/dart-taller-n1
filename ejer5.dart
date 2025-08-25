import 'dart:io';
void main(){
  stdout.write("Digite el monto de la compra en dolares\n");
  String? montoCompraInput = stdin.readLineSync();
  if(montoCompraInput != null && montoCompraInput.trim().isNotEmpty){
     double? montoCompra = double.parse(montoCompraInput); //lo convierto a double
     //guarda el resultado con 2 decimales
      Map<String, double> resultado = descuentoCompra(montoCompra);
    print(resultado);//lo convierto a string con 2 decimales
  }
}


Map<String, double> descuentoCompra(double montoCompra){
  double montoFinal = 0;
  double precioConDescuento = 0;
  double precioIva = 0;
  double ahorro = 0;
  if(montoCompra == 0  && montoCompra <= 50){
  
    ahorro = 0;
    precioIva = montoCompra * 0.19; //calculo el iva
    montoFinal =  montoFinal + precioIva;  
  } else if (montoCompra > 51 && montoCompra <= 100){
    

    precioConDescuento = montoCompra - (montoCompra * 0.05);
    ahorro = montoCompra - precioConDescuento;
    precioIva = precioConDescuento * 0.19;
    montoFinal = precioConDescuento + precioIva;
  }else if (montoCompra > 101 && montoCompra <= 200){
    precioConDescuento = montoCompra - (montoCompra * 0.10);
    ahorro = montoCompra - precioConDescuento;
    precioIva = precioConDescuento * 0.19;
    montoFinal = precioConDescuento + precioIva;
  } else if (montoCompra > 201){

    precioConDescuento = montoCompra - (montoCompra * 0.15);
    ahorro = montoCompra - precioConDescuento;
    precioIva = precioConDescuento * 0.19;
    montoFinal = precioConDescuento + precioIva;
  }

  return {'ahorrro' : ahorro, 'montoFinal': montoFinal};
}