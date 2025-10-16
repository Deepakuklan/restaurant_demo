import '../models/menu_model.dart';
import '../services/sqlite_database_service.dart';

class MenuRepository {
  final SQLiteDatabaseService _dbService = SQLiteDatabaseService();

  Future<List<MenuModel>> getAllMenus() async {
    try {
      final result = await _dbService.query(
        "SELECT * FROM MENU"
      );
      return result.map((json) => MenuModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all menus error: $e');
      rethrow;
    }
  }
}
