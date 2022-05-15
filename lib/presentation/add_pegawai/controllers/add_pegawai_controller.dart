import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/core/usecases/param_use_case.dart';
import 'package:presence/domain/usecases/add_pegawai_usecase.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordAdminC = TextEditingController();

  final ParamUseCase<void, InputAddPegawai> _addPegawaiUseCase;
  AddPegawaiController(this._addPegawaiUseCase);

  Future<void> addPegawai() async {
    InputAddPegawai input = InputAddPegawai(
        name: nameC.text,
        nip: nipC.text,
        email: emailC.text,
        passwordC: passwordAdminC);
    await _addPegawaiUseCase.execute(input);
  }
}
