import 'package:guideguys/modules/create_tour/create_tour_model.dart';

abstract class CreateTourServiceInterface {
  Future<void> createTour({required CreateTourModel newTour});
}
