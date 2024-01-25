import 'package:guideguys/models/tour_card_lg_model.dart';
import 'package:guideguys/modules/home/home_model.dart';
import 'package:guideguys/services/home_serevice/home_mock_service.dart';
import 'package:guideguys/services/home_serevice/home_service.dart';
import 'package:guideguys/services/home_serevice/home_service_interface.dart';
import 'package:textfield_tags/textfield_tags.dart';

class HomeViewModel {
  HomeServiceInterface service = HomeService();
  late List<GuideModel> allGuides;
  late List<TourCardLGModel> allTours;
  List<String> tagList = [];
  List<String> typeTourList = [];
  List<String> typeVehicleList = [];

  Future<bool> fetchAllInfo() async {
    try {
      allGuides = await service.fetchAllGuides();

      allTours = await service.fetchAllTours();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  List<TourCardLGModel> filterTours() {
    if (tagList.isEmpty) {
      return allTours;
    }
    List<TourCardLGModel> tourFiltered = tagList
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
              return isTourNameMatch ||
                  areConvincesMatch ||
                  arelanguagesMatch ||
                  areTourTypesMatch ||
                  areVehiclesMatch;
            }))
        .toList();
    return tourFiltered;
  }

  List<GuideModel> filterGuides() {
    if (tagList.isEmpty) {
      return allGuides;
    }
    List<GuideModel> guideFiltered = tagList
        .expand((tagText) => allGuides.where((guide) {
              bool isGuideNameMatch =
                  guide.guideName.toLowerCase().contains(tagText.toLowerCase());

              bool areConvincesMatch = guide.convinces.any((convince) =>
                  convince.toLowerCase().contains(tagText.toLowerCase()));

              bool arelanguagesMatch = guide.languages.any((language) =>
                  language.toLowerCase().contains(tagText.toLowerCase()));

              return isGuideNameMatch || areConvincesMatch || arelanguagesMatch;
            }))
        .toSet()
        .toList();
    return guideFiltered;
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

  void onUpdateFilter({required List<String> typeTour, required List<String> typeVehicle}) {
    print(typeTourList);
    print(typeVehicleList);
    // try {
    //   return true;
    // } on Exception catch (_) {
    //   rethrow;
    // }
  }
}
