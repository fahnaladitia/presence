import 'package:presence/app/core/common/resource.dart';

import '../../repository/i_app_repository.dart';
import '../../../app/core/usecases/no_param_use_case.dart';

class DeleteImageProfileUseCase extends NoParamStreamUseCase<Resource<void>> {
  final IAppRepository _appRepository;

  DeleteImageProfileUseCase(this._appRepository);
  @override
  Stream<Resource<void>> execute() async* {
    yield* await _appRepository.deleteImageProfile();
  }
}
