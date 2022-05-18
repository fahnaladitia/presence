import '../../../app/core/common/resource.dart';
import '../../../app/core/usecases/no_param_use_case.dart';
import '../../repository/i_app_repository.dart';

class LogoutUseCase extends NoParamStreamUseCase<Resource<void>> {
  final IAppRepository _appRepository;
  LogoutUseCase(this._appRepository);
  @override
  Stream<Resource<void>> execute() async* {
    yield* _appRepository.logout();
  }
}
