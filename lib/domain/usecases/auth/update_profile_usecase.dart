import 'package:image_picker/image_picker.dart';

import '../../../app/core/common/resource.dart';
import '../../../app/core/usecases/param_use_case.dart';
import '../../../app/exceptions/validation_exceptions.dart';
import '../../repository/i_app_repository.dart';

class InputUpdateProfile {
  final String name;
  final XFile? file;

  InputUpdateProfile({required this.name, this.file});
}

class UpdateProfileUseCase
    extends ParamStreamUseCase<Resource<void>, InputUpdateProfile> {
  final IAppRepository _appRepository;

  UpdateProfileUseCase(this._appRepository);
  @override
  Stream<Resource<void>> execute(InputUpdateProfile input) async* {
    if (input.name.isNotEmpty) {
      yield* await _appRepository.updateProfile(input.name, input.file);
    } else {
      throw ValidationException(message: 'Name harus di isi');
    }
  }
}
