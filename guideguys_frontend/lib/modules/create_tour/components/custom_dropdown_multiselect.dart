import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/textfield_decoration.dart';

typedef UpdateValueCallbackFunction = void Function(
    {required List<String> value});

class CustomDropdownMultiSelect extends StatelessWidget {
  final String labelTitle;
  final Color primaryColor;
  final bool isCreate;
  final List<String> value;
  final List<String> choiceItemList;
  final double? labelTextSize;
  final String hintText;
  final String? searchText;
  final UpdateValueCallbackFunction updateValueCallback;
  final GlobalKey<DropdownSearchState<String>> dropdownKey;
  const CustomDropdownMultiSelect({
    required this.labelTitle,
    required this.primaryColor,
    required this.isCreate,
    required this.value,
    required this.choiceItemList,
    this.labelTextSize,
    this.searchText,
    required this.hintText,
    required this.updateValueCallback,
    required this.dropdownKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTitle,
          style: const TextStyle(
            color: grey700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
        DropdownSearch<String>.multiSelection(
          dropdownButtonProps: DropdownButtonProps(
            color: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          ),
          selectedItems: isCreate ? [] : value,
          key: dropdownKey,
          popupProps: PopupPropsMultiSelection.modalBottomSheet(
            selectionWidget: (BuildContext context, String temp, bool isCheck) {
              return Checkbox(
                activeColor: primaryColor,
                value: isCheck,
                onChanged: (bool? value) {},
              );
            },
            modalBottomSheetProps: ModalBottomSheetProps(
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validationWidgetBuilder: (ctx, selectedItems) {
              return Container(
                height: 80,
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(right: 5, bottom: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ตกลง',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    dropdownKey.currentState?.popupOnValidate();
                  },
                ),
              );
            },
            itemBuilder: (BuildContext context, String item, bool isSelect) {
              return _itemForm(item, isSelect);
            },
            showSearchBox: true,
            showSelectedItems: true,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.search, color: yellow),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: yellowBorder,
                focusedBorder: yellowBorder,
              ),
              cursorColor: yellow,
            ),
          ),
          dropdownBuilder: (BuildContext context, List<String> selectedItems) {
            if (selectedItems.isEmpty) {
              return const SizedBox();
            }
            return itemInTextField(selectedItems);
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: grey700),
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
            enabledBorder: yellowBorder,
            focusedBorder: yellowBorder,
          )),
          items: choiceItemList,
          onChanged: (val) {
            updateValueCallback(value: val);
          },
        ),
      ],
    );
  }

  Row _itemForm(String item, bool isSelect) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(
          item,
          style: TextStyle(
            fontSize: 16,
            color: isSelect ? primaryColor : Colors.black,
          ),
        ),
      ],
    );
  }

  Wrap itemInTextField(List<String> selectedItems) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: selectedItems
          .map((item) => Text(
                item,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ))
          .toList(),
    );
  }
}
