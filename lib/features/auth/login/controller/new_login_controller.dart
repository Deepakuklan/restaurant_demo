import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/data/repositories/usuario_repository.dart';
import '../../../../core/data/services/database_config.dart';
import '../../../../core/data/services/database_service.dart';
import '../../../../core/routes/app_routes.dart';

class NewLoginController extends GetxController {
  final UsuarioRepository _usuarioRepo = UsuarioRepository();
  final DatabaseService _dbService = DatabaseService();
  
  final password = ''.obs;
  final isLoading = false.obs;
  
  String? currentWaiterCode;
  String? currentWaiterName;

  @override
  void onInit() {
    super.onInit();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      final config = await DatabaseConfig.load();
      if (config.database.isNotEmpty) {
        await _dbService.initialize(config);
      }
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  void onNumberPressed(String number) {
    if (password.value.length < 10) {
      password.value += number;
    }
  }

  void onClear() {
    password.value = '';
  }

  void onBackspace() {
    if (password.value.isNotEmpty) {
      password.value = password.value.substring(0, password.value.length - 1);
    }
  }

  Future<void> login() async {
    if (password.value.isEmpty) {
      Get.snackbar(
        AppStrings.error.tr,
        AppStrings.enterAccessCode.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final usuario = await _usuarioRepo.login(password.value);

      if (usuario == null) {
        Get.snackbar(
          AppStrings.error.tr,
          AppStrings.keyNotRegistered.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        password.value = '';
        return;
      }

      // Check if password/key is encrypted or exists
      if (usuario.clave == null || usuario.clave!.isEmpty) {
        Get.snackbar(
          AppStrings.error.tr,
          AppStrings.keyNotRegistered.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        password.value = '';
        return;
      }

      // Save waiter code for later use
      currentWaiterCode = usuario.codigoCamarero ?? usuario.codigoAcceso;
      currentWaiterName = usuario.nombreUsuario;

      // Navigate to sections screen with waiter info
      Get.offAllNamed(
        AppRoutes.sections,
        arguments: {
          'waiterCode': currentWaiterCode,
          'waiterName': currentWaiterName,
        },
      );
    } catch (e) {
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

  void openSettings() {
    Get.toNamed(AppRoutes.settings);
  }
}
