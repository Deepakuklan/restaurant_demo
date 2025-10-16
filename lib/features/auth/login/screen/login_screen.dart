import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'.tr)),
      body: Padding(padding: const EdgeInsets.all(16.0), child: LoginForm()),
    );
  }
}
