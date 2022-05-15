import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence/app/core/usecases/param_use_case.dart';
import 'package:presence/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  final ParamUseCase<void, String> _newPasswordUseCase;
  NewPasswordController(this._newPasswordUseCase);

  TextEditingController newPasswordC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isObscure = true.obs;

  Future<void> newPassword() async {
    await _newPasswordUseCase.execute(newPasswordC.text);
    // if (newPasswordC.text.isNotEmpty) {
    //   if (newPasswordC.text != 'password') {
    //     try {
    //       String email = auth.currentUser!.email!;
    //       await auth.currentUser!.updatePassword(newPasswordC.text);
    //       await auth.signOut();

    //       await auth.signInWithEmailAndPassword(
    //           email: email, password: newPasswordC.text);

    //       Get.offAllNamed(Routes.HOME);
    //     } on FirebaseAuthException catch (e) {
    //       if (e.code == 'weak-password') {
    //         Get.snackbar('Terjadi kesalahan', 'Password minimal 6 karakter');
    //       }
    //     } catch (e) {
    //       Get.snackbar('Terjadi kesalahan',
    //           'Tidak dapat membuat password baru.\mHubungi admin atau customer service.');
    //     }
    //   } else {
    //     Get.snackbar('Terjadi Kesalahan',
    //         "Password baru tidak boleh dengan kata 'password'.");
    //   }
    // } else {
    //   Get.snackbar('Terjadi Kesalahan', 'Password baru wajib di isi');
    // }
  }
}
