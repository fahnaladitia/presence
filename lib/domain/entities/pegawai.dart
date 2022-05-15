import 'package:presence/data/models/pegawai_model.dart';

class Pegawai {
  final String uid;
  final String createdAt;
  final String email;
  final num nip;
  final String name;

  Pegawai({
    required this.uid,
    required this.name,
    required this.nip,
    required this.email,
    required this.createdAt,
  });

  PegawaiModel toModel() => PegawaiModel(
        uid: uid,
        name: name,
        nip: nip,
        email: email,
        createdAt: createdAt,
      );

  // Pegawai.fromMap(Map<String, dynamic> pegawaiMap)
  //     : uid = pegawaiMap['uid'],
  //       name = pegawaiMap['name'],
  //       nip = pegawaiMap['nip'],
  //       email = pegawaiMap['email'],
  //       createdAt = pegawaiMap['createdAt'];

  // Map<String, dynamic> toMap() => {
  //       'uid': uid,
  //       'name': name,
  //       'nip': nip,
  //       'email': email,
  //       'createdAt': createdAt,
  //     };
}
