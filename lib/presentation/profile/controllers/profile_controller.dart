import 'package:get/get.dart';

import '../../../domain/entities/pegawai.dart';
import '../../../domain/usecases/auth/current_pegawai_usecase.dart';
import '../../../app/core/common/resource.dart';
import '../../../app/routes/app_pages.dart';
import '../../../app/utils/resource_case.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';

class ProfileController extends GetxController {
  final CurrentPegawaiUseCase _currentPegawaiUseCase;
  final LogoutUseCase _logoutUseCase;
  ProfileController(this._currentPegawaiUseCase, this._logoutUseCase);

  Stream<Pegawai> currentPegawai() async* {
    yield* await _currentPegawaiUseCase.execute();
  }

  RxBool isLoading = false.obs;
  void logout() {
    _logoutUseCase.execute().listen((event) {
      ResourceCase<void>(
        onError: _onError,
        onLoading: _onLoading,
        onSuccess: _onSuccess,
      ).execute(event);
    });
  }

  void _onLoading(LoadingResource<void> event) {
    isLoading.value = event.isLoading;
  }

  void _onError(ErrorResource<void> event) {
    isLoading.value = event.isLoading;
  }

  void _onSuccess(SuccessResource<void> event) {
    isLoading.value = event.isLoading;
    Get.offAllNamed(Routes.LOGIN);
  }
}
