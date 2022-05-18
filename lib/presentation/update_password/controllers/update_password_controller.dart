import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/exceptions/validation_exceptions.dart';
import '../../../app/utils/resource_case.dart';
import '../../../domain/usecases/auth/update_password_usecase.dart';

class UpdatePasswordController extends GetxController {
  final UpdatePasswordUseCase _updatePasswordUseCase;
  UpdatePasswordController(this._updatePasswordUseCase);
  TextEditingController currC = TextEditingController();
  TextEditingController newC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isObscureCurr = true.obs;
  RxBool isObscureNew = true.obs;
  RxBool isObscureConfirm = true.obs;

  void updatePassword() async {
    _updatePasswordUseCase
        .execute(InputUpdatePassword(currC.text, newC.text, confirmC.text))
        .listen((event) {
      ResourceCase<void>(
        onError: (event) {
          isLoading.value = event.isLoading;
          Get.snackbar('Terjadi Kesalahan', event.message ?? 'Unknown Error');
        },
        onLoading: (event) {
          isLoading.value = event.isLoading;
        },
        onSuccess: (event) {
          isLoading.value = event.isLoading;
          Get.back();
          Get.snackbar('Berhasil', 'Password Berhasil diubah');
        },
      ).execute(event);
    }, onError: (e) {
      if (e is ValidationException) {
        Get.snackbar('Terjadi Kesalahan', e.message);
      }
    });
  }
}
