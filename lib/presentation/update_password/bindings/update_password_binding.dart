import 'package:get/get.dart';

import '../../../domain/usecases/auth/update_password_usecase.dart';
import '../controllers/update_password_controller.dart';

class UpdatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdatePasswordUseCase(Get.find()));
    Get.lazyPut<UpdatePasswordController>(
      () => UpdatePasswordController(Get.find()),
    );
  }
}
