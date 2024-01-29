import 'dart:convert';
import 'dart:typed_data';

import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/register/register_model.dart';
import 'package:guideguys/services/register_service/register_service.dart';
import 'package:guideguys/services/register_service/register_service_interface.dart';

class RegisterViewModel {
  RegisterServiceInterface service = RegisterService();
  late RegisterModel userModel;

  Future<bool> onCreateAccount({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required Uint8List userImage,
    required String phoneNumber,
  }) async {
    try {
      userModel = RegisterModel(
        username: username,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        img: base64Encode(userImage),
        phoneNumber: phoneNumber,
      );
      ResponseRegisterModel res = await service.createAccount(regisInfo: userModel);
      
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
