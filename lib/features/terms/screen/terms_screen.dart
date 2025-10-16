import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../controller/terms_controller.dart';

class TermsScreen extends GetView<TermsController> {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: Text(AppStrings.selection.tr),
        backgroundColor: Colors.grey[700],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Terminación section
                if (controller.terminaciones.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      AppStrings.term.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...controller.terminaciones.map((term) {
                    return Obx(() => Card(
                          color: controller.selectedTerminacion.value?.codigo == term.codigo
                              ? Colors.orange[400]
                              : Colors.white,
                          child: ListTile(
                            title: Text(
                              term.nombre,
                              style: TextStyle(
                                fontWeight: controller.selectedTerminacion.value?.codigo == term.codigo
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: () => controller.selectTerminacion(term),
                          ),
                        ));
                  }),
                  const SizedBox(height: 20),
                ],
                
                // Guarnición/Acompañamiento section
                if (controller.acompanamientos.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      AppStrings.garnish.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...controller.acompanamientos.map((acomp) {
                    return Obx(() => Card(
                          color: controller.selectedAcompanamiento.value?.codigo == acomp.codigo
                              ? Colors.orange[400]
                              : Colors.white,
                          child: ListTile(
                            title: Text(
                              acomp.nombre,
                              style: TextStyle(
                                fontWeight: controller.selectedAcompanamiento.value?.codigo == acomp.codigo
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: () => controller.selectAcompanamiento(acomp),
                          ),
                        ));
                  }),
                  const SizedBox(height: 20),
                ],
                
                // Salsa section
                if (controller.salsas.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      AppStrings.sauce.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...controller.salsas.map((salsa) {
                    return Obx(() => Card(
                          color: controller.selectedSalsa.value?.codigo == salsa.codigo
                              ? Colors.orange[400]
                              : Colors.white,
                          child: ListTile(
                            title: Text(
                              salsa.nombre,
                              style: TextStyle(
                                fontWeight: controller.selectedSalsa.value?.codigo == salsa.codigo
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: () => controller.selectSalsa(salsa),
                          ),
                        ));
                  }),
                  const SizedBox(height: 20),
                ],
                
                // Continue button
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.continueToNotes,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    AppStrings.continueBtn.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
