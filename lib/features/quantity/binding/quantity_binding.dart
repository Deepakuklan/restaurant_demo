import 'package:get/get.dart';
import '../controller/quantity_controller.dart';

class QuantityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuantityController>(() => QuantityController());
  }
}
