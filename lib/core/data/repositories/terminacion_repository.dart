import '../models/terminacion_model.dart';
import '../services/sqlite_database_service.dart';

class TerminacionRepository {
  final SQLiteDatabaseService _dbService = SQLiteDatabaseService();

  Future<List<TerminacionModel>> getAllTerminaciones() async {
    try {
      final result = await _dbService.query(
        "SELECT * FROM TERMINACION_PRODUCTOS"
      );
      return result.map((json) => TerminacionModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all terminaciones error: $e');
      rethrow;
    }
  }
}
