import '../../data/models/pegawai_model.dart';
import '../../domain/entities/pegawai.dart';

extension PegawaiMapper on Pegawai {
  PegawaiModel toModel() => PegawaiModel(
        uid: uid,
        name: name,
        nip: nip,
        email: email,
        createdAt: createdAt,
      );
}

extension PegawaiModelMapper on PegawaiModel {
  Pegawai toDomain() => Pegawai(
        uid: uid,
        name: name,
        nip: nip,
        email: email,
        createdAt: createdAt,
      );
}
