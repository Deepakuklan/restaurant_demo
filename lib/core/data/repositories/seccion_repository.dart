import '../models/seccion_model.dart';
import '../services/database_service.dart';

class SeccionRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<List<SeccionModel>> getActiveSections() async {
    try {
      final sql = 'SELECT * FROM dbo.SECCIONES WHERE Activa = 1';
      final result = await _dbService.query(sql);
      return result.map((json) => SeccionModel.fromJson(json)).toList();
    } catch (e) {
      print('Get active sections error: $e');
      rethrow;
    }
  }

  Future<List<SeccionModel>> getAllSections() async {
    try {
      final sql = 'SELECT * FROM dbo.SECCIONES';
      final result = await _dbService.query(sql);
      return result.map((json) => SeccionModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all sections error: $e');
      rethrow;
    }
  }
}
