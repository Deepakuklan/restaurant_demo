import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatabaseConnectionController extends GetxController {
  final serverController = TextEditingController(text: 'localhost\\SQLEXPRESS');
  final databaseController = TextEditingController(text: 'RestaurantDB');
  final usernameController = TextEditingController(text: 'sa');
  final passwordController = TextEditingController(text: '');
  
  final authType = 'SQL Server'.obs;
  final isLoading = false.obs;
  final isConnected = false.obs;
  final connectionStatus = ''.obs;

  Future<void> testConnection() async {
    isLoading.value = true;
    connectionStatus.value = '';
    
    // Simulate connection attempt
    await Future.delayed(const Duration(seconds: 2));
    
    // Always succeed for demo purposes
    isConnected.value = true;
    connectionStatus.value = 'Connected to SQL Server successfully!\n'
        'Database: ${databaseController.text}\n'
        'Server: ${serverController.text}';
    
    isLoading.value = false;
    
    Get.snackbar(
      'Success',
      'SQL Server connection established',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  void saveConfiguration() {
    Get.snackbar(
      'Saved',
      'Database configuration saved successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.save, color: Colors.white),
    );
    
    // Close the screen after a delay
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }

  @override
  void onClose() {
    serverController.dispose();
    databaseController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
