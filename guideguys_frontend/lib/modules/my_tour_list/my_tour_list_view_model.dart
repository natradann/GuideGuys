import 'package:guideguys/modules/my_tour_list/my_tour_list_model.dart';
import 'package:guideguys/services/my_tour_list_service/my_tour_list_service.dart';
import 'package:guideguys/services/my_tour_list_service/my_tour_list_service_interface.dart';

class MyTourListViewModel {
  MyTourListServiceInterface service = MyTourListService();
  late List<MyTourListModel> myTourList;
  late Future<List<MyTourListModel>> myTourListData;
  List<String> tagList = [];
  List<String> typeTourList = [];
  List<String> typeVehicleList = [];

  Future<void> fetchAllTourList() async {
    try {
      myTourListData = service.fetchMyTourList();
      myTourList = await myTourListData;
    } catch (_) {
      rethrow;
    }
  }

  List<MyTourListModel> filterTours() {
    List<MyTourListModel> tagListFiltered = [];
    List<MyTourListModel> typeTourListFiltered = [];
    List<MyTourListModel> typeVehicleListFiltered = [];

    if (tagList.isEmpty && typeTourList.isEmpty && typeVehicleList.isEmpty) {
      return myTourList;
    } else if (tagList.isNotEmpty) {
      tagListFiltered = tagList
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

                return (isTourNameMatch ||
                    areConvincesMatch ||
                    arelanguagesMatch ||
                    areTourTypesMatch ||
                    areVehiclesMatch);
              }))
          .toList();
    } else if (typeTourList.isNotEmpty) {
      typeTourListFiltered = typeTourList
          .expand((typeText) => myTourList.where((tour) {
                bool areTourTypesMatch = tour.type.any((tourType) =>
                    tourType.toLowerCase().contains(typeText.toLowerCase()));

                return areTourTypesMatch;
              }))
          .toList();
    } else if (typeVehicleList.isNotEmpty) {
      typeVehicleListFiltered = typeVehicleList
          .expand((vehicleText) => myTourList.where((tour) {
                bool areVehiclesMatch = tour.vehicles.any((vehicle) =>
                    vehicle.toLowerCase().contains(vehicleText.toLowerCase()));

                return areVehiclesMatch;
              }))
          .toList();
    }

    return {
      ...tagListFiltered,
      ...typeTourListFiltered,
      ...typeVehicleListFiltered
    }.toSet().toList();
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
