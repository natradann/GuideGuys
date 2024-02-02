import 'dart:convert';
import 'dart:typed_data';

import 'package:guideguys/data/mock_data.dart';
import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/guide_register/guide_register_model.dart';
import 'package:guideguys/services/guide_register_service/guide_register_service.dart';
import 'package:guideguys/services/guide_register_service/guide_register_service_interface.dart';
import 'package:textfield_tags/textfield_tags.dart';

class GuideRegisterViewModel {
  GuideRegisterServiceInterface service = GuideRegisterService();
  List<String> convinces = convincesInThai;

  GuideRegisterModel newGuideInfo = GuideRegisterModel(
    base64CardImage: Uint8List(4),
    guideCardNumber: '',
    guideCardType: '',
    expiredDate: DateTime.now(),
    convinces: [],
    languages: [],
    experience: '',
  );

  Future<bool> onUserRegisterGuide({
    required Uint8List cardImage,
    required String cardNo,
    required String cardType,
    required DateTime expiredDate,
    required List<String> convinces,
    required TextfieldTagsController languageList,
    required String experience,
  }) async {
    try {
      newGuideInfo = GuideRegisterModel(
        base64CardImage: cardImage,
        guideCardNumber: cardNo,
        guideCardType: cardType,
        expiredDate: expiredDate,
        convinces: convinces,
        languages: languageList.getTags!,
        experience: experience,
      );
      String guideId = await service.guideRegister(newGuide: newGuideInfo);
      print(guideId);
      await SecureStorage().writeSecureData('myGuideId', guideId);
      return true;
    } catch (_) {
      return false;
    }
  }
}
