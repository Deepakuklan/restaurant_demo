class FacturaDetalleModel {
  final String? id;
  final String facturaId;
  final int? facturaNo;
  final String codigoProducto;
  final String nombreProducto;
  final double precioVenta;
  final int cantidad;
  final double subtotal;
  final String tipoProducto;
  final double montoItbis;
  final double montoLey;
  final String? codigoCompanana;  // Code for accompaniment
  final String? codigoTermino;     // Code for cooking term
  final double totalLinea;
  final int? secuenciaProducto;
  final String? hora;
  final String? codigoSalsa;       // Code for sauce
  final String? codigoMezcla;      // Code for mix (beverages)
  final String? notaProducto;
  final int? sillaOrdeno;          // Seat number
  final int? cantidadVasos;        // Glass count
  final int eliminado;

  FacturaDetalleModel({
    this.id,
    required this.facturaId,
    this.facturaNo,
    required this.codigoProducto,
    required this.nombreProducto,
    required this.precioVenta,
    required this.cantidad,
    required this.subtotal,
    this.tipoProducto = 'P',
    this.montoItbis = 0.0,
    this.montoLey = 0.0,
    this.codigoCompanana,
    this.codigoTermino,
    required this.totalLinea,
    this.secuenciaProducto,
    this.hora,
    this.codigoSalsa,
    this.codigoMezcla,
    this.notaProducto,
    this.sillaOrdeno,
    this.cantidadVasos,
    this.eliminado = 0,
  });

  factory FacturaDetalleModel.fromJson(Map<String, dynamic> json) {
    return FacturaDetalleModel(
      id: json['Id']?.toString(),
      facturaId: json['Factura_Id']?.toString() ?? '',
      facturaNo: json['FACTURA_NO'] as int?,
      codigoProducto: json['CODIGO_PRODUCTO']?.toString() ?? '',
      nombreProducto: json['Nombre_Producto']?.toString() ?? '',
      precioVenta: (json['PRECIO_VENTA'] as num?)?.toDouble() ?? 0.0,
      cantidad: json['CANTIDAD'] as int? ?? 1,
      subtotal: (json['SUBTOTAL'] as num?)?.toDouble() ?? 0.0,
      tipoProducto: json['TIPO_PRODUCTO']?.toString() ?? 'P',
      montoItbis: (json['Monto_Itbis'] as num?)?.toDouble() ?? 0.0,
      montoLey: (json['Monto_Ley'] as num?)?.toDouble() ?? 0.0,
      codigoCompanana: json['Codigo_Companana']?.toString(),
      codigoTermino: json['Codigo_Termino']?.toString(),
      totalLinea: (json['Total_Linea'] as num?)?.toDouble() ?? 0.0,
      secuenciaProducto: json['SECUENCIA_PRODUCTO'] as int?,
      hora: json['Hora']?.toString(),
      codigoSalsa: json['Codigo_Salsa']?.toString(),
      codigoMezcla: json['Codigo_Mezcla']?.toString(),
      notaProducto: json['Nota_Producto']?.toString(),
      sillaOrdeno: json['Silla_Ordeno'] as int?,
      cantidadVasos: json['Cantidad_vasos'] as int?,
      eliminado: json['Eliminado'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Factura_Id': facturaId,
      'FACTURA_NO': facturaNo,
      'CODIGO_PRODUCTO': codigoProducto,
      'Nombre_Producto': nombreProducto,
      'PRECIO_VENTA': precioVenta,
      'CANTIDAD': cantidad,
      'SUBTOTAL': subtotal,
      'TIPO_PRODUCTO': tipoProducto,
      'Monto_Itbis': montoItbis,
      'Monto_Ley': montoLey,
      'Codigo_Companana': codigoCompanana,
      'Codigo_Termino': codigoTermino,
      'Total_Linea': totalLinea,
      'SECUENCIA_PRODUCTO': secuenciaProducto,
      'Hora': hora,
      'Codigo_Salsa': codigoSalsa,
      'Codigo_Mezcla': codigoMezcla,
      'Nota_Producto': notaProducto,
      'Silla_Ordeno': sillaOrdeno,
      'Cantidad_vasos': cantidadVasos,
      'Eliminado': eliminado,
    };
  }
}
