import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/core/common/resource.dart';
import '../../../app/core/usecases/param_use_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../repository/i_app_repository.dart';

class InputLogin {
  final String email;
  final String password;

  InputLogin({required this.email, required this.password});
}

class LoginUseCase
    extends ParamStreamUseCase<Resource<UserCredential>, InputLogin> {
  final IAppRepository _appRepository;

  LoginUseCase(this._appRepository);
  @override
  Stream<Resource<UserCredential>> execute(InputLogin params) async* {
    if (params.email.isNotEmpty && params.password.isNotEmpty) {
      yield* _appRepository.login(params.email, params.password);
    } else {
      throw ValidationException(message: 'Email & Password harus di isi');
    }
  }
}
