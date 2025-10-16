class ProductoModel {
  final String codigo;
  final String nombre;
  final String? codigoMenu;
  final double precio;
  final int? tieneAcompanamiento;
  final int? tieneTerminacion;
  final int? tieneMezcla;
  final int? tieneSalsa;

  ProductoModel({
    required this.codigo,
    required this.nombre,
    this.codigoMenu,
    required this.precio,
    this.tieneAcompanamiento,
    this.tieneTerminacion,
    this.tieneMezcla,
    this.tieneSalsa,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      codigo: json['Codigo']?.toString() ?? '',
      nombre: json['Nombre']?.toString() ?? '',
      codigoMenu: json['Codigo_Menu']?.toString(),
      precio: (json['Precio'] as num?)?.toDouble() ?? 0.0,
      tieneAcompanamiento: json['Tiene_Acompanamiento'] as int?,
      tieneTerminacion: json['Tiene_Terminacion'] as int?,
      tieneMezcla: json['Tiene_Mezcla'] as int?,
      tieneSalsa: json['TIENE_SALSA'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Codigo': codigo,
      'Nombre': nombre,
      'Codigo_Menu': codigoMenu,
      'Precio': precio,
      'Tiene_Acompanamiento': tieneAcompanamiento,
      'Tiene_Terminacion': tieneTerminacion,
      'Tiene_Mezcla': tieneMezcla,
      'TIENE_SALSA': tieneSalsa,
    };
  }
}
