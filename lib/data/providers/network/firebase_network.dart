import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> addPegawai(PegawaiModel pegawai, String uid) async {
    return await _firestore.collection('pegawai').doc(uid).set(pegawai.toMap());
  }

  Future<void> logout() async {
    return await auth.signOut();
  }

  Future<void> newPassword(String password) async {
    return await auth.currentUser!.updatePassword(password);
  }
}
