import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/data/models/producto_model.dart';
import '../../../core/data/models/menu_model.dart';
import '../../../core/data/models/mesa_model.dart';
import '../../../core/data/models/seccion_model.dart';
import '../../../core/data/repositories/producto_repository.dart';
import '../../../core/routes/app_routes.dart';

class ProductsController extends GetxController {
  final ProductoRepository _productoRepo = ProductoRepository();
  
  final products = <ProductoModel>[].obs;
  final isLoading = false.obs;
  
  late MenuModel currentMenu;
  late MesaModel currentTable;
  late SeccionModel currentSection;
  String? waiterCode;
  String? waiterName;

  @override
  void onInit() {
    super.onInit();
    
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      currentMenu = args['menu'] as MenuModel;
      currentTable = args['table'] as MesaModel;
      currentSection = args['section'] as SeccionModel;
      waiterCode = args['waiterCode'];
      waiterName = args['waiterName'];
    }
    
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    
    try {
      final result = await _productoRepo.getProductsByMenu(currentMenu.codigo);
      products.value = result;
    } catch (e) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.loadProductsError.trParams({'error': e.toString()}),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectProduct(ProductoModel product) {
    Get.toNamed(
      AppRoutes.quantity,
      arguments: {
        'product': product,
        'menu': currentMenu,
        'table': currentTable,
        'section': currentSection,
        'waiterCode': waiterCode,
        'waiterName': waiterName,
      },
    );
  }
}
