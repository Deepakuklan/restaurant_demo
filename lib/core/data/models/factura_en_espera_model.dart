class FacturaEnEsperaModel {
  final String? id;
  final String codigoVendedor;
  final String codigoMesa;
  final String codigoZona;
  final int estatus;
  final DateTime fechaCreacion;

  FacturaEnEsperaModel({
    this.id,
    required this.codigoVendedor,
    required this.codigoMesa,
    required this.codigoZona,
    required this.estatus,
    required this.fechaCreacion,
  });

  factory FacturaEnEsperaModel.fromJson(Map<String, dynamic> json) {
    return FacturaEnEsperaModel(
      id: json['Id']?.toString(),
      codigoVendedor: json['Codigo_Vendedor']?.toString() ?? '',
      codigoMesa: json['Codigo_Mesa']?.toString() ?? '',
      codigoZona: json['Codigo_Zona']?.toString() ?? '',
      estatus: json['ESTATUS'] as int? ?? 0,
      fechaCreacion: json['Fecha_Creacion'] != null
          ? DateTime.parse(json['Fecha_Creacion'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Codigo_Vendedor': codigoVendedor,
      'Codigo_Mesa': codigoMesa,
      'Codigo_Zona': codigoZona,
      'ESTATUS': estatus,
      'Fecha_Creacion': fechaCreacion.toIso8601String(),
    };
  }
}
