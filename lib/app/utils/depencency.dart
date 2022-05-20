import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';

import '../../domain/repository/i_app_repository.dart';
import '../../data/providers/network/firebase_network.dart';
import '../../data/repositories/app_repository.dart';

class DenpendencyCreator {
  static init() {
    Get.put(PageIndexController(), permanent: true);
    Get.lazyPut<IAppRepository>(() => AppRepository(FirebaseNetwork()),
        fenix: true);
  }
}
