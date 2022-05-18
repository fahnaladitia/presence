import '../../../app/core/common/resource.dart';
import '../../../app/core/usecases/param_use_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../repository/i_app_repository.dart';

class UpdateProfileUseCase extends ParamStreamUseCase<Resource<void>, String> {
  final IAppRepository _appRepository;

  UpdateProfileUseCase(this._appRepository);
  @override
  Stream<Resource<void>> execute(String name) async* {
    if (name.isNotEmpty) {
      yield* await _appRepository.updateProfile(name);
    } else {
      throw ValidationException(message: 'Name harus di isi');
    }
  }
}
