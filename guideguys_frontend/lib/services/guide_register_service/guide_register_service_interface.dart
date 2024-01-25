import 'package:guideguys/modules/guide_register/guide_register_model.dart';

abstract class GuideRegisterServiceInterface {
  Future<void> guideRegister({required GuideRegisterModel newGuide});
}
