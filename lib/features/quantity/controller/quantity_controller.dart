import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/data/models/producto_model.dart';
import '../../../core/data/models/menu_model.dart';
import '../../../core/data/models/mesa_model.dart';
import '../../../core/data/models/seccion_model.dart';
import '../../../core/routes/app_routes.dart';

class QuantityController extends GetxController {
  final quantity = '1'.obs;
  
  late ProductoModel currentProduct;
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
      currentProduct = args['product'] as ProductoModel;
      currentMenu = args['menu'] as MenuModel;
      currentTable = args['table'] as MesaModel;
      currentSection = args['section'] as SeccionModel;
      waiterCode = args['waiterCode'];
      waiterName = args['waiterName'];
    }
  }

  void onNumberPressed(String number) {
    if (quantity.value == '1' && quantity.value.length == 1) {
      quantity.value = number;
    } else if (quantity.value.length < 3) {
      quantity.value += number;
    }
  }

  void onClear() {
    quantity.value = '1';
  }

  void onBackspace() {
    if (quantity.value.length > 1) {
      quantity.value = quantity.value.substring(0, quantity.value.length - 1);
    } else {
      quantity.value = '1';
    }
  }

  void addToOrder() {
    final qty = int.tryParse(quantity.value) ?? 1;
    
    if (qty <= 0) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.quantityGreaterZero.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Check if product has terms, accompaniments, or sauces
    if (currentProduct.tieneTerminacion == 1 ||
        currentProduct.tieneAcompanamiento == 1 ||
        currentProduct.tieneSalsa == 1) {
      // Navigate to terms screen
      Get.toNamed(
        AppRoutes.terms,
        arguments: {
          'product': currentProduct,
          'quantity': qty,
          'menu': currentMenu,
          'table': currentTable,
          'section': currentSection,
          'waiterCode': waiterCode,
          'waiterName': waiterName,
        },
      );
    } else {
      // Go directly to notes screen
      Get.toNamed(
        AppRoutes.notes,
        arguments: {
          'product': currentProduct,
          'quantity': qty,
          'menu': currentMenu,
          'table': currentTable,
          'section': currentSection,
          'waiterCode': waiterCode,
          'waiterName': waiterName,
        },
      );
    }
  }

  void cancel() {
    Get.back();
  }
}
