import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/purple_white_pair_button.dart';
import 'package:guideguys/components/textfield_sm.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/text_styles.dart';
import 'package:guideguys/modules/create_tour/components/custom_dropdown_multiselect.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:guideguys/modules/create_tour/create_tour_view_model.dart';
import 'package:guideguys/modules/my_tour_list/my_tour_list_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class CreateTourView extends StatefulWidget {
  const CreateTourView({super.key});

  @override
  State<CreateTourView> createState() => _CreateTourViewState();
}

class _CreateTourViewState extends State<CreateTourView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late CreateTourViewModel _viewModel;
  final _tourTypeBuilderKey = GlobalKey<DropdownSearchState<String>>();
  final _convinceBuilderKey = GlobalKey<DropdownSearchState<String>>();
  final _vehicleBuilderKey = GlobalKey<DropdownSearchState<String>>();
  late TextEditingController tourName;
  late TextEditingController tourDetail;
  late TextEditingController tourPrice;
  late List<String> tourTypeSelected;
  late List<String> convinceSelected;
  late List<String> vehicleSelected;
  Uint8List? image;
  String? imageName;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );

      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        final imageFileName = path.basename(pickedFile.path);

        setState(() {
          image = imageBytes;
          imageName = imageFileName;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _viewModel = CreateTourViewModel();
    tourName = TextEditingController();
    tourDetail = TextEditingController();
    tourPrice = TextEditingController();
    tourTypeSelected = [];
    convinceSelected = [];
    vehicleSelected = [];
  }

  @override
  void dispose() {
    super.dispose();
    tourName.dispose();
    tourDetail.dispose();
    tourPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        appBar: CustomAppBar(
          appBarKey: _scaffoldKey,
        ),
        endDrawer: ProfileMenu(width: width),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            children: [
              const Text(
                'เพิ่มโปรแกรมการเที่ยว',
                style: titlePuple,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Column(
                      children: [
                        TextFieldSM(
                          labelTFF: 'ชื่อทัวร์',
                          hintTextinTFF: 'ชื่อทัวร์',
                          textController: tourName,
                          inputAction: TextInputAction.next,
                        ),
                        TextFieldSM(
                          labelTFF: 'รูปภาพหน้าปก',
                          hintTextinTFF: 'เพิ่มรูปภาพหน้าปก',
                          pfIcon: IconButton(
                            icon: const Icon(Icons.add_a_photo_outlined),
                            color: grey500,
                            onPressed: () async {
                              pickImage();
                            },
                          ),
                          inputType: TextInputType.none,
                          textController:
                              TextEditingController(text: imageName),
                          inputAction: TextInputAction.next,
                        ),
                        CustomDropdownMultiSelect(
                          labelTitle: 'ประเภททัวร์นำเที่ยว',
                          primaryColor: yellow,
                          isCreate: tourTypeSelected.isEmpty,
                          value: tourTypeSelected,
                          choiceItemList: _viewModel.tourTypes,
                          hintText: 'เลือกประเภทการนำเที่ยว',
                          updateValueCallback: ({required List<String> value}) {
                            tourTypeSelected = value;
                          },
                          dropdownKey: _tourTypeBuilderKey,
                        ),
                        CustomDropdownMultiSelect(
                          labelTitle: 'จังหวัดที่นำเที่ยว',
                          primaryColor: yellow,
                          isCreate: convinceSelected.isEmpty,
                          value: convinceSelected,
                          choiceItemList: _viewModel.convinces,
                          hintText: 'เลือกจังหวัด',
                          updateValueCallback: ({required List<String> value}) {
                            convinceSelected = value;
                          },
                          dropdownKey: _convinceBuilderKey,
                        ),
                        // TextFieldSM(
                        //   labelTFF: 'จำนวนคน',
                        //   hintTextinTFF: 'จำนวนคนที่รับนำเที่ยว',
                        //   textController: TextEditingController(),
                        //   inputAction: TextInputAction.next,
                        // ),
                        CustomDropdownMultiSelect(
                          labelTitle: 'การเดินทาง/ยานพาหนะ',
                          primaryColor: yellow,
                          isCreate: vehicleSelected.isEmpty,
                          value: vehicleSelected,
                          choiceItemList: _viewModel.vehicles,
                          hintText: 'เพิ่มการเดินทาง/ยานพาหนะ',
                          updateValueCallback: ({required List<String> value}) {
                            vehicleSelected = value;
                          },
                          dropdownKey: _vehicleBuilderKey,
                        ),
                        TextFieldSM(
                          labelTFF: 'ราคา',
                          hintTextinTFF: 'ราคาทัวร์',
                          textController: tourPrice,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.number,
                        ),
                        TextFieldSM(
                          labelTFF: 'รายละเอียดทัวร์',
                          hintTextinTFF: 'เพิ่มรายละเอียดทัวร์',
                          textController: tourDetail,
                          inputAction: TextInputAction.none,
                          minLineAmount: 5,
                        ),
                        const SizedBox(height: 20),
                        PurpleWhitePairButton(
                          whiteButtonText: 'ยกเลิก',
                          purpleButtonText: 'ยืนยัน',
                          whiteButtonFn: () {
                            Navigator.pop(context);
                          },
                          purpleButtonFn: () async {
                            bool isCreateTour = await _viewModel.createNewTour(
                              tourName: tourName.text,
                              imageFile: image!,
                              tourType: tourTypeSelected,
                              convinces: convinceSelected,
                              vehicles: vehicleSelected,
                              tourDetail: tourDetail.text,
                              price: tourPrice.text,
                            );

                            if (isCreateTour && mounted) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyTourListView(),
                                ),
                              );
                            }
                          },
                          width: width * 0.4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
