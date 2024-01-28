import 'package:guideguys/modules/register/register_model.dart';

abstract class RegisterServiceInterface {
  Future<ResponseRegisterModel> createAccount({required RegisterModel regisInfo});
}