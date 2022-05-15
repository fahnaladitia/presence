import 'package:get/get.dart';
import 'package:presence/app/core/usecases/no_param_use_case.dart';
import 'package:presence/app/routes/app_pages.dart';
import 'package:presence/domain/repository/i_app_repository.dart';

class LogoutUseCase extends NoParamUseCase<void> {
  final IAppRepository _appRepository;
  LogoutUseCase(this._appRepository);
  @override
  Future<void> execute() async {
    await _appRepository.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
