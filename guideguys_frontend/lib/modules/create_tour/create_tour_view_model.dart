import 'dart:convert';
import 'dart:typed_data';
import 'package:guideguys/data/mock_data.dart';
import 'package:guideguys/modules/create_tour/create_tour_model.dart';
import 'package:guideguys/services/create_tour_service/create_tour_service.dart';
import 'package:guideguys/services/create_tour_service/create_tour_service_interface.dart';

class CreateTourViewModel {
  CreateTourServiceInterface service = CreateTourService();
  late CreateTourModel newTour;
  List<String> tourTypes = allTourTypes;
  List<String> convinces = convincesInThai;
  List<String> vehicles = allVehicleTypes;

  Future<bool> createNewTour({
    required String tourName,
    required Uint8List imageFile,
    required List<String> tourType,
    required List<String> convinces,
    required List<String> vehicles,
    required String tourDetail,
    required String price,
  }) async {
    try {
      newTour = CreateTourModel(
        tourName: tourName,
        base64Image: imageFile,
        convinces: convinces,
        vehicle: vehicles,
        tourType: tourType,
        detail: tourDetail,
        price: int.parse(price),
      );

      await service.createTour(newTour: newTour);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
