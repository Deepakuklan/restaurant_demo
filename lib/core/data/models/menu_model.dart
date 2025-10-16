class MenuModel {
  final String codigo;
  final String nombreMenu;
  final String colorMenu;

  MenuModel({
    required this.codigo,
    required this.nombreMenu,
    required this.colorMenu,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      codigo: json['Codigo']?.toString() ?? '',
      nombreMenu: json['Nombre_menu']?.toString() ?? '',
      colorMenu: json['Color_Menu']?.toString() ?? '#CCCCCC',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Codigo': codigo,
      'Nombre_menu': nombreMenu,
      'Color_Menu': colorMenu,
    };
  }
}
