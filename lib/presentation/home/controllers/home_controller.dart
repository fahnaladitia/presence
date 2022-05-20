import 'package:get/get.dart';
import 'package:presence/domain/usecases/auth/current_pegawai_usecase.dart';

import '../../../domain/entities/pegawai.dart';

class HomeController extends GetxController {
  final CurrentPegawaiUseCase _currentPegawaiUseCase;
  HomeController(this._currentPegawaiUseCase);
  RxBool isLoading = false.obs;

  Stream<Pegawai> currentPegawai() async* {
    yield* await _currentPegawaiUseCase.execute();
  }
}
