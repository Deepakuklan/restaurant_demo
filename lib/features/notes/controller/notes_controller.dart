import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/data/models/producto_model.dart';
import '../../../core/data/models/menu_model.dart';
import '../../../core/data/models/mesa_model.dart';
import '../../../core/data/models/seccion_model.dart';
import '../../../core/data/models/factura_en_espera_model.dart';
import '../../../core/data/models/factura_detalle_model.dart';
import '../../../core/data/repositories/factura_repository.dart';
import '../../../core/routes/app_routes.dart';

class NotesController extends GetxController {
  final FacturaRepository _facturaRepo = FacturaRepository();
  
  final noteController = TextEditingController();
  final sillaComensal = ''.obs;
  final cantidadVasos = ''.obs;
  final isSaving = false.obs;
  
  late ProductoModel currentProduct;
  late int quantity;
  String? terminacion;
  String? acompanamiento;
  String? salsa;
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
      terminacion = args['terminacion'] as String?;
      acompanamiento = args['acompanamiento'] as String?;
      salsa = args['salsa'] as String?;
      currentMenu = args['menu'] as MenuModel;
      currentTable = args['table'] as MesaModel;
      currentSection = args['section'] as SeccionModel;
      waiterCode = args['waiterCode'];
      waiterName = args['waiterName'];
    }
  }

  void onSillaNumberPressed(String number) {
    if (sillaComensal.value.length < 2) {
      if (sillaComensal.value == '0' || sillaComensal.value.isEmpty) {
        sillaComensal.value = number;
      } else {
        sillaComensal.value += number;
      }
    }
  }

  void clearSilla() {
    sillaComensal.value = '';
  }

  void onVasosNumberPressed(String number) {
    if (cantidadVasos.value.length < 2) {
      if (cantidadVasos.value == '0' || cantidadVasos.value.isEmpty) {
        cantidadVasos.value = number;
      } else {
        cantidadVasos.value += number;
      }
    }
  }

  void clearVasos() {
    cantidadVasos.value = '';
  }

  Future<void> saveOrder() async {
    isSaving.value = true;

    try {
      // Get or create factura
      var factura = await _facturaRepo.getFacturaByMesa(
        currentTable.codigo,
        currentSection.codigo,
      );

      String facturaId;
      if (factura == null) {
        // Create new factura
        factura = FacturaEnEsperaModel(
          codigoVendedor: waiterCode ?? '',
          codigoMesa: currentTable.codigo,
          codigoZona: currentSection.codigo,
          estatus: 1, // Occupied
          fechaCreacion: DateTime.now(),
        );
        facturaId = await _facturaRepo.createFactura(factura);
      } else {
        facturaId = factura.id!;
      }

      // Create detalle
      final detalle = FacturaDetalleModel(
        facturaId: facturaId,
        codigoProducto: currentProduct.codigo,
        nombreProducto: currentProduct.nombre,
        cantidad: quantity,
        precio: currentProduct.precio,
        subtotal: currentProduct.precio * quantity,
        terminacion: terminacion,
        acompanamiento: acompanamiento,
        salsa: salsa,
        nota: noteController.text.isEmpty ? null : noteController.text,
        sillaComensal: int.tryParse(sillaComensal.value),
        cantidadVasos: int.tryParse(cantidadVasos.value),
      );

      await _facturaRepo.addDetalleToFactura(detalle);

      Get.snackbar(
        AppStrings.success.tr,
        AppStrings.productAdded.tr,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Return to menu
      Get.until((route) => route.settings.name == AppRoutes.menu);
    } catch (e) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.saveOrderError.trParams({'error': e.toString()}),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
