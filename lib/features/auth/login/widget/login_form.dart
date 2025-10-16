import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginForm extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Enter PIN', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),
        Obx(
          () => Text('*' * controller.password.value.length, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              if (index == 9) {
                return const SizedBox.shrink();
              } else if (index == 10) {
                return ElevatedButton(
                  onPressed: () => controller.addDigit('0'),
                  child: const Text('0'),
                );
              } else if (index == 11) {
                return ElevatedButton(
                  onPressed: controller.clearPassword,
                  child: const Text('Clear'),
                );
              } else {
                return ElevatedButton(
                  onPressed: () => controller.addDigit('${index + 1}'),
                  child: Text('${index + 1}'),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => ElevatedButton(
            onPressed: controller.isLoading.value ? null : controller.login,
            child: controller.isLoading.value
                ? const CircularProgressIndicator()
                : const Text('Login'),
          ),
        ),
      ],
    );
  }
}
