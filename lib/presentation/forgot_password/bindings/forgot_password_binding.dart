import 'package:get/get.dart';

import '../../../domain/usecases/auth/reset_password_usecase.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordUsecase(Get.find()));
    Get.lazyPut<ForgotPasswordController>(
        () => ForgotPasswordController(Get.find()));
  }
}
