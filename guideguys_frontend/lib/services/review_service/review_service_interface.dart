import 'package:guideguys/modules/review/review_model.dart';

abstract class ReviewServiceInterface {
  Future<ReviewModel> fetchAllReviewByTourId({required String tourId});
}
