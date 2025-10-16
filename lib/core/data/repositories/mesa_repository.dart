import '../models/mesa_model.dart';
import '../services/database_service.dart';

class MesaRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<List<MesaModel>> getTablesBySection(String codigoZona) async {
    try {
      final sql = '''
        SELECT * FROM dbo.MESAS 
        WHERE Codigo_Zona = '$codigoZona' 
        AND Activa = 1
      ''';
      final result = await _dbService.query(sql);
      return result.map((json) => MesaModel.fromJson(json)).toList();
    } catch (e) {
      print('Get tables by section error: $e');
      rethrow;
    }
  }

  Future<List<MesaModel>> getAllActiveTables() async {
    try {
      final sql = 'SELECT * FROM dbo.MESAS WHERE Activa = 1';
      final result = await _dbService.query(sql);
      return result.map((json) => MesaModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all active tables error: $e');
      rethrow;
    }
  }
}
