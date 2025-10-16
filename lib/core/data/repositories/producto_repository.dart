import '../models/producto_model.dart';
import '../services/sqlite_database_service.dart';

class ProductoRepository {
  final SQLiteDatabaseService _dbService = SQLiteDatabaseService();

  Future<List<ProductoModel>> getProductsByMenu(String codigoMenu) async {
    try {
      final result = await _dbService.query(
        "SELECT * FROM PRODUCTOS WHERE Codigo_Menu = ?",
        [codigoMenu]
      );
      return result.map((json) => ProductoModel.fromJson(json)).toList();
    } catch (e) {
      print('Get products by menu error: $e');
      rethrow;
    }
  }

  Future<ProductoModel?> getProductByCodigo(String codigo) async {
    try {
      final sql = '''
        SELECT * FROM dbo.PRODUCTOS 
        WHERE Codigo = '$codigo'
      ''';
      final result = await _dbService.query(sql);
      
      if (result.isEmpty) {
        return null;
      }
      
      return ProductoModel.fromJson(result.first);
    } catch (e) {
      print('Get product by codigo error: $e');
      rethrow;
    }
  }
}
