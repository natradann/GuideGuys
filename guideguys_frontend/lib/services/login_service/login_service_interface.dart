import 'package:guideguys/modules/login/login_model.dart';

abstract class LoginServiceInterface {
  Future<ResponseLoginModel> vertifyAccount({required LoginModel userInfo});
}
