import 'package:get/get.dart';
import 'package:presence/domain/usecases/auth/current_pegawai_usecase.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CurrentPegawaiUseCase(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
