import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app/core/common/resource.dart';
import '../../../app/routes/app_pages.dart';
import '../../../domain/usecases/auth/new_password_usecase.dart';

class NewPasswordController extends GetxController {
  final NewPasswordUseCase _newPasswordUseCase;
  NewPasswordController(this._newPasswordUseCase);

  TextEditingController newPasswordC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;

  Future<void> newPassword() async {
    await _newPasswordUseCase.execute(newPasswordC.text).listen((event) {
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
    Get.snackbar('Terjadi Kesalahan', event.message ?? 'Unknown Error');
  }

  void _onSuccess(SuccessResource<void> event) {
    isLoading.value = event.isLoading;
    Get.offAllNamed(Routes.HOME);
  }
}
