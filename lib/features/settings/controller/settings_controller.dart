import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // SQLite is now used - no configuration needed!
  // This screen can be repurposed for app settings (theme, language, etc.)
  
  final isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // No configuration to load anymore
  }

  void showDatabaseInfo() {
    Get.snackbar(
      'Database Info',
      'Using SQLite (Local Database)\nNo configuration required!',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
