import 'package:guideguys/modules/confirm_guide_detail/confirm_guide_detail_model.dart';

abstract class ConfirmGuideDetailServiceInterface {
  Future<ConfirmGuideDetailModel> fetchConfirmGuideFormModel(
      {required String historyId});
}
