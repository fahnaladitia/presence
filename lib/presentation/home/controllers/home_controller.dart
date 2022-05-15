import 'package:get/get.dart';
import 'package:presence/app/core/usecases/no_param_use_case.dart';

class HomeController extends GetxController {
  final NoParamUseCase<void> _loginUseCase;

  HomeController(this._loginUseCase);

  Future<void> logout() async {
    await _loginUseCase.execute();
  }
}
