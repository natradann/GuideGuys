import 'package:guideguys/modules/guide_register/guide_register_model.dart';
import 'package:guideguys/services/guide_register_service/guide_register_service.dart';
import 'package:guideguys/services/guide_register_service/guide_register_service_interface.dart';
import 'package:textfield_tags/textfield_tags.dart';

class GuideRegisterViewModel {
  GuideRegisterServiceInterface service = GuideRegisterService();

  GuideRegisterModel newGuideInfo = GuideRegisterModel(
    guideCardNumber: '',
    guideCardType: '',
    expiredDate: DateTime.now(),
    convinces: [],
    languages: [],
    experience: '',
  );

  Future<bool> onUserRegisterGuide(
      {required String cardNo,
      required String cardType,
      required DateTime expiredDate,
      required List<String> convinces,
      required TextfieldTagsController languageList,
      required String experience}) async {
    try {
      newGuideInfo = GuideRegisterModel(
        guideCardNumber: cardNo,
        guideCardType: cardType,
        expiredDate: expiredDate,
        convinces: convinces,
        languages: languageList.getTags!,
        experience: experience,
      );
      await service.guideRegister(newGuide: newGuideInfo);
      return true;
    } catch (_) {
      return false;
    }
  }
}
