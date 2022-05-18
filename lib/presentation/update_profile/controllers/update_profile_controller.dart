import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/exceptions/validation_exceptions.dart';
import '../../../app/utils/resource_case.dart';
import '../../../domain/usecases/auth/update_profile_usecase.dart';

class UpdateProfileController extends GetxController {
  final UpdateProfileUseCase _updateProfileUseCase;
  UpdateProfileController(this._updateProfileUseCase);

  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> updateProfile() async {
    await _updateProfileUseCase.execute(nameC.text).listen((event) {
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
          Get.snackbar('Berhasil', 'Berhasil mengubah Profile');
        },
      ).execute(event);
    }, onError: (e) {
      if (e is ValidationException) {
        Get.snackbar('Terjadi Kesalahan', e.message);
      }
    });
  }
}
