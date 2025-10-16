import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/database_connection_controller.dart';

class DatabaseConnectionScreen extends GetView<DatabaseConnectionController> {
  const DatabaseConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('SQL Server Connection'),
        backgroundColor: Colors.grey[850],
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back()),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SQL Server Logo/Icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.red[700], shape: BoxShape.circle),
                    child: const Icon(Icons.storage, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Microsoft SQL Server',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Database Connection',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 32),

                  // Server Name
                  _buildTextField(
                    controller: controller.serverController,
                    label: 'Server Name',
                    hint: 'localhost\\SQLEXPRESS',
                    icon: Icons.dns,
                  ),
                  const SizedBox(height: 16),

                  // Database Name
                  _buildTextField(
                    controller: controller.databaseController,
                    label: 'Database Name',
                    hint: 'RestaurantDB',
                    icon: Icons.storage_outlined,
                  ),
                  const SizedBox(height: 16),

                  // Authentication Type
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[600]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.security, color: Colors.blue[300], size: 20),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Auth',
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ),
                          DropdownButton<String>(
                            value: controller.authType.value,
                            dropdownColor: Colors.grey[700],
                            underline: const SizedBox(),
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                            items: const [
                              DropdownMenuItem(
                                value: 'SQL Server',
                                child: Text('SQL Server'),
                              ),
                              DropdownMenuItem(
                                value: 'Windows',
                                child: Text('Windows'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) controller.authType.value = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Username
                  Obx(
                    () => controller.authType.value == 'SQL Server'
                        ? Column(
                            children: [
                              _buildTextField(
                                controller: controller.usernameController,
                                label: 'Username',
                                hint: 'sa',
                                icon: Icons.person,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: controller.passwordController,
                                label: 'Password',
                                hint: '••••••••',
                                icon: Icons.lock,
                                isPassword: true,
                              ),
                              const SizedBox(height: 16),
                            ],
                          )
                        : const SizedBox(height: 16),
                  ),

                  // Connection Status
                  Obx(() {
                    if (controller.connectionStatus.value.isNotEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: controller.isConnected.value
                              ? Colors.green.withOpacity(0.2)
                              : Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: controller.isConnected.value ? Colors.green : Colors.orange,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              controller.isConnected.value ? Icons.check_circle : Icons.info,
                              color: controller.isConnected.value ? Colors.green : Colors.orange,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                controller.connectionStatus.value,
                                style: TextStyle(
                                  color: controller.isConnected.value
                                      ? Colors.green[100]
                                      : Colors.orange[100],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  }),

                  // Test Connection Button
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.isLoading.value ? null : controller.testConnection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 2,
                        ),
                        icon: controller.isLoading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.cable),
                        label: Text(
                          controller.isLoading.value ? 'Connecting...' : 'Test Connection',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Save Configuration Button
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.isConnected.value
                            ? controller.saveConfiguration
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 2,
                        ),
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Save Configuration',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Info Text
                  Text(
                    'Note: Connection settings are saved locally',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: Icon(icon, color: Colors.blue[300], size: 20),
            filled: true,
            fillColor: Colors.grey[700],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[600]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[600]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue[400]!, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
