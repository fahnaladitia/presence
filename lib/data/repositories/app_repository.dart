import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/utils/mapper.dart';
import '../../app/core/common/resource.dart';
import '../../app/utils/formatting_date.dart';
import '../../domain/entities/pegawai.dart';
import '../../domain/repository/i_app_repository.dart';
import '../providers/network/firebase_network.dart';

class AppRepository implements IAppRepository {
  final FirebaseNetwork _firebaseNetwork;

  AppRepository(this._firebaseNetwork);

  @override
  Future<User?> get currentUser async =>
      await _firebaseNetwork.auth.currentUser;

  @override
  Stream<Resource<UserCredential>> login(String email, String password) async* {
    yield LoadingResource();
    try {
      UserCredential userCredential =
          await _firebaseNetwork.login(email, password);
      yield SuccessResource(data: userCredential);
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    }
  }

  @override
  Stream<Resource<UserCredential>> createAccountPegawai(
    String email,
    String name,
    String nip,
    String job,
  ) async* {
    yield LoadingResource();
    try {
      UserCredential userCredential =
          await _firebaseNetwork.createAccountPegawai(email);
      Pegawai newPegawai = Pegawai(
        uid: userCredential.user!.uid,
        name: name,
        nip: int.parse(nip),
        email: email,
        role: 'pegawai',
        job: job,
        createdAt: formattingDate(value: DateTime.now().toIso8601String()),
      );
      await _firebaseNetwork.addPegawai(newPegawai.toModel());
      yield SuccessResource(data: userCredential);
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    }
  }

  @override
  Stream<Resource<UserCredential>> validationAdminAccount(
      String email, String password) async* {
    yield LoadingResource();
    try {
      UserCredential userCredential =
          await _firebaseNetwork.validationAdminAccount(email, password);

      yield SuccessResource(data: userCredential);
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    }
  }

  @override
  Stream<Resource<void>> newPassword(String password) async* {
    yield LoadingResource();
    try {
      await _firebaseNetwork.newPassword(password);

      yield SuccessResource(data: () {});
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    }
  }

  @override
  Stream<Resource<void>> logout() async* {
    yield LoadingResource();
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      await _firebaseNetwork.logout();
      yield SuccessResource(data: () {});
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    }
  }

  @override
  Stream<Resource<void>> resetPassword(String email) async* {
    yield LoadingResource();
    try {
      await _firebaseNetwork.resetPassword(email);
      await Future.delayed(Duration(seconds: 1));
      yield SuccessResource(data: () {});
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    }
  }

  @override
  Stream<Pegawai> currentPegawai() async* {
    yield* await _firebaseNetwork
        .currentPegawai()
        .asyncMap((event) => event.toDomain());
  }

  @override
  Stream<Resource<void>> updateProfile(
      String name, String job, XFile? file) async* {
    yield LoadingResource();
    try {
      await _firebaseNetwork.updateProfile(name, job, file);
      yield SuccessResource(data: () {});
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    } catch (e) {
      yield ErrorResource(message: e.toString());
    }
  }

  @override
  Stream<Resource<void>> updatePassword(
      String currentPassword, String newPassword) async* {
    yield LoadingResource();
    try {
      await _firebaseNetwork.updatePassword(currentPassword, newPassword);
      yield SuccessResource(data: () {});
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    }
  }

  @override
  Stream<Resource<void>> deleteImageProfile() async* {
    yield LoadingResource();
    try {
      await _firebaseNetwork.deleteImageProfile();
      yield SuccessResource(data: () {});
    } on FirebaseAuthException catch (e) {
      yield ErrorResource(message: e.code);
    }
  }
}
