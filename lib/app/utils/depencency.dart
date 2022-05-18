import 'package:get/get.dart';

import '../../domain/repository/i_app_repository.dart';
import '../../data/providers/network/firebase_network.dart';
import '../../data/repositories/app_repository.dart';

class DenpendencyCreator {
  static init() {
    Get.lazyPut<IAppRepository>(() => AppRepository(FirebaseNetwork()),
        fenix: true);
  }
}
