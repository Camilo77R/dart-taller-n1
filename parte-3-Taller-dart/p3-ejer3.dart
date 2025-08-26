enum TipoTransaccion {
  Ingreso,
  Gasto
}

enum Categoria {
  Comida,
  Transporte,
  Servicios,
  Ocio,
  Salario,
  Otros
}

class Usuario {
  String nombre;
  List<Cuenta> cuentas = [];

  Usuario(this.nombre);

  double obtenerSaldoTotal() {
    double total = 0;
    for (var cuenta in cuentas) {
      total += cuenta.saldo;
    }
    return total;
  }
}

class Cuenta {
  String nombre;
  double saldo;
  List<Transaccion> movimientos = [];
  double limiteMinimo;

  Cuenta(this.nombre, this.saldo, {this.limiteMinimo = 0});

  bool agregarTransaccion(Transaccion transaccion) {
    if (transaccion.tipo == TipoTransaccion.Gasto) {
      if (saldo - transaccion.monto < limiteMinimo) {
        print("⚠️ Alerta: La transacción causaría sobregiro");
        return false;
      }
      saldo -= transaccion.monto;
    } else {
      saldo += transaccion.monto;
    }
    movimientos.add(transaccion);
    return true;
  }
}

class Transaccion {
  DateTime fecha;
  double monto;
  String descripcion;
  TipoTransaccion tipo;
  Categoria categoria;

  Transaccion(this.monto, this.descripcion, this.tipo, this.categoria) 
    : fecha = DateTime.now();
}

class Presupuesto {
  Categoria categoria;
  double limite;
  double gastado = 0;
  DateTime mes;

  Presupuesto(this.categoria, this.limite) : mes = DateTime.now();

  bool excedido() => gastado > limite;
  double porcentajeUsado() => (gastado / limite) * 100;
}

class GestorFinanzas {
  Usuario usuario;
  List<Presupuesto> presupuestos = [];
  Map<String, double> metasAhorro = {};

  GestorFinanzas(this.usuario);

  void crearCuenta(String nombre, double saldoInicial, {double limiteMinimo = 0}) {
    usuario.cuentas.add(Cuenta(nombre, saldoInicial, limiteMinimo: limiteMinimo));
  }

  bool registrarGasto(Cuenta cuenta, double monto, String descripcion, Categoria categoria) {
    var transaccion = Transaccion(monto, descripcion, TipoTransaccion.Gasto, categoria);
    if (cuenta.agregarTransaccion(transaccion)) {
      actualizarPresupuesto(categoria, monto);
      return true;
    }
    return false;
  }

  void actualizarPresupuesto(Categoria categoria, double monto) {
    for (var presupuesto in presupuestos) {
      if (presupuesto.categoria == categoria) {
        presupuesto.gastado += monto;
        if (presupuesto.excedido()) {
          print("⚠️ Alerta: Presupuesto de ${categoria} excedido");
        } else if (presupuesto.porcentajeUsado() > 80) {
          print("⚠️ Advertencia: Presupuesto de ${categoria} al ${presupuesto.porcentajeUsado().toStringAsFixed(1)}%");
        }
      }
    }
  }

  Map<String, dynamic> generarReporteFinanciero() {
    double totalIngresos = 0;
    double totalGastos = 0;
    Map<Categoria, double> gastosPorCategoria = {};

    for (var cuenta in usuario.cuentas) {
      for (var movimiento in cuenta.movimientos) {
        if (movimiento.tipo == TipoTransaccion.Ingreso) {
          totalIngresos += movimiento.monto;
        } else {
          totalGastos += movimiento.monto;
          gastosPorCategoria[movimiento.categoria] = 
            (gastosPorCategoria[movimiento.categoria] ?? 0) + movimiento.monto;
        }
      }
    }

    return {
      'saldo_total': usuario.obtenerSaldoTotal(),
      'ingresos': totalIngresos,
      'gastos': totalGastos,
      'gastos_por_categoria': gastosPorCategoria,
    };
  }
}

void main() {
  var usuario = Usuario("Juan");
  var gestor = GestorFinanzas(usuario);

  // Crear cuentas
  gestor.crearCuenta("Cuenta Principal", 1000, limiteMinimo: 100);
  gestor.crearCuenta("Cuenta Ahorro", 500);

  // Establecer presupuestos
  gestor.presupuestos.add(Presupuesto(Categoria.Comida, 300));
  gestor.presupuestos.add(Presupuesto(Categoria.Transporte, 150));

  // Registrar gastos
  print("\n=== Registrando Transacciones ===");
  gestor.registrarGasto(usuario.cuentas[0], 250, "Supermercado", Categoria.Comida);
  gestor.registrarGasto(usuario.cuentas[0], 80, "Gasolina", Categoria.Transporte);

  // Generar reporte
  print("\n=== Reporte Financiero ===");
  var reporte = gestor.generarReporteFinanciero();
  print("Saldo Total: \$${reporte['saldo_total']}");
  print("Total Gastos: \$${reporte['gastos']}");
  
  // Mostrar gastos por categoría
  print("\n=== Gastos por Categoría ===");
  (reporte['gastos_por_categoria'] as Map<Categoria, double>).forEach((cat, monto) {
    print("$cat: \$${monto}");
  });
}