import 'package:get/get.dart';
import '../../../domain/usecases/auth/delete_image_profile_usecase.dart';
import '../../../domain/usecases/auth/update_profile_usecase.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileUseCase(Get.find()));
    Get.lazyPut(() => DeleteImageProfileUseCase(Get.find()));
    Get.lazyPut<UpdateProfileController>(
        () => UpdateProfileController(Get.find(), Get.find()));
  }
}
