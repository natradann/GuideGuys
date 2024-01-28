import 'dart:convert';
import 'dart:typed_data';
import 'package:guideguys/modules/create_tour/create_tour_model.dart';
import 'package:guideguys/services/create_tour_service/create_tour_service.dart';
import 'package:guideguys/services/create_tour_service/create_tour_service_interface.dart';

class CreateTourViewModel {
  CreateTourServiceInterface service = CreateTourService();
  late CreateTourModel newTour;
  List<String> tourTypes = ["ชอปปิง"];
  List<String> convinces = [
    "กรุงเทพ",
    "สมุทรปราการ",
    "นนทบุรี",
    "ปทุมธานี",
    "สระบุรี",
  ];
  List<String> vehicles = [
    "รถส่วนตัว",
    "รถสาธารณะ",
    "เรือ",
    "เดิน",
    "รถไฟ",
  ];

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
        base64Image: base64Encode(imageFile),
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
