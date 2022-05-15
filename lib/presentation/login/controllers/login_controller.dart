import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/core/usecases/param_use_case.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginController extends GetxController {
  final ParamUseCase<void, InputLogin> _loginUseCase;
  LoginController(this._loginUseCase);

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  RxBool isObscure = true.obs;

  Future<void> login() async {
    InputLogin inputLogin =
        InputLogin(email: emailC.text, password: passwordC.text);
    await _loginUseCase.execute(inputLogin);
  }
}
