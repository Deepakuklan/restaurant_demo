import 'package:get/get.dart';
import '../controller/menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantMenuController>(() => RestaurantMenuController());
  }
}
