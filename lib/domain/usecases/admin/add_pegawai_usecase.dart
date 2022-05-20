import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/core/common/resource.dart';
import '../../../app/core/usecases/param_use_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../repository/i_app_repository.dart';

class InputAddPegawai {
  final String name;
  final String nip;
  final String email;
  final String job;

  InputAddPegawai({
    required this.name,
    required this.nip,
    required this.email,
    required this.job,
  });
}

class AddPegawaiUseCase
    extends ParamStreamUseCase<Resource<UserCredential>, InputAddPegawai> {
  final IAppRepository _appRepository;
  AddPegawaiUseCase(this._appRepository);
  @override
  Stream<Resource<UserCredential>> execute(InputAddPegawai params) async* {
    final paramsIsNotEmpty = params.email.isNotEmpty &&
        params.nip.isNotEmpty &&
        params.name.isNotEmpty &&
        params.job.isNotEmpty;
    if (paramsIsNotEmpty) {
      yield* _appRepository.createAccountPegawai(
          params.email, params.name, params.nip, params.job);
    } else {
      throw ValidationException(message: 'NIP, Nama, dan email harus diisi.');
    }
  }
}
