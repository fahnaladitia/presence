import 'package:get/get.dart';

import '../../presentation/add_pegawai/bindings/add_pegawai_binding.dart';
import '../../presentation/add_pegawai/views/add_pegawai_view.dart';
import '../../presentation/forgot_password/bindings/forgot_password_binding.dart';
import '../../presentation/forgot_password/views/forgot_password_view.dart';
import '../../presentation/home/bindings/home_binding.dart';
import '../../presentation/home/views/home_view.dart';
import '../../presentation/login/bindings/login_binding.dart';
import '../../presentation/login/views/login_view.dart';
import '../../presentation/new_password/bindings/new_password_binding.dart';
import '../../presentation/new_password/views/new_password_view.dart';
import '../../presentation/profile/bindings/profile_binding.dart';
import '../../presentation/profile/views/profile_view.dart';
import '../../presentation/update_password/bindings/update_password_binding.dart';
import '../../presentation/update_password/views/update_password_view.dart';
import '../../presentation/update_profile/bindings/update_profile_binding.dart';
import '../../presentation/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      transition: Transition.cupertino,
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: _Paths.ADD_PEGAWAI,
      page: () => AddPegawaiView(),
      binding: AddPegawaiBinding(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
  ];
}
