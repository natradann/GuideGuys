import 'package:guideguys/modules/tour_detail/tour_detail_model.dart';

abstract class TourDetailServiceInterface {
  Future<TourDetailModel> fetchTourDetail({required String tourId});
}
