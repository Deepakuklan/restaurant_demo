import '../models/mesa_model.dart';
import '../services/sqlite_database_service.dart';

class MesaRepository {
  final SQLiteDatabaseService _dbService = SQLiteDatabaseService();

  Future<List<MesaModel>> getTablesBySection(String codigoZona) async {
    try {
      final result = await _dbService.query(
        "SELECT * FROM MESAS WHERE Codigo_Zona = ? AND Activa = 1",
        [codigoZona]
      );
      return result.map((json) => MesaModel.fromJson(json)).toList();
    } catch (e) {
      print('Get tables by section error: $e');
      rethrow;
    }
  }

  Future<List<MesaModel>> getAllActiveTables() async {
    try {
      final result = await _dbService.query(
        "SELECT * FROM MESAS WHERE Activa = 1"
      );
      return result.map((json) => MesaModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all active tables error: $e');
      rethrow;
    }
  }
}
