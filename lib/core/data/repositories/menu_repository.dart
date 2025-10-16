import '../models/menu_model.dart';
import '../services/database_service.dart';

class MenuRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<List<MenuModel>> getAllMenus() async {
    try {
      final sql = 'SELECT * FROM dbo.MENU';
      final result = await _dbService.query(sql);
      return result.map((json) => MenuModel.fromJson(json)).toList();
    } catch (e) {
      print('Get all menus error: $e');
      rethrow;
    }
  }
}
