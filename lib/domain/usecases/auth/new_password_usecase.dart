import '../../../app/core/common/resource.dart';
import '../../../app/core/usecases/param_use_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../repository/i_app_repository.dart';

class NewPasswordUseCase extends ParamStreamUseCase<Resource<void>, String> {
  final IAppRepository _appRepository;

  NewPasswordUseCase(this._appRepository);
  @override
  Stream<Resource<void>> execute(String newPassword) async* {
    if (newPassword.isNotEmpty) {
      if (newPassword != 'password') {
        yield* await _appRepository.newPassword(newPassword);
      } else {
        throw ValidationException(
            message: "Password baru tidak boleh dengan kata 'password'.");
      }
    } else {
      throw ValidationException(message: 'Password baru wajib di isi');
    }
  }
}
