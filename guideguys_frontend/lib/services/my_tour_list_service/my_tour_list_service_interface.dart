import 'package:guideguys/modules/my_tour_list/my_tour_list_model.dart';

abstract class MyTourListServiceInterface {
  Future<List<MyTourListModel>> fetchMyTourList();
}
