import '../models/acompanamiento_model.dart';
import '../services/database_service.dart';

class AcompanamientoRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<List<AcompanamientoModel>> getAllAcompanamientos() async {
    try {
      final sql = 'SELECT * FROM dbo.Acompanamientos';
      final result = await _dbService.query(sql);
      return result.map((json) => AcompanamientoModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all acompanamientos error: $e');
      rethrow;
    }
  }
}
