class AcompanamientoModel {
  final String codigo;
  final String nombre;

  AcompanamientoModel({
    required this.codigo,
    required this.nombre,
  });

  factory AcompanamientoModel.fromJson(Map<String, dynamic> json) {
    return AcompanamientoModel(
      codigo: json['Codigo']?.toString() ?? '',
      nombre: json['Nombre']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Codigo': codigo,
      'Nombre': nombre,
    };
  }
}
