import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/core/usecases/param_use_case.dart';
import 'package:presence/app/routes/app_pages.dart';

import '../repository/i_app_repository.dart';

class InputLogin {
  final String email;
  final String password;

  InputLogin({required this.email, required this.password});
}

class LoginUseCase extends ParamUseCase<void, InputLogin> {
  final IAppRepository _appRepository;

  LoginUseCase(this._appRepository);

  @override
  Future<void> execute(InputLogin input) async {
    if (input.email.isNotEmpty && input.password.isNotEmpty) {
      try {
        await _loginProcess(input.email, input.password);
      } on FirebaseAuthException catch (e) {
        _firebaseAuthException(e);
      } catch (e) {
        print(e);
        Get.snackbar('Terjadi Kesalahan', 'Tidak dapat login');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Email & Password wajib di isi');
    }
  }

  void _firebaseAuthException(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      Get.snackbar('Terjadi Kesalahan', 'Email tidak terdaftar');
    } else if (e.code == 'wrong-password') {
      Get.snackbar('Terjadi Kesalahan', 'Password salah');
    }
  }

  Future<void> _loginProcess(String email, String password) async {
    UserCredential userCredential = await _appRepository.login(email, password);
    if (userCredential.user != null) {
      if (userCredential.user!.emailVerified == true) {
        if (password == 'password') {
          Get.offAllNamed(Routes.NEW_PASSWORD);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.defaultDialog(
          barrierDismissible: false,
          title: 'Belum Verifikasi',
          middleText:
              'Kamu belum verifikasi akun ini.\nLakukan verifikasi di email kamu',
          actions: [
            OutlinedButton(onPressed: () => Get.back(), child: Text('CANCEL')),
            ElevatedButton(
                onPressed: () async {
                  await _sendEmailVerification(userCredential, email);
                },
                child: Text('KIRIM ULANG')),
          ],
        );
      }
    }
  }

  Future<void> _sendEmailVerification(
      UserCredential userCredential, String email) async {
    try {
      await userCredential.user!.sendEmailVerification();
      Get.snackbar('Berhasil',
          'Kami tidak berhasil mengirim email verifikasi ke akun ${email}.');
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan',
          'Tidak dapat mengirim email verifikasi.\nHubungi admin atau customer service.');
    }
  }
}
