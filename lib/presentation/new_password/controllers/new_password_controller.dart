import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/resource_case.dart';
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

  void newPassword() {
    _newPasswordUseCase.execute(newPasswordC.text).listen((event) {
      ResourceCase<void>(
        onError: _onError,
        onLoading: _onLoading,
        onSuccess: _onSuccess,
      ).execute(event);
    }, onError: (e) {
      Get.snackbar('Terjadi Kesalahan', e.message);
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
