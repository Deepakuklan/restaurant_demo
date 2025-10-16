class MesaModel {
  final String codigo;
  final String codigoZona;
  final String descripcionMesa;
  final int activa;

  MesaModel({
    required this.codigo,
    required this.codigoZona,
    required this.descripcionMesa,
    required this.activa,
  });

  factory MesaModel.fromJson(Map<String, dynamic> json) {
    return MesaModel(
      codigo: json['Codigo']?.toString() ?? '',
      codigoZona: json['Codigo_Zona']?.toString() ?? '',
      descripcionMesa: json['Descripcion_MESA']?.toString() ?? '',
      activa: json['Activa'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Codigo': codigo,
      'Codigo_Zona': codigoZona,
      'Descripcion_MESA': descripcionMesa,
      'Activa': activa,
    };
  }
}
