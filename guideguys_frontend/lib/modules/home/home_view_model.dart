import 'package:guideguys/models/tour_card_lg_model.dart';
import 'package:guideguys/modules/home/home_model.dart';
import 'package:guideguys/services/home_serevice/home_mock_service.dart';
import 'package:guideguys/services/home_serevice/home_service.dart';
import 'package:guideguys/services/home_serevice/home_service_interface.dart';

class HomeViewModel {
  HomeServiceInterface service = HomeService();
  // late Future<List<GuideModel>> allGuidesData;
  // late Future<List<TourCardLGModel>> allToursData;
  late List<GuideModel> allGuides;
  late List<TourCardLGModel> allTours;
  // late List<GuideModel> filteredGuides;
  // late List<TourCardLGModel> filteredTours;
  List<String> tagList = [];
  List<String> typeTourList = [];
  List<String> typeVehicleList = [];
  late Future<HomeData> homeData;

  Future<HomeData> fetchAllInfo() async {
    List res = await Future.wait([
      service.fetchAllGuides(),
      service.fetchAllTours(),
    ]);

    allGuides = res[0];
    allTours = res[1];

    return HomeData(allGuideList: allGuides, allTourList: allTours);
  }

  List<TourCardLGModel> filterTours() {
    List<TourCardLGModel> tagListFiltered = [];
    List<TourCardLGModel> typeTourListFiltered = [];
    List<TourCardLGModel> typeVehicleListFiltered = [];
    if (tagList.isEmpty && typeTourList.isEmpty && typeVehicleList.isEmpty) {
      return allTours;
    } else if (tagList.isNotEmpty) {
      tagListFiltered = tagList
          .expand((tagText) => allTours.where((tour) {
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
          .expand((typeText) => allTours.where((tour) {
                bool areTourTypesMatch = tour.type.any((tourType) =>
                    tourType.toLowerCase().contains(typeText.toLowerCase()));

                return areTourTypesMatch;
              }))
          .toList();
    } else if (typeVehicleList.isNotEmpty) {
      typeVehicleListFiltered = typeVehicleList
          .expand((vehicleText) => allTours.where((tour) {
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

  List<GuideModel> filterGuides() {
    List<GuideModel> tagListFiltered = [];
    List<GuideModel> typeTourListFiltered = [];
    List<GuideModel> typeVehicleListFiltered = [];
    if (tagList.isEmpty && typeTourList.isEmpty && typeVehicleList.isEmpty) {
      return allGuides;
    } else if (tagList.isNotEmpty) {
      tagListFiltered = tagList
          .expand((tagText) => allGuides.where((guide) {
                bool isGuideNameMatch = guide.guideName
                    .toLowerCase()
                    .contains(tagText.toLowerCase());

                bool areConvincesMatch = guide.convinces.any((convince) =>
                    convince.toLowerCase().contains(tagText.toLowerCase()));

                bool arelanguagesMatch = guide.languages.any((language) =>
                    language.toLowerCase().contains(tagText.toLowerCase()));

                bool areTourNamesMatch = guide.tourNames.any((tourName) =>
                    tourName.toLowerCase().contains(tagText.toLowerCase()));

                bool areTourTypesMatch = guide.tourTypes.any((tourType) =>
                    tourType.toLowerCase().contains(tagText.toLowerCase()));

                bool areVehiclesMatch = guide.allVehicles.any((vehicle) =>
                    vehicle.toLowerCase().contains(tagText.toLowerCase()));

                return isGuideNameMatch ||
                    areConvincesMatch ||
                    arelanguagesMatch ||
                    areTourNamesMatch ||
                    areTourTypesMatch ||
                    areVehiclesMatch;
              }))
          .toSet()
          .toList();
    } else if (typeTourList.isNotEmpty) {
      typeTourListFiltered = typeTourList
          .expand((typeText) => allGuides.where((tour) {
                bool areTourTypesMatch = tour.tourTypes.any((tourType) =>
                    tourType.toLowerCase().contains(typeText.toLowerCase()));

                return areTourTypesMatch;
              }))
          .toList();
    } else if (typeVehicleList.isNotEmpty) {
      typeVehicleListFiltered = typeVehicleList
          .expand((vehicleText) => allGuides.where((tour) {
                bool areVehiclesMatch = tour.allVehicles.any((vehicle) =>
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

class HomeData {
  List<GuideModel> allGuideList;
  List<TourCardLGModel> allTourList;

  HomeData({
    required this.allGuideList,
    required this.allTourList,
  });
}
