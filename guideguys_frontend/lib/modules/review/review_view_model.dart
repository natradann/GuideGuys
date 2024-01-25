import 'package:guideguys/modules/review/review_model.dart';
import 'package:guideguys/services/review_service/review_service.dart';
import 'package:guideguys/services/review_service/review_service_interface.dart';

class ReviewViewModel {
  ReviewServiceInterface service = ReviewService();
  late ReviewModel allReviews;

  Future<bool> fetchAllReview({required String tourId}) async {
    try {
      allReviews = await service.fetchAllReviewByTourId(tourId: tourId);
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
