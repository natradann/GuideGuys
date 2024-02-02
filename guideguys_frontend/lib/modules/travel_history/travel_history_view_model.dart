import 'package:guideguys/local_storage/secure_storage.dart';
import 'package:guideguys/modules/travel_history/travel_history_model.dart';
import 'package:guideguys/services/travel_history_service/travel_history_service.dart';
import 'package:guideguys/services/travel_history_service/travel_history_service_interface.dart';

class TravelHistoryViewModel {
  TravelHistoryServiceInterface service = TravelHistoryService();
  late TravelHistoryModel allTourHistory;
  late Future<TravelHistoryModel> allTourHistoryData;
  late String myUsername;
  late String myEmail;

  Future<void> fetchTravelHistory() async {
    try {
      allTourHistoryData = service.fetchTravelHistory();
      allTourHistory = await allTourHistoryData;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> fetchSecureData() async {
    try {
      myUsername = await SecureStorage().readSecureData('myUsername');
      myEmail = await SecureStorage().readSecureData('myEmail');
    } catch (_) {
      rethrow;
    }
  }
}
