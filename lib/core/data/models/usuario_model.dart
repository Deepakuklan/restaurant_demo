class UsuarioModel {
  final String codigoAcceso;
  final String? clave;
  final String? nombreUsuario;
  final String? codigoCamarero;
  final int? esCamarero;
  final int? tarjetaAdmin;

  UsuarioModel({
    required this.codigoAcceso,
    this.clave,
    this.nombreUsuario,
    this.codigoCamarero,
    this.esCamarero,
    this.tarjetaAdmin,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      codigoAcceso: json['Codigo_Acceso']?.toString() ?? '',
      clave: json['Clave']?.toString(),
      nombreUsuario: json['Nombre_Usuario']?.toString(),
      codigoCamarero: json['Codigo_Camarero']?.toString(),
      esCamarero: json['Es_camarero'] as int?,
      tarjetaAdmin: json['Tarjeta_Admin'] as int?,
    );
  }

  // Alias for fromJson to work with SQLite
  factory UsuarioModel.fromMap(Map<String, dynamic> map) => UsuarioModel.fromJson(map);

  Map<String, dynamic> toJson() {
    return {
      'Codigo_Acceso': codigoAcceso,
      'Clave': clave,
      'Nombre_Usuario': nombreUsuario,
      'Codigo_Camarero': codigoCamarero,
      'Es_camarero': esCamarero,
      'Tarjeta_Admin': tarjetaAdmin,
    };
  }
}
