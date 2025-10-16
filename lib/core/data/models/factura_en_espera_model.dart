class FacturaEnEsperaModel {
  final String? id;
  final int? facturaNo;
  final DateTime? fechaFactura;
  final int codigoCliente;
  final int cobraItbis;
  final double itbisCobrado;
  final double subtotalFactura;
  final double abonadoFactura;
  final double balancePendiente;
  final int noCaja;
  final String? usuario;
  final int codigoAperturaCaja;
  final double valorFactura;
  final double impuestoLey;
  final double impuestoLeyCobrado;
  final String codigoMesa;
  final String codigoZona;
  final int estatus;
  final String codigoVendedor;
  final String? hora;
  final DateTime fechaCreacion;

  FacturaEnEsperaModel({
    this.id,
    this.facturaNo,
    this.fechaFactura,
    this.codigoCliente = 1,
    this.cobraItbis = 1,
    this.itbisCobrado = 0.0,
    this.subtotalFactura = 0.0,
    this.abonadoFactura = 0.0,
    this.balancePendiente = 0.0,
    this.noCaja = 1,
    this.usuario,
    this.codigoAperturaCaja = 1,
    this.valorFactura = 0.0,
    this.impuestoLey = 10.0,
    this.impuestoLeyCobrado = 0.0,
    required this.codigoMesa,
    required this.codigoZona,
    this.estatus = 1,
    required this.codigoVendedor,
    this.hora,
    required this.fechaCreacion,
  });

  factory FacturaEnEsperaModel.fromJson(Map<String, dynamic> json) {
    return FacturaEnEsperaModel(
      id: json['Id']?.toString(),
      facturaNo: json['FACTURA_NO'] as int?,
      fechaFactura: json['FECHA_FACTURA'] != null
          ? DateTime.parse(json['FECHA_FACTURA'].toString())
          : null,
      codigoCliente: json['CODIGO_CLIENTE'] as int? ?? 1,
      cobraItbis: json['COBRAITBIS'] as int? ?? 1,
      itbisCobrado: (json['ITBIS_COBRADO'] as num?)?.toDouble() ?? 0.0,
      subtotalFactura: (json['SUBTOTAL_FACTURA'] as num?)?.toDouble() ?? 0.0,
      abonadoFactura: (json['ABONADO_FACTURA'] as num?)?.toDouble() ?? 0.0,
      balancePendiente: (json['BALANCE_PENDIENTE'] as num?)?.toDouble() ?? 0.0,
      noCaja: json['NO_CAJA'] as int? ?? 1,
      usuario: json['USUARIO']?.toString(),
      codigoAperturaCaja: json['CODIGO_APERTURA_CAJA'] as int? ?? 1,
      valorFactura: (json['Valor_Factura'] as num?)?.toDouble() ?? 0.0,
      impuestoLey: (json['IMPUESTO_LEY'] as num?)?.toDouble() ?? 10.0,
      impuestoLeyCobrado: (json['IMPUESTO_LEY_COBRADO'] as num?)?.toDouble() ?? 0.0,
      codigoMesa: json['Codigo_Mesa']?.toString() ?? '',
      codigoZona: json['Codigo_Zona']?.toString() ?? '',
      estatus: json['Estatus'] as int? ?? 1,
      codigoVendedor: json['Codigo_Vendedor']?.toString() ?? '',
      hora: json['Hora']?.toString(),
      fechaCreacion: json['Fecha_Creacion'] != null
          ? DateTime.parse(json['Fecha_Creacion'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'FACTURA_NO': facturaNo,
      'FECHA_FACTURA': fechaFactura?.toIso8601String(),
      'CODIGO_CLIENTE': codigoCliente,
      'COBRAITBIS': cobraItbis,
      'ITBIS_COBRADO': itbisCobrado,
      'SUBTOTAL_FACTURA': subtotalFactura,
      'ABONADO_FACTURA': abonadoFactura,
      'BALANCE_PENDIENTE': balancePendiente,
      'NO_CAJA': noCaja,
      'USUARIO': usuario,
      'CODIGO_APERTURA_CAJA': codigoAperturaCaja,
      'Valor_Factura': valorFactura,
      'IMPUESTO_LEY': impuestoLey,
      'IMPUESTO_LEY_COBRADO': impuestoLeyCobrado,
      'Codigo_Mesa': codigoMesa,
      'Codigo_Zona': codigoZona,
      'Estatus': estatus,
      'Codigo_Vendedor': codigoVendedor,
      'Hora': hora,
      'Fecha_Creacion': fechaCreacion.toIso8601String(),
    };
  }
}
