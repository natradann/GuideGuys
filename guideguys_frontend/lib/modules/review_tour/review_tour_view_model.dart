import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/review_tour/review_tour_model.dart';
import 'package:guideguys/services/review_tour_service/review_tour_service.dart';
import 'package:guideguys/services/review_tour_service/review_tour_service_interface.dart';

class ReviewTourViewModel {
  ReviewTourServiceInterface service = ReviewTourService();
  late ReviewTourModel reviewTour;

  Future<bool> saveReviewTour({
    required String historyId,
    required String tourId,
    required int point,
    required String comment,
  }) async {
    String userId = await SecureStorage().readSecureData('myUserId');
    print(tourId);
    try {
      reviewTour = ReviewTourModel(
        historyId: historyId,
        userId: userId,
        tourId: tourId,
        point: point,
        comment: comment,
        commentDate: DateTime.now(),
      );
      bool isSaved = await service.rateTourHistory(reviewTour: reviewTour);

      return isSaved;
    } catch (_) {
      rethrow;
    }
  }
}
