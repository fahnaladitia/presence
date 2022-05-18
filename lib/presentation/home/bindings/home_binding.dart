import 'package:get/get.dart';

import '../../../domain/usecases/auth/logout_usecase.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut(() => HomeController(Get.find<LogoutUseCase>()));
  }
}
