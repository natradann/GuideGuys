import 'package:guideguys/modules/review_tour/review_tour_model.dart';

abstract class ReviewTourServiceInterface {
  Future<bool> rateTourHistory({required ReviewTourModel reviewTour});
}
