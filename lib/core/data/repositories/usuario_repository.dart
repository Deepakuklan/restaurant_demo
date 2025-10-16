import '../models/usuario_model.dart';
import '../services/sqlite_database_service.dart';

class UsuarioRepository {
  final SQLiteDatabaseService _dbService = SQLiteDatabaseService();

  Future<UsuarioModel?> login(String codigoAcceso) async {
    try {
      final result = await _dbService.query(
        "SELECT * FROM USUARIOS WHERE Codigo_Acceso = ? AND Es_camarero = 1",
        [codigoAcceso]
      );
      
      if (result.isNotEmpty) {
        return UsuarioModel.fromMap(result.first);
      }
      return null;
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<List<UsuarioModel>> getAllWaiters() async {
    try {
      final sql = 'SELECT * FROM dbo.USUARIOS WHERE Es_camarero = 1';
      final result = await _dbService.query(sql);
      return result.map((json) => UsuarioModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all waiters error: $e');
      rethrow;
    }
  }
}
