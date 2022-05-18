import '../../repository/i_app_repository.dart';
import '../../../app/core/usecases/param_use_case.dart';
import '../../../app/core/common/resource.dart';
import '../../../app/exceptions/validation_exceptions.dart';

class ResetPasswordUsecase extends ParamStreamUseCase<Resource<void>, String> {
  final IAppRepository _appRepository;

  ResetPasswordUsecase(this._appRepository);
  @override
  Stream<Resource<void>> execute(String email) async* {
    if (email.isNotEmpty) {
      yield* await _appRepository.resetPassword(email);
    } else {
      throw ValidationException(message: 'Email harus di isi');
    }
  }
}
