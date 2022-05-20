import 'package:get/get.dart';

import '../../../domain/usecases/admin/add_pegawai_usecase.dart';
import '../../../domain/usecases/admin/validation_admin_usecase.dart';
import '../controllers/add_pegawai_controller.dart';

class AddPegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ValidationAdminUseCase(Get.find()));
    Get.lazyPut(() => AddPegawaiUseCase(Get.find()));
    Get.lazyPut(
      () => AddPegawaiController(
        Get.find<AddPegawaiUseCase>(),
        Get.find<ValidationAdminUseCase>(),
      ),
    );
  }
}
