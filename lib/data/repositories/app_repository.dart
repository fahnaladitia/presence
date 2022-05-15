import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/pegawai.dart';
import '../../domain/repository/i_app_repository.dart';
import '../providers/network/firebase_network.dart';

class AppRepository implements IAppRepository {
  final FirebaseNetwork _firebaseNetwork;

  AppRepository(this._firebaseNetwork);

  @override
  Future<void> addPegawai(Pegawai pegawai, String uid) async =>
      await _firebaseNetwork.addPegawai(pegawai.toModel(), uid);

  @override
  Future<UserCredential> login(String email, String password) async =>
      await _firebaseNetwork.login(email, password);

  @override
  Future<void> logout() async => await _firebaseNetwork.logout();

  @override
  Future<void> newPassword(String password) async {
    return await _firebaseNetwork.newPassword(password);
  }

  @override
  Future<User?> get currentUser async =>
      await _firebaseNetwork.auth.currentUser;

  @override
  Future<UserCredential> createAccountPegawai(String email) async =>
      await _firebaseNetwork.createAccountPegawai(email);
}
