import 'package:guideguys/modules/travel_history/travel_history_model.dart';

abstract class TravelHistoryServiceInterface {
  Future<TravelHistoryModel> fetchTravelHistory();
}
