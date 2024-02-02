import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/confirm_guide_detail/confirm_guide_detail_model.dart';
import 'package:guideguys/services/confirm_guide_detail_service/confirm_guide_detail_service.dart';
import 'package:guideguys/services/confirm_guide_detail_service/confirm_guide_detail_service_interface.dart';

class ConfirmGuideDetailViewModel {
  ConfirmGuideDetailServiceInterface service = ConfirmGuideDatailService();
  late ConfirmGuideDetailModel formDetail;
  late String myUsername;

  Future<bool> fetchConfirmGuideDatail({required String historyId}) async {
    try {
      myUsername = await SecureStorage().readSecureData('myUsername');
      formDetail =
          await service.fetchConfirmGuideFormModel(historyId: historyId);
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
