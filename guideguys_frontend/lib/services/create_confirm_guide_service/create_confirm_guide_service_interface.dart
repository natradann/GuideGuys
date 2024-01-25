import 'package:guideguys/modules/create_confirm_guide/create_confirm_guide_model.dart';

abstract class CreateConFirmGuideServiceInterface {
  Future<GuideInfoModel> fetchGuideInfoForConfirmForm();
  Future<void> createForm({required CreateConfirmGuideModel confirmForm});
}
