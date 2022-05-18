import '../../entities/pegawai.dart';
import '../../repository/i_app_repository.dart';
import '../../../app/core/usecases/no_param_use_case.dart';

class CurrentPegawaiUseCase extends NoParamStreamUseCase<Pegawai> {
  final IAppRepository _appRepository;

  CurrentPegawaiUseCase(this._appRepository);

  @override
  Stream<Pegawai> execute() async* {
    yield* await _appRepository.currentPegawai();
  }
}
