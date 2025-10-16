class SeccionModel {
  final String codigo;
  final String nombre;
  final int activa;

  SeccionModel({
    required this.codigo,
    required this.nombre,
    required this.activa,
  });

  factory SeccionModel.fromJson(Map<String, dynamic> json) {
    return SeccionModel(
      codigo: json['Codigo']?.toString() ?? '',
      nombre: json['Nombre']?.toString() ?? '',
      activa: json['Activa'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Codigo': codigo,
      'Nombre': nombre,
      'Activa': activa,
    };
  }
}
