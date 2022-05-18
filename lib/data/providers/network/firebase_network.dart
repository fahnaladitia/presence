import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../models/pegawai_model.dart';

class FirebaseNetwork {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

    await app.delete();

    return Future.sync(() => userCredential);
  }

  Future<void> addPegawai(PegawaiModel pegawai) async {
    return await _firestore
        .collection('pegawai')
        .doc(pegawai.uid)
        .set(pegawai.toMap());
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
