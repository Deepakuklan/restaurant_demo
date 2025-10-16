import '../models/terminacion_model.dart';
import '../services/database_service.dart';

class TerminacionRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<List<TerminacionModel>> getAllTerminaciones() async {
    try {
      final sql = 'SELECT * FROM dbo.TERMINACION_PRODUCTOS';
      final result = await _dbService.query(sql);
      return result.map((json) => TerminacionModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all terminaciones error: $e');
      rethrow;
    }
  }
}
