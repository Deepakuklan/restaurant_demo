import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../controller/terms_controller.dart';

class PremiumTermsScreen extends GetView<TermsController> {
  const PremiumTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0a0e27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0a0e27), Color(0xFF16213e), Color(0xFF0f3460)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Premium Header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
                  ),
                  border: Border(
                    bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
                      style: IconButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.1)),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppStrings.selection.tr.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: CircularProgressIndicator(
                              color: Color(0xFFFF6B00),
                              strokeWidth: 3,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Loading Options...',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Terminación section
                        if (controller.terminaciones.isNotEmpty) ...[
                          _buildSectionTitle(AppStrings.term.tr, Icons.restaurant_menu_rounded),
                          SizedBox(height: 12),
                          ...controller.terminaciones.map((term) {
                            return _buildOptionCard(
                              term.nombre,
                              controller.selectedTerminacion.value?.codigo == term.codigo,
                              () => controller.selectTerminacion(term),
                              Color(0xFF6C5CE7),
                            );
                          }),
                          SizedBox(height: 24),
                        ],

                        // Guarnición section
                        if (controller.acompanamientos.isNotEmpty) ...[
                          _buildSectionTitle(AppStrings.garnish.tr, Icons.food_bank_rounded),
                          SizedBox(height: 12),
                          ...controller.acompanamientos.map((acomp) {
                            return _buildOptionCard(
                              acomp.nombre,
                              controller.selectedAcompanamiento.value?.codigo == acomp.codigo,
                              () => controller.selectAcompanamiento(acomp),
                              Color(0xFF00B894),
                            );
                          }),
                          SizedBox(height: 24),
                        ],

                        // Salsa section
                        if (controller.salsas.isNotEmpty) ...[
                          _buildSectionTitle(AppStrings.sauce.tr, Icons.water_drop_rounded),
                          SizedBox(height: 12),
                          ...controller.salsas.map((salsa) {
                            return _buildOptionCard(
                              salsa.nombre,
                              controller.selectedSalsa.value?.codigo == salsa.codigo,
                              () => controller.selectSalsa(salsa),
                              Color(0xFFFF6B6B),
                            );
                          }),
                          SizedBox(height: 24),
                        ],

                        // Continue Button
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: controller.continueToNotes,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF6B00), Color(0xFFFF8C00)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFFF6B00).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.continueBtn.tr.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Icon(Icons.arrow_forward_rounded, size: 22),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8C00)]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFF6B00).withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(width: 10),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String name, bool isSelected, VoidCallback onTap, Color accentColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(colors: [accentColor, Color.lerp(accentColor, Colors.black, 0.2)!])
            : LinearGradient(colors: [Color(0xFF2a2d5a), Color(0xFF1f2147)]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? accentColor.withOpacity(0.6) : Colors.white.withOpacity(0.1),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [BoxShadow(color: accentColor.withOpacity(0.3), blurRadius: 12, offset: Offset(0, 4))]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(isSelected ? 0.3 : 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(0.8),
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
