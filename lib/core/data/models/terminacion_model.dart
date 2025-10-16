class TerminacionModel {
  final String codigo;
  final String nombre;

  TerminacionModel({
    required this.codigo,
    required this.nombre,
  });

  factory TerminacionModel.fromJson(Map<String, dynamic> json) {
    return TerminacionModel(
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
