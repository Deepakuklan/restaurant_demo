import '../models/salsa_model.dart';
import '../services/sqlite_database_service.dart';

class SalsaRepository {
  final SQLiteDatabaseService _dbService = SQLiteDatabaseService();

  Future<List<SalsaModel>> getAllSalsas() async {
    try {
      final result = await _dbService.query(
        "SELECT * FROM Salsas"
      );
      return result.map((json) => SalsaModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all salsas error: $e');
      rethrow;
    }
  }
}
