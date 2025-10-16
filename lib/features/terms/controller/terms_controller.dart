import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/data/models/producto_model.dart';
import '../../../core/data/models/menu_model.dart';
import '../../../core/data/models/mesa_model.dart';
import '../../../core/data/models/seccion_model.dart';
import '../../../core/data/models/terminacion_model.dart';
import '../../../core/data/models/acompanamiento_model.dart';
import '../../../core/data/models/salsa_model.dart';
import '../../../core/data/repositories/terminacion_repository.dart';
import '../../../core/data/repositories/acompanamiento_repository.dart';
import '../../../core/data/repositories/salsa_repository.dart';
import '../../../core/routes/app_routes.dart';

class TermsController extends GetxController {
  final TerminacionRepository _terminacionRepo = TerminacionRepository();
  final AcompanamientoRepository _acompanamientoRepo = AcompanamientoRepository();
  final SalsaRepository _salsaRepo = SalsaRepository();
  
  final terminaciones = <TerminacionModel>[].obs;
  final acompanamientos = <AcompanamientoModel>[].obs;
  final salsas = <SalsaModel>[].obs;
  
  final selectedTerminacion = Rxn<TerminacionModel>();
  final selectedAcompanamiento = Rxn<AcompanamientoModel>();
  final selectedSalsa = Rxn<SalsaModel>();
  
  final isLoading = false.obs;
  
  late ProductoModel currentProduct;
  late int quantity;
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
      quantity = args['quantity'] as int;
      currentMenu = args['menu'] as MenuModel;
      currentTable = args['table'] as MesaModel;
      currentSection = args['section'] as SeccionModel;
      waiterCode = args['waiterCode'];
      waiterName = args['waiterName'];
    }
    
    loadOptions();
  }

  Future<void> loadOptions() async {
    isLoading.value = true;
    
    try {
      if (currentProduct.tieneTerminacion == 1) {
        final result = await _terminacionRepo.getAllTerminaciones();
        terminaciones.value = result;
      }
      
      if (currentProduct.tieneAcompanamiento == 1) {
        final result = await _acompanamientoRepo.getAllAcompanamientos();
        acompanamientos.value = result;
      }
      
      if (currentProduct.tieneSalsa == 1) {
        final result = await _salsaRepo.getAllSalsas();
        salsas.value = result;
      }
    } catch (e) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.loadOptionsError.trParams({'error': e.toString()}),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectTerminacion(TerminacionModel term) {
    selectedTerminacion.value = term;
  }

  void selectAcompanamiento(AcompanamientoModel acomp) {
    selectedAcompanamiento.value = acomp;
  }

  void selectSalsa(SalsaModel salsa) {
    selectedSalsa.value = salsa;
  }

  void continueToNotes() {
    Get.toNamed(
      AppRoutes.notes,
      arguments: {
        'product': currentProduct,
        'quantity': quantity,
        'terminacion': selectedTerminacion.value?.codigo,      // CODIGO not nombre
        'acompanamiento': selectedAcompanamiento.value?.codigo, // CODIGO not nombre
        'salsa': selectedSalsa.value?.codigo,                   // CODIGO not nombre
        'menu': currentMenu,
        'table': currentTable,
        'section': currentSection,
        'waiterCode': waiterCode,
        'waiterName': waiterName,
      },
    );
  }
}
