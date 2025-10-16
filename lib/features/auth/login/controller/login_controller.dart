import 'package:get/get.dart';

class LoginController extends GetxController {
  var password = ''.obs;
  var isLoading = false.obs;

  void login() {
    if (password.value.isEmpty) {
      Get.snackbar('Error', 'Please enter PIN');
      return;
    }

    isLoading.value = true;

    // Simulate login
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.offNamed('/dashboard');
    });
  }

  void addDigit(String digit) {
    if (password.value.length < 4) {
      password.value += digit;
    }
  }

  void clearPassword() {
    password.value = '';
  }
}
