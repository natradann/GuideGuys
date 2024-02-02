import 'package:guideguys/modules/tour_detail/tour_detail_model.dart';
import 'package:guideguys/services/tour_detail_service/tour_datail_service_interface.dart';
import 'package:guideguys/services/tour_detail_service/tour_detail_service.dart';

class TourDetailViewModel {
  TourDetailServiceInterface service = ToureDetailService();
  late TourDetailModel tour;
  late Future<TourDetailModel> tourData;

  Future<void> fetchTourDetail({required String tourId}) async {
    try {
      tourData = service.fetchTourDetail(tourId: tourId);
      tour = await tourData;
    } catch (_) {
      rethrow;
    }
  }
}
