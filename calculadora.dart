import 'dart:io';

void main() {
  double valorPedido;
  String tipoServicio;
  String calidadServicio;
  double propinaPorcentaje;
  String mensajePropina;
  String calidadProducto;
  String mensajeProducto;

  // --- Sección 1: Solicitar valor del pedido (sin cambios) ---
  print("🛒 ¡Bienvenido a la calculadora de propinas para delivery! 🛵");
  while (true) {
    try {
      stdout.write("👉 Ingrese el valor del pedido: \$");
      valorPedido = double.parse(stdin.readLineSync()!);
      if (valorPedido > 0) {
        break; 
      } else {
        print("❌ El valor debe ser mayor a cero. Inténtelo de nuevo.");
      }
    } catch (e) {
      print("❌ Entrada no válida. Por favor, ingrese un número.");
    }
  }

  // --- Sección 2: Solicitar tipo de servicio (sin cambios) ---
  while (true) {
    print("\n📦 ¿Cuál fue el tipo de servicio?");
    print("1. Comida");
    print("2. Farmacia");
    print("3. Supermercado");
    stdout.write("👉 Ingrese el número correspondiente (1-3): ");
    tipoServicio = stdin.readLineSync()!;

    if (tipoServicio == "1" || tipoServicio.toLowerCase() == "comida") {
      tipoServicio = "Comida";
      break;
    } else if (tipoServicio == "2" || tipoServicio.toLowerCase() == "farmacia") {
      tipoServicio = "Farmacia";
      break;
    } else if (tipoServicio == "3" || tipoServicio.toLowerCase() == "supermercado") {
      tipoServicio = "Supermercado";
      break;
    } else {
      print("❌ Opción incorrecta. Por favor, intente de nuevo.");
    }
  }

  // --- Sección 3: Solicitar calidad del servicio (sin cambios) ---
  while (true) {
    print("\n⭐ ¿Cómo califica la calidad del servicio?");
    print("1. Excelente (20% de propina)");
    print("2. Bueno (15% de propina)");
    print("3. Regular (10% de propina)");
    stdout.write("👉 Ingrese el número correspondiente (1-3): ");
    calidadServicio = stdin.readLineSync()!;

    if (calidadServicio == "1" || calidadServicio.toLowerCase() == "excelente") {
      propinaPorcentaje = 0.20;
      mensajePropina = "¡Genial! El repartidor apreciará mucho la propina. 😊";
      break;
    } else if (calidadServicio == "2" || calidadServicio.toLowerCase() == "bueno") {
      propinaPorcentaje = 0.15;
      mensajePropina = "¡Muy bien! Una propina justa para un buen servicio. 👍";
      break;
    } else if (calidadServicio == "3" || calidadServicio.toLowerCase() == "regular") {
      propinaPorcentaje = 0.10;
      mensajePropina = "Una propina modesta. 😉";
      break;
    } else {
      print("❌ Opción incorrecta. Por favor, intente de nuevo.");
    }
  }

  // --- Sección 4: NUEVA - Solicitar calidad del producto ---
  while (true) {
    print("\n📦 ¿Qué tal fue la calidad del producto que recibiste?");
    print("1. Excelente");
    print("2. Bueno");
    print("3. Regular");
    print("4. Malo");
    stdout.write("👉 Ingrese el número correspondiente (1-4): ");
    calidadProducto = stdin.readLineSync()!;

    switch (calidadProducto.toLowerCase()) {
      case "1":
      case "excelente":
        mensajeProducto = "¡Nos alegra que el producto haya sido de tu agrado! ⭐";
        break;
      case "2":
      case "bueno":
        mensajeProducto = "¡Qué bien! Un producto de buena calidad. 👍";
        break;
      case "3":
      case "regular":
        mensajeProducto = "Agradecemos tu honestidad. Tomaremos nota para mejorar. 🤔";
        break;
      case "4":
      case "malo":
        mensajeProducto = "Lamentamos mucho que el producto no haya cumplido tus expectativas. 😟";
        break;
      default:
        print("❌ Opción incorrecta. Por favor, intente de nuevo.");
        continue; // Vuelve al inicio del bucle
    }
    break; // Sale del bucle si la opción es válida
  }

  // --- Sección 5: Calcular y mostrar resumen (modificada) ---
  double propinaSugerida = valorPedido * propinaPorcentaje;
  double totalAPagar = valorPedido + propinaSugerida;

  print("\n**************************************************");
  print("         📄 Resumen de tu pedido y propina");
  print("**************************************************");
  print("📦 Tipo de servicio: $tipoServicio");
  print("💵 Valor del pedido: \$${valorPedido.toStringAsFixed(2)}");
  print("⭐ Calidad del servicio: ${calidadServicio.toLowerCase()}");
  print("🎁 Propina sugerida: \$${propinaSugerida.toStringAsFixed(2)}");
  print("--------------------------------------------------");
  print("💰 Total a pagar: \$${totalAPagar.toStringAsFixed(2)}");
  print("--------------------------------------------------");
  print(mensajePropina);
  print(mensajeProducto);
  print("**************************************************");
}


