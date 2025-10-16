import '../models/salsa_model.dart';
import '../services/database_service.dart';

class SalsaRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<List<SalsaModel>> getAllSalsas() async {
    try {
      final sql = 'SELECT * FROM dbo.Salsas';
      final result = await _dbService.query(sql);
      return result.map((json) => SalsaModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all salsas error: $e');
      rethrow;
    }
  }
}
