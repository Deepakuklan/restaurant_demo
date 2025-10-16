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
      
      await _dbService.insert('FACTURA_EN_ESPERA', {
        'Id': id,
        'Codigo_Vendedor': factura.codigoVendedor,
        'Codigo_Mesa': factura.codigoMesa,
        'Codigo_Zona': factura.codigoZona,
        'ESTATUS': factura.estatus,
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
      
      await _dbService.insert('FACTURAS_EN_ESPERA_DETALLE', {
        'Id': id,
        'Factura_Id': detalle.facturaId,
        'Codigo_Producto': detalle.codigoProducto,
        'Nombre_Producto': detalle.nombreProducto,
        'Cantidad': detalle.cantidad,
        'Precio': detalle.precio,
        'Subtotal': detalle.subtotal,
        'Terminacion': detalle.terminacion,
        'Acompanamiento': detalle.acompanamiento,
        'Salsa': detalle.salsa,
        'Nota': detalle.nota,
        'Silla_Comensal': detalle.sillaComensal,
        'Cantidad_Vasos': detalle.cantidadVasos,
      });
    } catch (e) {
      print('Add detalle to factura error: $e');
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
        'SELECT * FROM FACTURAS_EN_ESPERA_DETALLE WHERE Factura_Id = ?',
        [facturaId],
      );
      return result.map((json) => FacturaDetalleModel.fromJson(json)).toList();
    } catch (e) {
      print('Get factura detalles error: $e');
      rethrow;
    }
  }
}
