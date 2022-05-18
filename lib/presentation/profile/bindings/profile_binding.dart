import 'package:get/get.dart';

import '../../../domain/usecases/auth/current_pegawai_usecase.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CurrentPegawaiUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut<ProfileController>(
        () => ProfileController(Get.find(), Get.find()));
  }
}
