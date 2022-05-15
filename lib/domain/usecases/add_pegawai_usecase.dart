import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/core/usecases/param_use_case.dart';
import 'package:presence/domain/repository/i_app_repository.dart';

import '../../app/utils/formatting_date.dart';
import '../entities/pegawai.dart';

class InputAddPegawai {
  final String name;
  final String nip;
  final String email;
  final TextEditingController passwordC;

  InputAddPegawai({
    required this.name,
    required this.nip,
    required this.email,
    required this.passwordC,
  });
}

class AddPegawaiUseCase extends ParamUseCase<void, InputAddPegawai> {
  final IAppRepository _appRepository;
  AddPegawaiUseCase(this._appRepository);
  @override
  Future<void> execute(InputAddPegawai input) async {
    if (input.email.isNotEmpty &&
        input.nip.isNotEmpty &&
        input.name.isNotEmpty) {
      Get.defaultDialog(
        title: 'Validasi Admin',
        content: Column(
          children: [
            Text('Masukan password untuk validasi admin !'),
            TextField(
              controller: input.passwordC,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            )
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _processAddPegawai(input);
            },
            child: Text('ADD PEGAWAI'),
          ),
        ],
      );
    } else {
      Get.snackbar("Terjadi Kesalahan", 'NIP, Nama, dan email harus diisi.');
    }
  }

  Future<void> _processAddPegawai(InputAddPegawai input) async {
    if (input.passwordC.text.isNotEmpty) {
      try {
        User? userAdmin = await _appRepository.currentUser;
        if (userAdmin != null) {
          String emailAdmin = userAdmin.email!;
          await _appRepository.login(emailAdmin, input.passwordC.text);

          UserCredential pegawaiCredential =
              await _appRepository.createAccountPegawai(input.email);
          if (pegawaiCredential.user != null) {
            String uid = pegawaiCredential.user!.uid;
            Pegawai newPegawai = Pegawai(
              uid: uid,
              name: input.name,
              nip: int.parse(input.nip),
              email: input.email,
              createdAt:
                  formattingDate(value: DateTime.now().toIso8601String()),
            );
            await _appRepository.addPegawai(newPegawai, uid);

            await _appRepository.logout();

            await _appRepository.login(emailAdmin, input.passwordC.text);
            print('look');

            Get.back();
            Get.back();
            Get.snackbar('Berhasil.', 'Berhasil menambahkan pegawai baru.');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Get.snackbar('Terjadi Kesalahan',
              'email sudah ada. kamu tidak dapat menambahkan pegawai dengan email ini lagi.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              'Terjadi Kesalahan', 'Admin tidak dapat login. Password salah!');
        } else {
          Get.snackbar('Terjadi Kesalahan', "${e.code}");
        }
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Tidak dapat menambahkan pegawai.');
      }
    } else {
      Get.snackbar('Terjadi kesalahan', 'Password harus di isi.');
    }
  }
}
