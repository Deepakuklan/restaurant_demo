class FacturaDetalleModel {
  final String? id;
  final String facturaId;
  final String codigoProducto;
  final String nombreProducto;
  final int cantidad;
  final double precio;
  final double subtotal;
  final String? terminacion;
  final String? acompanamiento;
  final String? salsa;
  final String? nota;
  final int? sillaComensal;
  final int? cantidadVasos;

  FacturaDetalleModel({
    this.id,
    required this.facturaId,
    required this.codigoProducto,
    required this.nombreProducto,
    required this.cantidad,
    required this.precio,
    required this.subtotal,
    this.terminacion,
    this.acompanamiento,
    this.salsa,
    this.nota,
    this.sillaComensal,
    this.cantidadVasos,
  });

  factory FacturaDetalleModel.fromJson(Map<String, dynamic> json) {
    return FacturaDetalleModel(
      id: json['Id']?.toString(),
      facturaId: json['Factura_Id']?.toString() ?? '',
      codigoProducto: json['Codigo_Producto']?.toString() ?? '',
      nombreProducto: json['Nombre_Producto']?.toString() ?? '',
      cantidad: json['Cantidad'] as int? ?? 1,
      precio: (json['Precio'] as num?)?.toDouble() ?? 0.0,
      subtotal: (json['Subtotal'] as num?)?.toDouble() ?? 0.0,
      terminacion: json['Terminacion']?.toString(),
      acompanamiento: json['Acompanamiento']?.toString(),
      salsa: json['Salsa']?.toString(),
      nota: json['Nota']?.toString(),
      sillaComensal: json['Silla_Comensal'] as int?,
      cantidadVasos: json['Cantidad_Vasos'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Factura_Id': facturaId,
      'Codigo_Producto': codigoProducto,
      'Nombre_Producto': nombreProducto,
      'Cantidad': cantidad,
      'Precio': precio,
      'Subtotal': subtotal,
      'Terminacion': terminacion,
      'Acompanamiento': acompanamiento,
      'Salsa': salsa,
      'Nota': nota,
      'Silla_Comensal': sillaComensal,
      'Cantidad_Vasos': cantidadVasos,
    };
  }
}
