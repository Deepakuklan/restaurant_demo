import '../models/factura_en_espera_model.dart';
import '../models/factura_detalle_model.dart';
import '../services/sqlite_database_service.dart';

class FacturaRepository {
  final SQLiteDatabaseService _dbService = SQLiteDatabaseService();

  Future<FacturaEnEsperaModel?> getFacturaByMesa(
      String codigoMesa, String codigoZona) async {
    try {
      final result = await _dbService.query(
        'SELECT * FROM FACTURA_EN_ESPERA WHERE Codigo_Mesa = ? AND Codigo_Zona = ?',
        [codigoMesa, codigoZona],
      );

      if (result.isEmpty) {
        return null;
      }

      return FacturaEnEsperaModel.fromJson(result.first);
    } catch (e) {
      print('Get factura by mesa error: $e');
      rethrow;
    }
  }

  Future<String> createFactura(FacturaEnEsperaModel factura) async {
    try {
      // Generate unique ID
      final id = 'F${DateTime.now().millisecondsSinceEpoch}';
      
      // Get current time in "hh:mm:ss AMPM" format
      final now = DateTime.now();
      final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
      final ampm = now.hour >= 12 ? 'PM' : 'AM';
      final hora = '${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} $ampm';
      
      // Get next factura number (simple incrementing)
      final facturas = await _dbService.query('SELECT MAX(FACTURA_NO) as max_no FROM FACTURA_EN_ESPERA');
      final maxNo = facturas.isNotEmpty && facturas.first['max_no'] != null 
          ? facturas.first['max_no'] as int 
          : 0;
      final facturaNo = maxNo + 1;
      
      await _dbService.insert('FACTURA_EN_ESPERA', {
        'Id': id,
        'FACTURA_NO': facturaNo,
        'FECHA_FACTURA': DateTime.now().toIso8601String(),
        'CODIGO_CLIENTE': factura.codigoCliente,
        'COBRAITBIS': factura.cobraItbis,
        'ITBIS_COBRADO': factura.itbisCobrado,
        'SUBTOTAL_FACTURA': factura.subtotalFactura,
        'ABONADO_FACTURA': factura.abonadoFactura,
        'BALANCE_PENDIENTE': factura.balancePendiente,
        'NO_CAJA': factura.noCaja,
        'USUARIO': factura.usuario,
        'CODIGO_APERTURA_CAJA': factura.codigoAperturaCaja,
        'Valor_Factura': factura.valorFactura,
        'IMPUESTO_LEY': factura.impuestoLey,
        'IMPUESTO_LEY_COBRADO': factura.impuestoLeyCobrado,
        'Codigo_Mesa': factura.codigoMesa,
        'Codigo_Zona': factura.codigoZona,
        'Estatus': factura.estatus,
        'Codigo_Vendedor': factura.codigoVendedor,
        'Hora': hora,
        'Fecha_Creacion': factura.fechaCreacion.toIso8601String(),
      });
      
      return id;
    } catch (e) {
      print('Create factura error: $e');
      rethrow;
    }
  }

  Future<void> addDetalleToFactura(FacturaDetalleModel detalle) async {
    try {
      // Generate unique ID for detalle
      final id = 'FD${DateTime.now().millisecondsSinceEpoch}';
      
      // Get current time in "hh:mm:ss AMPM" format
      final now = DateTime.now();
      final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
      final ampm = now.hour >= 12 ? 'PM' : 'AM';
      final hora = '${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} $ampm';
      
      await _dbService.insert('FACTURAS_EN_ESPERA_DETALLE', {
        'Id': id,
        'Factura_Id': detalle.facturaId,
        'FACTURA_NO': detalle.facturaNo,
        'CODIGO_PRODUCTO': detalle.codigoProducto,
        'Nombre_Producto': detalle.nombreProducto,
        'PRECIO_VENTA': detalle.precioVenta,
        'CANTIDAD': detalle.cantidad,
        'SUBTOTAL': detalle.subtotal,
        'TIPO_PRODUCTO': detalle.tipoProducto,
        'Monto_Itbis': detalle.montoItbis,
        'Monto_Ley': detalle.montoLey,
        'Codigo_Companana': detalle.codigoCompanana,
        'Codigo_Termino': detalle.codigoTermino,
        'Total_Linea': detalle.totalLinea,
        'SECUENCIA_PRODUCTO': detalle.secuenciaProducto,
        'Hora': hora,
        'Codigo_Salsa': detalle.codigoSalsa,
        'Codigo_Mezcla': detalle.codigoMezcla,
        'Nota_Producto': detalle.notaProducto,
        'Silla_Ordeno': detalle.sillaOrdeno,
        'Cantidad_vasos': detalle.cantidadVasos,
        'Eliminado': detalle.eliminado,
      });
      
      // Update factura totals
      await _updateFacturaTotals(detalle.facturaId);
    } catch (e) {
      print('Add detalle to factura error: $e');
      rethrow;
    }
  }
  
