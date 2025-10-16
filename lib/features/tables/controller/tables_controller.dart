import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/data/models/mesa_model.dart';
import '../../../core/data/models/seccion_model.dart';
import '../../../core/data/repositories/mesa_repository.dart';
import '../../../core/data/repositories/factura_repository.dart';
import '../../../core/routes/app_routes.dart';

class TablesController extends GetxController {
  final MesaRepository _mesaRepo = MesaRepository();
  final FacturaRepository _facturaRepo = FacturaRepository();
  
  final tables = <MesaModel>[].obs;
  final tableStatuses = <String, int>{}.obs; // mesa codigo -> status (1=occupied/red, 2=yellow)
  final isLoading = false.obs;
  
  late SeccionModel currentSection;
  String? waiterCode;
  String? waiterName;

  @override
  void onInit() {
    super.onInit();
    
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      currentSection = args['section'] as SeccionModel;
      waiterCode = args['waiterCode'];
      waiterName = args['waiterName'];
    }
    
    loadTables();
  }

  Future<void> loadTables() async {
    isLoading.value = true;
    
    try {
      final result = await _mesaRepo.getTablesBySection(currentSection.codigo);
      tables.value = result;
      
      // Load status for each table
      await _loadTableStatuses();
    } catch (e) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.loadTablesError.trParams({'error': e.toString()}),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadTableStatuses() async {
    for (var table in tables) {
      try {
        final factura = await _facturaRepo.getFacturaByMesa(
          table.codigo,
          currentSection.codigo,
        );
        
        if (factura != null) {
          tableStatuses[table.codigo] = factura.estatus;
        } else {
          tableStatuses[table.codigo] = 0; // Available (green)
        }
      } catch (e) {
        tableStatuses[table.codigo] = 0;
      }
    }
  }

  Color getTableColor(String mesaCodigo) {
    final status = tableStatuses[mesaCodigo] ?? 0;
    
    switch (status) {
      case 1: // Occupied
        return Colors.red;
      case 2: // About to be released
        return Colors.yellow[700]!;
      default: // Available
        return Colors.green;
    }
  }

  void selectTable(MesaModel table) {
    Get.toNamed(
      AppRoutes.menu,
      arguments: {
        'table': table,
        'section': currentSection,
        'waiterCode': waiterCode,
        'waiterName': waiterName,
      },
    );
  }
}
