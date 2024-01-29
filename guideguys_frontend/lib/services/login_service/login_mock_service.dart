import 'package:guideguys/modules/login/login_model.dart';
import 'package:guideguys/services/login_service/login_service_interface.dart';

class LoginMockService implements LoginServiceInterface {
  @override
  Future<ResponseLoginModel> vertifyAccount(
      {required LoginModel userInfo}) async {
    if (userInfo.username == 'Nina' && userInfo.password == 'hello123') {
      // String token = jsonDecode(jsonEncode(mockup))["token"];
      return ResponseLoginModel(
          myGuideId: 'd',
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im5pbmsiLCJpYXQiOjE3MDYwMDQzMjksImV4cCI6MzQxMjM2ODY1OCwiaXNzIjoiY29vbElzc3VlciJ9.Lo9TUzNiHw912gEEE1nvYQWUZCnSvCd2Kwu4Juh8kSY",
          userId: "6497978a-3dae-47dc-bd2c-b2d903c82291",
          username: "nink",
          email: "natradaa@email.com");
    } else if (userInfo.username == 'Nina' && userInfo.password != 'hello123') {
      throw Exception('รหัสผ่านไม่ถูกต้อง');
    } else if (userInfo.username == '' || userInfo.password == '') {
      throw Exception('โปรดใส่ข้อมูลให้ครบถ้วน');
    } else if (userInfo.username != 'Nina' && userInfo.username != '') {
      throw Exception('ไม่พบผู้ใช้งาน');
    } else {
      throw Exception("Unknown Error");
    }
  }
}

const mockup = {
  "message": "Auth Successful",
  "token":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ik5pbmEiLCJpYXQiOjE3MDE5NjIwNDUsImV4cCI6MzQwNDI4NDA5MCwiaXNzIjoiY29vbElzc3VlciJ9.o7N58psML-Rtj8EFKhbHWfdw5tVGprcwqoboMHnU-nQ"
};
