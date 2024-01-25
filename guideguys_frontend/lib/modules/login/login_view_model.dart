import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/login/login_model.dart';
import 'package:guideguys/services/login_service/login_mock_service.dart';
import 'package:guideguys/services/login_service/login_service.dart';
import 'package:guideguys/services/login_service/login_service_interface.dart';

class LoginViewModel {
  LoginServiceInterface service = LoginService();
  LoginModel userInfo = LoginModel(username: '', password: '');

  Future<bool> getToken({required LoginModel userInfo}) async {
    try {
      ResponseLoginModel res = await service.vertifyAccount(userInfo: userInfo);

      SecureStorage().writeSecureData('token', res.token);
      SecureStorage().writeSecureData('userId', res.userId);
      SecureStorage().writeSecureData('username', res.username);
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
