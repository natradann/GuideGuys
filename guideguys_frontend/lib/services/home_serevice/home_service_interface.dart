import 'package:guideguys/models/tour_card_lg_model.dart';
import 'package:guideguys/modules/home/home_model.dart';

abstract class HomeServiceInterface {
  Future<List<GuideModel>> fetchAllGuides();
  Future<List<TourCardLGModel>> fetchAllTours();
}
