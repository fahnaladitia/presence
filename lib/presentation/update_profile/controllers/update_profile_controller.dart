import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/usecases/auth/delete_image_profile_usecase.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../../app/utils/resource_case.dart';
import '../../../domain/usecases/auth/update_profile_usecase.dart';

class UpdateProfileController extends GetxController {
  final UpdateProfileUseCase _updateProfileUseCase;
  final DeleteImageProfileUseCase _deleteImageProfileUseCase;
  UpdateProfileController(
    this._updateProfileUseCase,
    this._deleteImageProfileUseCase,
  );

  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  RxString imageUrl = ''.obs;

  RxBool isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  Rxn<XFile> image = Rxn<XFile>();

  Future<void> updateProfile() async {
    final input = InputUpdateProfile(name: nameC.text, file: image.value);
    await _updateProfileUseCase.execute(input).listen((event) {
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

  Future<void> pickImage() async {
    final result = await _picker.pickImage(source: ImageSource.gallery);
    if (image.value == null) {
      image.value = result;
    }
  }

  void deleteImageProfile() async {
    await _deleteImageProfileUseCase.execute().listen((event) {
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
          imageUrl.value = '';

          Get.snackbar('Berhasil', 'Berhasil menghapus Foto Profile');
        },
      ).execute(event);
    });
  }
}
