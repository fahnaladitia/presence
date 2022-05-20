import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../../app/core/common/resource.dart';
import '../../../domain/usecases/admin/add_pegawai_usecase.dart';
import '../../../domain/usecases/admin/validation_admin_usecase.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordAdminC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  final AddPegawaiUseCase _addPegawaiStreamUseCase;
  final ValidationAdminUseCase _validationAdminUseCase;

  AddPegawaiController(
      this._addPegawaiStreamUseCase, this._validationAdminUseCase);

  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;

  Future<void> addPegawai() async {
    final inputIsNotEmpty = emailC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        jobC.text.isNotEmpty;

    if (inputIsNotEmpty) {
      _buildDialog();
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", 'NIP, Nama, job, dan email harus diisi.');
    }
  }

  void _buildDialog() {
    Get.defaultDialog(
        title: 'Validasi Admin',
        content: Column(
          children: [
            Text('Masukan password untuk validasi admin'),
            SizedBox(height: 5),
            Obx(() => TextField(
                  controller: passwordAdminC,
                  autocorrect: false,
                  obscureText: isObscure.value,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          isObscure.value = !isObscure.value;
                        },
                        icon: Icon(isObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: 'Password',
                      border: OutlineInputBorder()),
                ))
          ],
        ),
        actions: [
          OutlinedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('CANCEL')),
          Obx(() => ElevatedButton(
              onPressed: () {
                if (isLoading.isFalse) {
                  // try {
                  _validationAdminUseCase.execute(passwordAdminC.text).listen(
                      (event) {
                    switch (event.runtimeType) {
                      case LoadingResource<UserCredential>:
                        _onLoading(event as LoadingResource<UserCredential>);
                        break;
                      case ErrorResource<UserCredential>:
                        _onError(event as ErrorResource<UserCredential>);
                        break;
                      case SuccessResource<UserCredential>:
                        _onSuccessValidation(
                            event as SuccessResource<UserCredential>);

                        break;
                    }
                  }, onError: (e) {
                    Get.snackbar('Terjadi Kesalahan', e.message);
                  });
                }
              },
              child: Text(isLoading.isFalse ? 'CONFIRM' : 'LOADING...'))),
        ]);
  }

  void _onLoading(LoadingResource<UserCredential> event) =>
      isLoading.value = event.isLoading;

  void _onError(ErrorResource<UserCredential> event) {
    isLoading.value = event.isLoading;
    Get.snackbar('Terjadi Kesalahan', event.message ?? 'Unknown Error');
  }

  void _onSuccessAddPegawai(SuccessResource<UserCredential> event) async {
    isLoading.value = event.isLoading;
    Get.snackbar('Berhasil.', 'Berhasil menambahkan pegawai baru.');
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> _onSuccessValidation(
      SuccessResource<UserCredential> event) async {
    isLoading.value = event.isLoading;
    Get.back();
    Get.snackbar('Berhasil', 'Validasi Berhasil');
    final input = InputAddPegawai(
      name: nameC.text,
      nip: nipC.text,
      email: emailC.text,
      job: jobC.text,
    );
    await _addPegawaiStreamUseCase.execute(input).listen((event) {
      switch (event.runtimeType) {
        case LoadingResource<UserCredential>:
          _onLoading(event as LoadingResource<UserCredential>);
          break;
        case ErrorResource<UserCredential>:
          _onError(event as ErrorResource<UserCredential>);
          break;
        case SuccessResource<UserCredential>:
          _onSuccessAddPegawai(event as SuccessResource<UserCredential>);
          break;
      }
    }, onError: (e) {
      Get.snackbar('Terjadi Kesalahan', e.message);
    });
  }
}
