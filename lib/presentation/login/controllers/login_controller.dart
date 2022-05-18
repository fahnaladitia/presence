import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/resource_case.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../../app/routes/app_pages.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/send_email_verification_usecase.dart';
import '../../../app/core/common/resource.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginStreamUseCase;
  final SendEmailVerificationUseCase _sendEmailVerificationUseCase;
  final LogoutUseCase _logoutUseCase;
  LoginController(
    this._loginStreamUseCase,
    this._sendEmailVerificationUseCase,
    this._logoutUseCase,
  );

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;

  Future<void> loginStream() async {
    InputLogin inputLogin = InputLogin(
      email: emailC.text,
      password: passwordC.text,
    );

    _loginStreamUseCase.execute(inputLogin).listen((event) {
      ResourceCase<UserCredential>(
        onError: (event) {
          isLoading.value = event.isLoading;
          Get.snackbar('Terjadi Kesalahan', event.message ?? 'Unknown Error');
        },
        onLoading: (event) {
          isLoading.value = event.isLoading;
        },
        onSuccess: (event) {
          _onSuccess(event);
        },
      ).execute(event);
    }, onError: (e) {
      Get.snackbar('Terjadi Kesalahan', e.message);
    });
  }

  void _onSuccess(SuccessResource<UserCredential> data) {
    isLoading.value = data.isLoading;
    if (data.data!.user!.emailVerified) {
      if (passwordC.text == 'password') {
        Get.offAllNamed(Routes.NEW_PASSWORD);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } else {
      _openDialogEmailVerification();
    }
  }

  void _openDialogEmailVerification() async {
    await Get.defaultDialog(
      barrierDismissible: false,
      title: 'Belum Verifikasi',
      middleText:
          'Kamu belum verifikasi akun ini.\nLakukan verifikasi di email kamu',
      actions: [
        OutlinedButton(
            onPressed: () {
              _sendEmailVerification(isSend: false);
            },
            child: Text('CANCEL')),
        ElevatedButton(
            onPressed: () {
              _sendEmailVerification();
            },
            child: Text('KIRIM ULANG')),
      ],
    );
  }

  void _sendEmailVerification({bool isSend = true}) {
    _logoutUseCase.execute().listen((event) async {
      ResourceCase<void>(
        onError: (event) {
          isLoading.value = event.isLoading;
          Get.snackbar('Terjadi Kesalahan', event.message ?? 'Unknown Error');
        },
        onLoading: (event) {
          isLoading.value = event.isLoading;
        },
        onSuccess: (event) async {
          isLoading.value = event.isLoading;
          if (isSend) {
            try {
              await _sendEmailVerificationUseCase.execute();

              Get.snackbar('Berhasil',
                  'Kami berhasil mengirim email verifikasi ke akun kamu.');
              Get.back();
            } on ValidationException catch (e) {
              Get.snackbar("Terjadi Kesalahan", e.message);
            }
          } else {
            Get.back();
          }
        },
      ).execute(event);
    });
  }
}
