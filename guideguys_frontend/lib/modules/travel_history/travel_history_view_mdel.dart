import 'package:guideguys/modules/travel_history/travel_history_model.dart';
import 'package:guideguys/services/travel_history_service/travel_history_service.dart';
import 'package:guideguys/services/travel_history_service/travel_history_service_interface.dart';

class TravelHistoryViewModel {
  TravelHistoryServiceInterface service = TravelHistoryService();
  late List<TravelHistoryModel> allTourHistory;

  Future<bool> fetchTrevelHistory() async {
    try {
      allTourHistory = await service.fetchTravelHistory();
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
