import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/data/services/database_config.dart';
import '../../../core/data/services/database_service.dart';

class SettingsController extends GetxController {
  final DatabaseService _dbService = DatabaseService();
  
  final instanceController = TextEditingController();
  final databaseController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final portController = TextEditingController();
  
  final isLoading = false.obs;
  final testResult = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadConfig();
  }

  Future<void> loadConfig() async {
    final config = await DatabaseConfig.load();
    instanceController.text = config.instance;
    databaseController.text = config.database;
    usernameController.text = config.username;
    passwordController.text = config.password;
    portController.text = config.port.toString();
  }

  Future<void> testConnection() async {
    testResult.value = '';
    isLoading.value = true;
    
    try {
      final config = DatabaseConfig(
        instance: instanceController.text,
        database: databaseController.text,
        username: usernameController.text,
        password: passwordController.text,
        port: int.tryParse(portController.text) ?? 1433,
      );
      
      final success = await _dbService.testConnection(config);
      
      if (success) {
        testResult.value = AppStrings.connectionSuccessful.tr;
        Get.snackbar(
          AppStrings.success.tr,
          AppStrings.connectionSuccessfulMsg.tr,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        testResult.value = AppStrings.connectionFailed.tr;
        Get.snackbar(
          AppStrings.error.tr,
          AppStrings.connectionFailedMsg.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      testResult.value = AppStrings.error.tr;
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.connectionError.trParams({'error': e.toString()}),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveConfig() async {
    try {
      final config = DatabaseConfig(
        instance: instanceController.text,
        database: databaseController.text,
        username: usernameController.text,
        password: passwordController.text,
        port: int.tryParse(portController.text) ?? 1433,
      );
      
      await config.save();
      await _dbService.initialize(config);
      
      Get.snackbar(
        AppStrings.success.tr,
        AppStrings.configurationSaved.tr,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      Get.back();
    } catch (e) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.saveConfigError.trParams({'error': e.toString()}),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    instanceController.dispose();
    databaseController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    portController.dispose();
    super.onClose();
  }
}
