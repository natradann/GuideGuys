import 'package:guideguys/modules/my_tour_list/my_tour_list_model.dart';
import 'package:guideguys/services/my_tour_list_service/my_tour_list_service.dart';
import 'package:guideguys/services/my_tour_list_service/my_tour_list_service_interface.dart';

class MyTourListViewModel {
  MyTourListServiceInterface service = MyTourListService();
  late List<MyTourListModel> myTourList;
  List<String> tagList = [];

  Future<bool> fetchAllTourList() async {
    try {
      myTourList = await service.fetchMyTourList();
      return true;
    } catch (_) {
      rethrow;
    }
  }

  List<MyTourListModel> filterTours() {
    if (tagList.isEmpty) {
      return myTourList;
    }
    List<MyTourListModel> tourFiltered = tagList
        .expand((tagText) => myTourList.where((tour) {
              bool isTourNameMatch =
                  tour.tourName.toLowerCase().contains(tagText.toLowerCase());

              bool areConvincesMatch = tour.convinces.any((convince) =>
                  convince.toLowerCase().contains(tagText.toLowerCase()));

              bool arelanguagesMatch = tour.languages.any((language) =>
                  language.toLowerCase().contains(tagText.toLowerCase()));

              bool areTourTypesMatch = tour.type.any((tourType) =>
                  tourType.toLowerCase().contains(tagText.toLowerCase()));

              bool areVehiclesMatch = tour.vehicles.any((vehicle) =>
                  vehicle.toLowerCase().contains(tagText.toLowerCase()));
              return isTourNameMatch ||
                  areConvincesMatch ||
                  arelanguagesMatch ||
                  areTourTypesMatch ||
                  areVehiclesMatch;
            }))
        .toList();
    return tourFiltered;
  }

  Future<bool> addTag({required String newTag}) async {
    try {
      tagList.add(newTag);
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> onUserDeleteTag({required String tagName}) async {
    try {
      tagList.remove(tagName);
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
