import 'package:guideguys/modules/register/register_model.dart';
import 'package:guideguys/services/register_service/register_service.dart';
import 'package:guideguys/services/register_service/register_service_interface.dart';

class RegisterViewModel {
  RegisterServiceInterface service = RegisterService();
  late RegisterModel userModel;

  Future<String> onCreateAccount({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      userModel = RegisterModel(
        username: username,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      String res = await service.createAccount(regisInfo: userModel);
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
