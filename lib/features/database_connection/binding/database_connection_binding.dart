import 'package:get/get.dart';
import '../controller/database_connection_controller.dart';

class DatabaseConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabaseConnectionController>(() => DatabaseConnectionController());
  }
}