  Future<void> _updateFacturaTotals(String facturaId) async {
    try {
      // Get all non-deleted detalles for this factura
      final detalles = await getFacturaDetalles(facturaId);
      
      // Calculate totals
      double subtotal = 0.0;
      double itbisCobrado = 0.0;
      double leyCobrado = 0.0;
      
      for (var detalle in detalles) {
        if (detalle.eliminado == 0) {
          subtotal += detalle.subtotal;
          itbisCobrado += detalle.montoItbis * detalle.cantidad;
          leyCobrado += detalle.montoLey * detalle.cantidad;
        }
      }
      
      final valorFactura = subtotal + itbisCobrado + leyCobrado;
      
      // Get current time
      final now = DateTime.now();
      final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
      final ampm = now.hour >= 12 ? 'PM' : 'AM';
      final hora = '${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} $ampm';
      
      // Update factura
      await _dbService.update(
        'FACTURA_EN_ESPERA',
        {
          'SUBTOTAL_FACTURA': subtotal,
          'ITBIS_COBRADO': itbisCobrado,
          'IMPUESTO_LEY_COBRADO': leyCobrado,
          'Valor_Factura': valorFactura,
          'BALANCE_PENDIENTE': valorFactura, // No payment yet
          'Hora': hora,
        },
        'Id = ?',
        [facturaId],
      );
    } catch (e) {
      print('Update factura totals error: $e');
      rethrow;
    }
  }

  Future<void> updateFacturaStatus(String facturaId, int estatus) async {
    try {
      await _dbService.update(
        'FACTURA_EN_ESPERA',
        {'ESTATUS': estatus},
        'Id = ?',
        [facturaId],
      );
    } catch (e) {
      print('Update factura status error: $e');
      rethrow;
    }
  }

  Future<List<FacturaDetalleModel>> getFacturaDetalles(String facturaId) async {
    try {
      final result = await _dbService.query(
        'SELECT * FROM FACTURAS_EN_ESPERA_DETALLE WHERE Factura_Id = ? AND Eliminado = 0 ORDER BY SECUENCIA_PRODUCTO',
        [facturaId],
      );
      return result.map((json) => FacturaDetalleModel.fromJson(json)).toList();
    } catch (e) {
      print('Get factura detalles error: $e');
      rethrow;
    }
  }
  
  Future<void> deleteDetalle(String detalleId) async {
    try {
      // Mark as deleted instead of actually deleting
      await _dbService.update(
        'FACTURAS_EN_ESPERA_DETALLE',
        {'Eliminado': 1},
        'Id = ?',
        [detalleId],
      );
      
      // Get factura_id to update totals
      final result = await _dbService.query(
        'SELECT Factura_Id FROM FACTURAS_EN_ESPERA_DETALLE WHERE Id = ?',
        [detalleId],
      );
      
      if (result.isNotEmpty) {
        await _updateFacturaTotals(result.first['Factura_Id'].toString());
      }
    } catch (e) {
      print('Delete detalle error: $e');
      rethrow;
    }
  }
  
  Future<void> updateDetalleQuantity(String detalleId, int newQuantity) async {
    try {
      // Get current detalle
      final result = await _dbService.query(
        'SELECT * FROM FACTURAS_EN_ESPERA_DETALLE WHERE Id = ?',
        [detalleId],
      );
      
      if (result.isEmpty) return;
      
      final detalle = FacturaDetalleModel.fromJson(result.first);
      
      // Recalculate with new quantity
      final subtotal = detalle.precioVenta * newQuantity;
      final totalLinea = subtotal + (detalle.montoItbis * newQuantity) + (detalle.montoLey * newQuantity);
      
      await _dbService.update(
        'FACTURAS_EN_ESPERA_DETALLE',
        {
          'CANTIDAD': newQuantity,
          'SUBTOTAL': subtotal,
          'Total_Linea': totalLinea,
        },
        'Id = ?',
        [detalleId],
      );
      
      // Update factura totals
      await _updateFacturaTotals(detalle.facturaId);
    } catch (e) {
      print('Update detalle quantity error: $e');
      rethrow;
    }
  }
}
