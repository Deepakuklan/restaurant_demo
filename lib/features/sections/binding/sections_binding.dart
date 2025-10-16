import 'package:get/get.dart';
import '../controller/sections_controller.dart';

class SectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SectionsController>(() => SectionsController());
  }
}
