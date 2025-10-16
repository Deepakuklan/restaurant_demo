class SalsaModel {
  final String codigo;
  final String nombre;

  SalsaModel({
    required this.codigo,
    required this.nombre,
  });

  factory SalsaModel.fromJson(Map<String, dynamic> json) {
    return SalsaModel(
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
