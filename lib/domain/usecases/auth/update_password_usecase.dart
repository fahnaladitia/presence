import '../../../app/core/common/resource.dart';
import '../../../app/core/usecases/param_use_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../repository/i_app_repository.dart';

class InputUpdatePassword {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  InputUpdatePassword(
      this.currentPassword, this.newPassword, this.confirmNewPassword);
}

class UpdatePasswordUseCase
    extends ParamStreamUseCase<Resource<void>, InputUpdatePassword> {
  final IAppRepository _appRepository;

  UpdatePasswordUseCase(this._appRepository);
  @override
  Stream<Resource<void>> execute(InputUpdatePassword input) async* {
    if (input.currentPassword.isNotEmpty &&
        input.newPassword.isNotEmpty &&
        input.confirmNewPassword.isNotEmpty) {
      if (input.newPassword == input.confirmNewPassword) {
        yield* await _appRepository.updatePassword(
            input.currentPassword, input.newPassword);
      } else {
        throw ValidationException(
            message: 'New Password dan Confirm New password harus sama');
      }
    } else {
      throw ValidationException(message: 'Semua Field harus di isi');
    }
  }
}
