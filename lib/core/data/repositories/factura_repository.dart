import '../models/factura_en_espera_model.dart';
import '../models/factura_detalle_model.dart';
import '../services/database_service.dart';

class FacturaRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<FacturaEnEsperaModel?> getFacturaByMesa(
      String codigoMesa, String codigoZona) async {
    try {
      final sql = '''
        SELECT * FROM dbo.FACTURA_EN_ESPERA 
        WHERE Codigo_Mesa = '$codigoMesa' 
        AND Codigo_Zona = '$codigoZona'
      ''';
      final result = await _dbService.query(sql);

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
      final sql = '''
        INSERT INTO dbo.FACTURA_EN_ESPERA 
        (Codigo_Vendedor, Codigo_Mesa, Codigo_Zona, ESTATUS, Fecha_Creacion)
        OUTPUT INSERTED.Id
        VALUES 
        ('${factura.codigoVendedor}', '${factura.codigoMesa}', 
         '${factura.codigoZona}', ${factura.estatus}, 
         '${factura.fechaCreacion.toIso8601String()}')
      ''';
      final result = await _dbService.query(sql);
      return result.first['Id'].toString();
    } catch (e) {
      print('Create factura error: $e');
      rethrow;
    }
  }

  Future<void> addDetalleToFactura(FacturaDetalleModel detalle) async {
    try {
      final sql = '''
        INSERT INTO dbo.FACTURAS_EN_ESPERA_DETALLE 
        (Factura_Id, Codigo_Producto, Nombre_Producto, Cantidad, Precio, Subtotal, 
         Terminacion, Acompanamiento, Salsa, Nota, Silla_Comensal, Cantidad_Vasos)
        VALUES 
        ('${detalle.facturaId}', '${detalle.codigoProducto}', '${detalle.nombreProducto}', 
         ${detalle.cantidad}, ${detalle.precio}, ${detalle.subtotal}, 
         ${detalle.terminacion != null ? "'${detalle.terminacion}'" : 'NULL'}, 
         ${detalle.acompanamiento != null ? "'${detalle.acompanamiento}'" : 'NULL'}, 
         ${detalle.salsa != null ? "'${detalle.salsa}'" : 'NULL'}, 
         ${detalle.nota != null ? "'${detalle.nota}'" : 'NULL'}, 
         ${detalle.sillaComensal ?? 'NULL'}, 
         ${detalle.cantidadVasos ?? 'NULL'})
      ''';
      await _dbService.execute(sql);
    } catch (e) {
      print('Add detalle to factura error: $e');
      rethrow;
    }
  }

  Future<void> updateFacturaStatus(String facturaId, int estatus) async {
    try {
      final sql = '''
        UPDATE dbo.FACTURA_EN_ESPERA 
        SET ESTATUS = $estatus 
        WHERE Id = '$facturaId'
      ''';
      await _dbService.execute(sql);
    } catch (e) {
      print('Update factura status error: $e');
      rethrow;
    }
  }

  Future<List<FacturaDetalleModel>> getFacturaDetalles(String facturaId) async {
    try {
      final sql = '''
        SELECT * FROM dbo.FACTURAS_EN_ESPERA_DETALLE 
        WHERE Factura_Id = '$facturaId'
      ''';
      final result = await _dbService.query(sql);
      return result.map((json) => FacturaDetalleModel.fromJson(json)).toList();
    } catch (e) {
      print('Get factura detalles error: $e');
      rethrow;
    }
  }
}
