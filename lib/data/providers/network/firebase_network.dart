import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:image_picker/image_picker.dart';
import '../../models/pegawai_model.dart';

class FirebaseNetwork {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  s.FirebaseStorage _storage = s.FirebaseStorage.instance;

  Future<UserCredential> login(String email, String password) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createAccountPegawai(String email,
      {String password = 'password'}) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);
    FirebaseAuth secondAuth = await FirebaseAuth.instanceFor(app: app);

    UserCredential userCredential = await secondAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user!.sendEmailVerification();

    await app.delete();

    return Future.sync(() => userCredential);
  }

  Future<void> addPegawai(PegawaiModel pegawai) async {
    return await _firestore
        .collection('pegawai')
        .doc(pegawai.uid)
        .set(pegawai.toMap());
  }

  Future<void> resetPassword(String email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    String email = auth.currentUser!.email!;
    final cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);
    await auth.currentUser!
        .reauthenticateWithCredential(cred)
        .then((value) async {
      await auth.currentUser!.updatePassword(newPassword);
    });
  }

  Future<void> _proccessDeleteProfile(String uid) async {
    final currentData = await _firestore
        .collection('pegawai')
        .doc(uid)
        .snapshots()
        .asyncMap((event) => event.data()!['profile']);
    final String currentImageUrl = await currentData.first;
    if (currentImageUrl != '') {
      await _storage.refFromURL(currentImageUrl).delete();
    }
  }

  Future<void> deleteImageProfile() async {
    final uid = auth.currentUser!.uid;
    await _proccessDeleteProfile(uid);
    await _firestore.collection('pegawai').doc(uid).update({'profile': ''});
  }

  Future<void> updateProfile(String name, [XFile? file = null]) async {
    final uid = auth.currentUser!.uid;
    if (file != null) {
      String uploadLocation =
          'upload/${uid}-${DateTime.now().millisecondsSinceEpoch}.${file.name.split('.').last}';
      print(uploadLocation);
      await _proccessDeleteProfile(uid);

      await _storage.ref(uploadLocation).putFile(File(file.path));
      String urlImage = await _storage.ref(uploadLocation).getDownloadURL();
      return await _firestore
          .collection('pegawai')
          .doc(uid)
          .update({'name': name, 'profile': urlImage});
    } else {
      return await _firestore
          .collection('pegawai')
          .doc(uid)
          .update({'name': name});
    }
  }

  Stream<PegawaiModel> currentPegawai() async* {
    String uid = auth.currentUser!.uid;
    yield* await _firestore
        .collection('pegawai')
        .doc(uid)
        .snapshots()
        .asyncMap((event) => PegawaiModel.fromMap(event.data()!));
  }

  Future<UserCredential> validationAdminAccount(
      String email, String password) async {
    FirebaseApp appValidation = await Firebase.initializeApp(
        name: 'appValidation', options: Firebase.app().options);
    FirebaseAuth validationAuth =
        await FirebaseAuth.instanceFor(app: appValidation);

    UserCredential userCredential = await validationAuth
        .signInWithEmailAndPassword(email: email, password: password);
    await appValidation.delete();

    return await Future.sync(() => userCredential);
  }

  Future<void> logout() async {
    return await auth.signOut();
  }

  Future<void> newPassword(String password) async {
    return await auth.currentUser!.updatePassword(password);
  }
}
