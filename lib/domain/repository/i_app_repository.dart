import 'package:firebase_auth/firebase_auth.dart';

import '../entities/pegawai.dart';

abstract class IAppRepository {
  Future<User?> get currentUser;

  Future<UserCredential> login(String email, String password);

  Future<UserCredential> createAccountPegawai(String email);

  Future<void> addPegawai(Pegawai pegawai, String uid);

  Future<void> logout();

  Future<void> newPassword(String password);
}
