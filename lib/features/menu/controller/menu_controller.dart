import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/data/models/menu_model.dart';
import '../../../core/data/models/mesa_model.dart';
import '../../../core/data/models/seccion_model.dart';
import '../../../core/data/repositories/menu_repository.dart';
import '../../../core/routes/app_routes.dart';

class RestaurantMenuController extends GetxController {
  final MenuRepository _menuRepo = MenuRepository();
  
  final menus = <MenuModel>[].obs;
  final isLoading = false.obs;
  
  late MesaModel currentTable;
  late SeccionModel currentSection;
  String? waiterCode;
  String? waiterName;

  @override
  void onInit() {
    super.onInit();
    
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      currentTable = args['table'] as MesaModel;
      currentSection = args['section'] as SeccionModel;
      waiterCode = args['waiterCode'];
      waiterName = args['waiterName'];
    }
    
    loadMenus();
  }

  Future<void> loadMenus() async {
    isLoading.value = true;
    
    try {
      final result = await _menuRepo.getAllMenus();
      menus.value = result;
    } catch (e) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.loadMenusError.trParams({'error': e.toString()}),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Color getMenuColor(String colorHex) {
    try {
      // Remove # if present
      String hex = colorHex.replaceAll('#', '');
      
      // Add alpha if not present
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return Colors.grey[400]!;
    }
  }

  void selectMenu(MenuModel menu) {
    Get.toNamed(
      AppRoutes.products,
      arguments: {
        'menu': menu,
        'table': currentTable,
        'section': currentSection,
        'waiterCode': waiterCode,
        'waiterName': waiterName,
      },
    );
  }

  void returnToTables() {
    Get.back();
  }
}
