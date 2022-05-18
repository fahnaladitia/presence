import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../../app/utils/resource_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../../domain/usecases/auth/reset_password_usecase.dart';

class ForgotPasswordController extends GetxController {
  final ResetPasswordUsecase _resetPasswordUsecase;
  ForgotPasswordController(this._resetPasswordUsecase);

  TextEditingController emailC = TextEditingController();
  RxBool isLoading = false.obs;

  void sendEmail() {
    _resetPasswordUsecase.execute(emailC.text).listen((event) {
      ResourceCase<void>(onLoading: (event) {
        isLoading.value = event.isLoading;
      }, onError: (event) {
        isLoading.value = event.isLoading;
        Get.snackbar('Terjadi Kesalahan', event.message ?? "Unknown Error");
      }, onSuccess: (event) {
        isLoading.value = event.isLoading;

        Get.snackbar('Berhasil', 'Kami telah mengirim email reset password.');
        Get.offAllNamed(Routes.LOGIN);
      }).execute(event);
    }, onError: (e) {
      final ValidationException error = e;
      Get.snackbar('Terjadi Kesalahan', error.message);
    });
  }
}
