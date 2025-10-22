import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../controller/notes_controller.dart';

class PremiumNotesScreen extends GetView<NotesController> {
  const PremiumNotesScreen({super.key});

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
                  border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8C00)]),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Color(0xFFFF6B00).withOpacity(0.4), blurRadius: 12, spreadRadius: 2),
                        ],
                      ),
                      child: Text(
                        AppStrings.appName.tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8C00)]),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Color(0xFFFF6B00).withOpacity(0.6), blurRadius: 6, spreadRadius: 1)],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.edit_note_rounded, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Seat Number Section
                      _buildSectionTitle(AppStrings.seatDiner.tr, Icons.event_seat_rounded),
                      SizedBox(height: 12),
                      _buildNumberInput(
                        controller.sillaComensal,
                        controller.onSillaNumberPressed,
                        controller.clearSilla,
                        Color(0xFF6C5CE7),
                      ),
                      SizedBox(height: 24),

                      // Glass Count Section
                      _buildSectionTitle(AppStrings.glassCount.tr, Icons.local_bar_rounded),
                      SizedBox(height: 6),
                      Text(
                        AppStrings.onlyIfBeverage.tr,
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      _buildNumberInput(
                        controller.cantidadVasos,
                        controller.onVasosNumberPressed,
                        controller.clearVasos,
                        Color(0xFF00B894),
                      ),
                      SizedBox(height: 24),

                      // Notes Section
                      _buildSectionTitle(AppStrings.note.tr, Icons.note_add_rounded),
                      SizedBox(height: 12),
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                        ),
                        child: TextField(
                          controller: controller.noteController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                            hintText: AppStrings.enterNoteHere.tr,
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Save Button
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.isSaving.value ? null : controller.saveOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: controller.isSaving.value
                                  ? LinearGradient(colors: [Colors.grey, Colors.grey[600]!])
                                  : LinearGradient(colors: [Color(0xFF00D084), Color(0xFF00B371)]),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: controller.isSaving.value
                                  ? []
                                  : [BoxShadow(color: Color(0xFF00D084).withOpacity(0.4), blurRadius: 15, offset: Offset(0, 8))],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              alignment: Alignment.center,
                              child: controller.isSaving.value
                                  ? SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.save_rounded, size: 22),
                                        SizedBox(width: 12),
                                        Text(
                                          AppStrings.continueBtn.tr.toUpperCase(),
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        boxShadow: [BoxShadow(color: Color(0xFFFF6B00).withOpacity(0.3), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(width: 10),
          Text(
            title.toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberInput(RxString value, Function(String) onPressed, VoidCallback onClear, Color accentColor) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [accentColor.withOpacity(0.2), accentColor.withOpacity(0.1)]),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
            ),
            child: Obx(
              () => Text(
                value.value.isEmpty ? '-' : value.value,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Column(
          children: [
            ...['7', '8', '9', '4', '5', '6', '1', '2', '3'].map((num) {
              return Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: SizedBox(
                  width: 64,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => onPressed(num),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2a2d5a),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                    ),
                    child: Text(num, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            }),
            SizedBox(
              width: 64,
              height: 44,
              child: ElevatedButton(
                onPressed: onClear,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6B6B),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                ),
                child: Icon(Icons.backspace_rounded, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
