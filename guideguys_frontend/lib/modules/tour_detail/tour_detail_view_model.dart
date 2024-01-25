import 'package:guideguys/modules/tour_detail/tour_detail_model.dart';
import 'package:guideguys/services/tour_detail_service/tour_datail_service_interface.dart';
import 'package:guideguys/services/tour_detail_service/tour_detail_service.dart';

class TourDetailViewModel {
  TourDetailServiceInterface service = ToureDetailService();
  late TourDetailModel tour;

  Future<bool> fetchTourDetail({required String tourId}) async {
    try {
      tour = await service.fetchTourDetail(tourId: tourId);
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
