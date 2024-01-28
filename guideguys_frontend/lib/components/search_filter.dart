import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({
    required this.checkValue,
    required this.screenWidht,
    required this.typeTourList,
    required this.typeVehicleList,
    this.onUpdate,
    super.key,
  });

  final bool checkValue;
  final double screenWidht;
  List<String> typeTourList;
  List<String> typeVehicleList;
  final Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    print('hi');
    List<String> typeList = [];
    List<String> vehicleList = [];
    return IconButton(
      onPressed: () {
        typeList = typeTourList;
        vehicleList = typeVehicleList;
        print('typeList-1: $typeList');
        print('tourTypeList-1: $typeTourList');
        filterOption(context, checkValue, typeList, vehicleList);
      },
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.filter_alt,
        color: Colors.grey[600],
      ),
      iconSize: screenWidht * 0.08,
    );
  }

  Future<void> filterOption(
    BuildContext context,
    bool isTrue,
    List<String> typeList,
    List<String> vehicleList,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        late bool adventure = false;
        late bool shopping = false;
        late bool nature = false;
        late bool culture = false;
        late bool rural = false;
        late bool darkTour = false;
        late bool pubTrans = false;
        late bool priCar = false;
        late bool train = false;
        late bool boat = false;
        late bool walk = false;
        for (String type in typeTourList) {
          if (type == 'ผจญภัย') {
            adventure = true;
          } else if (type == 'ชอปปิง') {
            shopping = true;
          } else if (type == 'ธรรมชาติ') {
            nature = true;
          } else if (type == 'วัฒนธรรม ประวัติศาสตร์') {
            culture = true;
          } else if (type == 'ชนบท') {
            rural = true;
          } else if (type == 'Dark Tourism') {
            darkTour = true;
          }
        }
        for (String vehicle in typeVehicleList) {
          if (vehicle == 'รถสาธารณะ') {
            pubTrans = true;
          } else if (vehicle == 'รถยนต์ส่วนตัว') {
            priCar = true;
          } else if (vehicle == 'รถไฟ') {
            train = true;
          } else if (vehicle == 'เรือ') {
            boat = true;
          } else if (vehicle == 'เดิน') {
            walk = true;
          }
        }
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: bgColor,
          contentPadding: const EdgeInsets.all(15),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ประเภททัวร์',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                typeTourMultiSelect(
                  adventure,
                  shopping,
                  nature,
                  culture,
                  rural,
                  darkTour,
                  typeList,
                  setState,
                ),
                const SizedBox(height: 20),
                const Text(
                  'ยานพาหนะ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                vehicleMultiSelect(
                  priCar,
                  pubTrans,
                  train,
                  boat,
                  walk,
                  vehicleList,
                ),
              ],
            );
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: textPurple),
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) => TextButton(
                onPressed: () {
                  // typeTourList = List.from(typeList); // Create a new list
                  // typeVehicleList = List.from(vehicleList);
                  print('typeTourList-2: $typeList');
                  print('typeVehicle-2: $vehicleList');

                  onUpdate!();

                  Navigator.pop(context, 'OK');
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: textPurple),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  MultiSelectContainer<String> vehicleMultiSelect(
    bool priCar,
    bool pubTrans,
    bool train,
    bool boat,
    bool walk,
    List<String> vehicleList,
  ) {
    return MultiSelectContainer(
      itemsDecoration: MultiSelectDecorations(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
          border: Border.all(color: yellow),
        ),
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: yellow,
          border: Border.all(color: yellow),
        ),
      ),
      items: [
        MultiSelectCard(
            value: 'รถยนต์ส่วนตัว', label: 'รถยนต์ส่วนตัว', selected: priCar),
        MultiSelectCard(
            value: 'รถสาธารณะ', label: 'รถสาธารณะ', selected: pubTrans),
        MultiSelectCard(
          value: 'รถไฟ',
          label: 'รถไฟ',
          selected: train,
        ),
        MultiSelectCard(
          value: 'เรือ',
          label: 'เรือ',
          selected: boat,
        ),
        MultiSelectCard(
          value: 'เดิน',
          label: 'เดิน',
          selected: walk,
        ),
      ],
      onChange: (allSelectedItems, selectedItem) {
        typeVehicleList = allSelectedItems;
      },
    );
  }

  MultiSelectContainer<String> typeTourMultiSelect(
    bool adventure,
    bool shopping,
    bool nature,
    bool culture,
    bool rural,
    bool darkTour,
    List<String> typeList,
    StateSetter setState,
  ) {
    return MultiSelectContainer(
      itemsDecoration: MultiSelectDecorations(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
          border: Border.all(color: yellow),
        ),
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: yellow,
          border: Border.all(color: yellow),
        ),
      ),
      items: [
        MultiSelectCard(
          value: 'ผจญภัย',
          label: 'ผจญภัย',
          selected: adventure,
        ),
        MultiSelectCard(
          value: 'ชอปปิง',
          label: 'ชอปปิง',
          selected: shopping,
        ),
        MultiSelectCard(
          value: 'ธรรมชาติ',
          label: 'ธรรมชาติ',
          selected: nature,
        ),
        MultiSelectCard(
          value: 'วัฒนธรรม ประวัติศาสตร์',
          label: 'วัฒนธรรม ประวัติศาสตร์',
          selected: culture,
        ),
        MultiSelectCard(
          value: 'ชนบท',
          label: 'ชนบท',
          selected: rural,
        ),
        MultiSelectCard(
            value: 'Dark Tourism', label: 'Dark Tourism', selected: darkTour),
      ],
      onChange: (allSelectedItems, selectedItem) {
        setState(() {
          typeTourList = allSelectedItems;
        });
      },
    );
  }
}
