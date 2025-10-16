import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/data/models/seccion_model.dart';
import '../../../core/data/repositories/seccion_repository.dart';
import '../../../core/routes/app_routes.dart';

class SectionsController extends GetxController {
  final SeccionRepository _seccionRepo = SeccionRepository();
  
  final sections = <SeccionModel>[].obs;
  final isLoading = false.obs;
  
  String? waiterCode;
  String? waiterName;

  @override
  void onInit() {
    super.onInit();
    
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      waiterCode = args['waiterCode'];
      waiterName = args['waiterName'];
    }
    
    loadSections();
  }

  Future<void> loadSections() async {
    isLoading.value = true;
    
    try {
      final result = await _seccionRepo.getActiveSections();
      sections.value = result;
    } catch (e) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.loadSectionsError.trParams({'error': e.toString()}),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectSection(SeccionModel section) {
    Get.toNamed(
      AppRoutes.tables,
      arguments: {
        'section': section,
        'waiterCode': waiterCode,
        'waiterName': waiterName,
      },
    );
  }
}
