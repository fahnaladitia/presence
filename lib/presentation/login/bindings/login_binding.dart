import 'package:get/get.dart';

import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../domain/usecases/auth/send_email_verification_usecase.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => SendEmailVerificationUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut(() => LoginController(Get.find(), Get.find(), Get.find()));
  }
}
