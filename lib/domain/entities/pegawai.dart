class Pegawai {
  final String uid;
  final String createdAt;
  final String email;
  final num nip;
  final String role;
  final String name;
  final String? profile;
  final String job;

  Pegawai({
    required this.uid,
    required this.name,
    required this.nip,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.job,
    this.profile,
  });

  @override
  String toString() {
    return "Pegawai(uid: $uid, name: $name, nip: $nip, email: $email, role: $role, profile: $profile, job: $job, createdAt: $createdAt)";
  }
}
