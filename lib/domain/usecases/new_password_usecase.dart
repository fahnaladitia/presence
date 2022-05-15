import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/core/usecases/param_use_case.dart';
import 'package:presence/domain/repository/i_app_repository.dart';

import '../../app/routes/app_pages.dart';

class NewPasswordUseCase extends ParamUseCase<void, String> {
  final IAppRepository _appRepository;

  NewPasswordUseCase(this._appRepository);
  @override
  Future<void> execute(String newPassword) async {
    if (newPassword.isNotEmpty) {
      if (newPassword != 'password') {
        try {
          User? user = await _appRepository.currentUser;
          if (user != null) {
            String email = user.email!;

            await user.updatePassword(newPassword);

            await _appRepository.logout();

            await _appRepository.login(email, newPassword);

            Get.offAllNamed(Routes.HOME);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar('Terjadi kesalahan', 'Password minimal 6 karakter');
          }
        } catch (e) {
          Get.snackbar('Terjadi kesalahan',
              'Tidak dapat membuat password baru.\mHubungi admin atau customer service.');
        }
      } else {
        Get.snackbar('Terjadi Kesalahan',
            "Password baru tidak boleh dengan kata 'password'.");
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Password baru wajib di isi');
    }
  }
}
