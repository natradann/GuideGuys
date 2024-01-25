import 'package:guideguys/modules/register/register_model.dart';

abstract class RegisterServiceInterface {
  Future<String> createAccount({required RegisterModel regisInfo});
}