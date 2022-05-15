import 'package:get/get.dart';
import 'package:presence/domain/usecases/add_pegawai_usecase.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPegawaiUseCase(Get.find()));
    Get.lazyPut(() => AddPegawaiController(Get.find<AddPegawaiUseCase>()));
  }
}
