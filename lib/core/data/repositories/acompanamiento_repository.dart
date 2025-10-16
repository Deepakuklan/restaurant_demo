import '../models/acompanamiento_model.dart';
import '../services/sqlite_database_service.dart';

class AcompanamientoRepository {
  final SQLiteDatabaseService _dbService = SQLiteDatabaseService();

  Future<List<AcompanamientoModel>> getAllAcompanamientos() async {
    try {
      final result = await _dbService.query(
        "SELECT * FROM Acompanamientos"
      );
      return result.map((json) => AcompanamientoModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all acompanamientos error: $e');
      rethrow;
    }
  }
}
