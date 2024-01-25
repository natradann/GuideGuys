import 'package:guideguys/modules/guide_profile/guide_profile_model.dart';
import 'package:guideguys/services/guide_profile_service/guide_profile_service.dart';
import 'package:guideguys/services/guide_profile_service/guide_profile_service_interface.dart';

class GuideProfileViewModel {
  GuideProfileServiceInterface service = GuideProfileService();
  late GuideProfileModel guideProfile;

  List<TourModel> alltours = [
    TourModel(
        tourId: '1',
        tourName: 'cdecvd',
        convinces: ['กทม', 'ปราจัน'],
        tourType: ['cscs'],
        tourPrice: 100,
        tourRatePoint: 3.5),
    TourModel(
        tourId: '1',
        tourName: 'cdecvd',
        convinces: ['กทม', 'ปราจัน'],
        tourType: ['cscs'],
        tourPrice: 100,
        tourRatePoint: 3.5),
    TourModel(
        tourId: '1',
        tourName: 'cdecvd',
        convinces: ['กทม', 'ปราจัน'],
        tourType: ['cscs'],
        tourPrice: 100,
        tourRatePoint: 3.5),
    TourModel(
        tourId: '1',
        tourName: 'cdecvd',
        convinces: ['กทม', 'ปราจัน'],
        tourType: ['cscs'],
        tourPrice: 100,
        tourRatePoint: 3.5),
    TourModel(
        tourId: '1',
        tourName: 'cdecvd',
        convinces: ['กทม', 'ปราจัน'],
        tourType: ['cscs'],
        tourPrice: 100,
        tourRatePoint: 3.5),
  ];

  Future<bool> fetchGuideProfile({required String id}) async {
    try {
      guideProfile = await service.fetchGuideProfile(guideId: id);
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
