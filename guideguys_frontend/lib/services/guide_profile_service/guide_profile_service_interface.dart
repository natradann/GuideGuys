import 'package:guideguys/modules/guide_profile/guide_profile_model.dart';

abstract class GuideProfileServiceInterface {
  Future<GuideProfileModel> fetchGuideProfile({required String guideId});
}
