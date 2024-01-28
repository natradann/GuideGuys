import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/login/login_model.dart';
import 'package:guideguys/services/login_service/login_mock_service.dart';
import 'package:guideguys/services/login_service/login_service.dart';
import 'package:guideguys/services/login_service/login_service_interface.dart';

class LoginViewModel {
  LoginServiceInterface service = LoginService();
  LoginModel userInfo = LoginModel(username: '', password: '');

  Future<bool> getToken({required LoginModel userInfo}) async {
    LoginModel userInfo = LoginModel(username: 'natradann', password: 'hello123');
    try {
      ResponseLoginModel res = await service.vertifyAccount(userInfo: userInfo);

      SecureStorage().writeSecureData('myToken', res.token);
      SecureStorage().writeSecureData('myUserId', res.userId);
      SecureStorage().writeSecureData('myUsername', res.username);
      SecureStorage().writeSecureData('myGuideId', res.myGuideId ?? 'tourist');
      
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
