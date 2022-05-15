class PegawaiModel {
  final String uid;
  final String createdAt;
  final String email;
  final num nip;
  final String name;

  PegawaiModel({
    required this.uid,
    required this.name,
    required this.nip,
    required this.email,
    required this.createdAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'nip': nip,
      'email': email,
      'createdAt': createdAt,
    };
  }

  PegawaiModel.fromMap(Map<String, dynamic> pegawaiMap)
      : uid = pegawaiMap['uid'],
        name = pegawaiMap['name'],
        nip = pegawaiMap['nip'],
        email = pegawaiMap['email'],
        createdAt = pegawaiMap['createdAt'];
}
