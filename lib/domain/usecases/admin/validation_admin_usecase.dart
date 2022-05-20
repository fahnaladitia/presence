import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/core/common/resource.dart';
import '../../../app/core/usecases/param_use_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../repository/i_app_repository.dart';

class ValidationAdminUseCase
    extends ParamStreamUseCase<Resource<UserCredential>, String> {
  final IAppRepository _appRepository;

  ValidationAdminUseCase(this._appRepository);

  @override
  Stream<Resource<UserCredential>> execute(String password) async* {
    if (password.isNotEmpty) {
      User userAdmin = await _appRepository.currentUser.then((value) => value!);
      String emailAdmin = userAdmin.email!;

      yield* await _appRepository.validationAdminAccount(emailAdmin, password);
    } else {
      throw ValidationException(message: 'Password harus di isi.');
    }
  }
}
