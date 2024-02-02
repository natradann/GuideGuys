import 'package:guideguys/modules/guide_register/guide_register_model.dart';

abstract class GuideRegisterServiceInterface {
  Future<String> guideRegister({required GuideRegisterModel newGuide});
}
