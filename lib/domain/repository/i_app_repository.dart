import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/pegawai.dart';
import '../../app/core/common/resource.dart';

abstract class IAppRepository {
  // Future
  Future<User?> get currentUser;

  // Stream
  Stream<Resource<UserCredential>> login(String email, String password);

  Stream<Resource<UserCredential>> validationAdminAccount(
    String email,
    String password,
  );

  Stream<Resource<void>> newPassword(String password);

  Stream<Resource<UserCredential>> createAccountPegawai(
    String email,
    String name,
    String nip,
    String job,
  );

  Stream<Resource<void>> updatePassword(
      String currentPassword, String newPassword);

  Stream<Resource<void>> updateProfile(String name, String job, XFile? file);

  Stream<Resource<void>> deleteImageProfile();

  Stream<Pegawai> currentPegawai();

  Stream<Resource<void>> resetPassword(String email);

  Stream<Resource<void>> logout();
}
