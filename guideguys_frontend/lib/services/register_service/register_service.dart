import 'dart:convert';

import 'package:guideguys/modules/register/register_model.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:guideguys/services/register_service/register_service_interface.dart';
import 'package:http/http.dart' as http;

class RegisterService implements RegisterServiceInterface {
  @override
  // Future<ResponseRegisterModel> createAccount({required RegisterModel regisInfo}) async {
  //   http.Response response = await http.post(
  //     Uri.parse("$ngrokLink/users/register"),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(regisInfo.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     return responseRegisterModelFromJson(response.body);
  //   } else if (response.statusCode == 401) {
  //     throw Exception('User already exists');
  //   } else if (response.statusCode == 402) {
  //     throw Exception('Unable to Sign JWT');
  //   } else if (response.statusCode == 403) {
  //     throw Exception('hash error');
  //   } else {
  //     throw Exception("Unknown Error");
  //   }
  // }

  Future<ResponseRegisterModel> createAccount({
    required RegisterModel regisInfo,
  }) async {
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse('$ngrokLink/users/register'),
      
    );

    // Add fields (non-file data) to the request
    request.fields['username'] = regisInfo.username;
    request.fields['email'] = regisInfo.email;
    request.fields['password'] = regisInfo.password;
    request.fields['first_name'] = regisInfo.firstName;
    request.fields['last_name'] = regisInfo.lastName;
    request.fields['phone_number'] = regisInfo.phoneNumber;

    // Add other fields as needed

    // Add the image file to the request
    request.files.add(http.MultipartFile.fromBytes(
      'img',
      regisInfo.img,
      filename: 'profile_image.jpg',
    ));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Successfully sent
        final responseBody = await response.stream.bytesToString();
        return responseRegisterModelFromJson(responseBody);
      } else {
        // Handle error responses
        throw Exception(
            'Failed to create account. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      throw Exception('Error creating account: $error');
    }
  }
}
