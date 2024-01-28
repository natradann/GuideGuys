import 'package:guideguys/modules/create_confirm_guide/create_confirm_guide_model.dart';
import 'package:guideguys/services/create_confirm_guide_service/create_confirm_guide_service.dart';
import 'package:guideguys/services/create_confirm_guide_service/create_confirm_guide_service_interface.dart';

class CreateConfirmGuideViewModel {
  CreateConFirmGuideServiceInterface service = CreateConfirmGuideService();
  late GuideInfoModel guideInfo;
  CreateConfirmGuideModel confirmForm = CreateConfirmGuideModel(
    tourId: '',
    tourName: '',
    customerId: 'customerId',
    guideId: 'guidId',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    price: '',
    headCount: '',
    plan: '',
    aptDate: DateTime.now(),
    aptPlace: '',
    status: '0',
  );

  Iterable<TourModel> filterTour(String text) {
    if (text == '') {
      return guideInfo.tour;
    }
    return guideInfo.tour.where(
        (tour) => tour.tourName.toLowerCase().contains(text.toLowerCase()));
  }

  // Future<bool> enterFormInfo(
  //     {required String tourId,
  //     required String tourName,
  //     required String customerId,
  //     required String guidId,
  //     required String startDate,
  //     required String endDate,
  //     required String price,
  //     required String headCount,
  //     required String tourPlan,
  //     required String aptDate,
  //     required String aptPlace}) async {
  //   try {
  //     confirmForm = CreateConfirmGuideModel(
  //         tourId: tourId,
  //         tourName: tourName,
  //         customerId: customerId,
  //         guideId: guidId,
  //         startDate: DateTime.now(),
  //         endDate: DateTime.now(),
  //         price: price,
  //         headCount: headCount,
  //         plan: tourPlan,
  //         aptDate: DateTime.now(),
  //         aptPlace: aptPlace,
  //         status: 'waiting for confirm');
  //     return true;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<bool> fetchGuideInfo() async {
    try {
      guideInfo = await service.fetchGuideInfoForConfirmForm();
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> createConfirmForm() async {
    try {
      await service.createForm(confirmForm: confirmForm);
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
