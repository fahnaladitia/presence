import '../../../app/core/usecases/no_param_use_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../repository/i_app_repository.dart';

class SendEmailVerificationUseCase extends NoParamUseCase<void> {
  final IAppRepository _appRepository;

  SendEmailVerificationUseCase(this._appRepository);

  @override
  Future<void> execute() async {
    try {
      await _appRepository.currentUser
          .then((value) => value?.sendEmailVerification());
    } catch (e) {
      throw ValidationException(
          message:
              'Tidak dapat mengirim email verifikasi.\nHubungi admin atau customer service.');
    }
  }
}
