import 'package:get/get.dart';

import '../../../app/core/common/resource.dart';
import '../../../app/routes/app_pages.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';

class HomeController extends GetxController {
  final LogoutUseCase _logoutUseCase;

  HomeController(this._logoutUseCase);

  RxBool isLoading = false.obs;

  Future<void> logout() async {
    await _logoutUseCase.execute().listen((event) {
      switch (event.runtimeType) {
        case LoadingResource<void>:
          _onLoading(event as LoadingResource<void>);
          break;
        case ErrorResource<void>:
          _onError(event as ErrorResource<void>);
          break;
        case SuccessResource<void>:
          _onSuccess(event as SuccessResource<void>);
          break;
      }
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
