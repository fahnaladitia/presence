import 'package:get/get.dart';

import '../../../domain/usecases/auth/new_password_usecase.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewPasswordUseCase(Get.find()));
    Get.lazyPut(() => NewPasswordController(Get.find<NewPasswordUseCase>()));
  }
}
