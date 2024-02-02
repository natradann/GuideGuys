import 'dart:typed_data';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:guideguys/components/purple_white_pair_button.dart';
import 'package:guideguys/components/textfield_sm.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/textfield_decoration.dart';
import 'package:guideguys/modules/create_tour/components/custom_dropdown_multiselect.dart';
import 'package:guideguys/modules/guide_register/guide_register_view_model.dart';
import 'package:guideguys/modules/home/home_view.dart';
import 'package:guideguys/modules/login/login_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:multiselect/multiselect.dart';
import 'package:path/path.dart' as path;

class GuideRegisterView extends StatefulWidget {
  const GuideRegisterView({super.key});

  @override
  State<GuideRegisterView> createState() => _GuideRegisterViewState();
}

class _GuideRegisterViewState extends State<GuideRegisterView> {
  final _convinceBuilderKey = GlobalKey<DropdownSearchState<String>>();
  List<String> typeList = const ["มัคคุเทศก์ทั่วไป", "มัคคุเทศก์เฉพาะ"];
  late GuideRegisterViewModel _viewModel;
  TextEditingController cardNo = TextEditingController();
  String cardType = '';
  DateTime expiredDate = DateTime.now();
  TextEditingController convince = TextEditingController();
  TextfieldTagsController language = TextfieldTagsController();
  TextEditingController exp = TextEditingController();
  late List<String> convinceSelected = [];
  Uint8List? cardImage;
  String? cardImageName;

  Future<DateTime> _selectDate({
    required TextEditingController dateController,
    required DateTime datePicked,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: yellow,
            onPrimary: black,
            surface: bgColor,
            secondary: bgPurple,
          ),
          dialogBackgroundColor: bgColor,
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: child!,
      ),
      initialDate: datePicked,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      return picked;
    }
    return DateTime.now();
  }

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
          cardImage = imageBytes;
          cardImageName = imageFileName;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _viewModel = GuideRegisterViewModel();
    convinceSelected = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: _body(),
      ),
    );
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            const Text(
              'ข้อมูลไกด์',
              style: TextStyle(
                color: textPurple,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizedBox(),
            
            sizedBox(),
            guideCardNo(cardNo: cardNo),
            sizedBox(),
            TextFieldSM(
              labelTFF: 'รูปภาพบัตรไกด์',
              hintTextinTFF: 'เพิ่มรูปภาพบัตรไกด์',
              pfIcon: IconButton(
                icon: const Icon(Icons.add_a_photo_outlined),
                color: grey500,
                onPressed: () async {
                  pickImage();
                },
              ),
              inputType: TextInputType.none,
              textController: TextEditingController(text: cardImageName),
              inputAction: TextInputAction.next,
            ),
            sizedBox(),
            // guideCardType(),
            // sizedBox(),
            expiredGuideCard(),
            sizedBox(),
            tourConvinces(),
            sizedBox(),
            guideLanguage(language),
            sizedBox(),
            TextFieldSM(
              labelTFF: 'ประสบการณ์ทำงาน',
              hintTextinTFF: 'กรอกประสบการณ์ทำงาน',
              textController: exp,
              // inputAction: TextInputAction.next,
              inputType: TextInputType.multiline,
              minLineAmount: 5,
              maxLineAmount: null,
            ),
            sizedBox(h: 20),
            PurpleWhitePairButton(
              whiteButtonText: "ข้าม",
              purpleButtonText: "ยืนยัน",
              whiteButtonFn: () {},
              purpleButtonFn: () async {
                bool isGuideRegis = await _viewModel.onUserRegisterGuide(
                  cardImage: cardImage!,
                  cardNo: cardNo.text,
                  cardType: '',
                  expiredDate: expiredDate,
                  convinces: convinceSelected,
                  languageList: language,
                  experience: exp.text,
                );

                if (isGuideRegis && mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const HomeView(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  CustomDropdownMultiSelect tourConvinces() {
    return CustomDropdownMultiSelect(
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
    );
  }

  TextFieldSM expiredGuideCard() {
    return TextFieldSM(
      labelTFF: 'วันหมดอายุบัตรไกด์',
      hintTextinTFF: 'เลือกวันหมดอายุ',
      textController: TextEditingController(
        text: DateFormat.yMd().format(expiredDate).toString(),
      ),
      inputAction: TextInputAction.next,
      pfIcon: IconButton(
        onPressed: () async {
          DateTime datePicked = await _selectDate(
            dateController: TextEditingController(
              text: DateFormat.yMd().format(expiredDate).toString(),
            ),
            datePicked: _viewModel.newGuideInfo.expiredDate,
          );
          setState(() {
            expiredDate = datePicked;
            _viewModel.newGuideInfo.expiredDate = datePicked;
          });
        },
        icon: const Icon(
          Icons.calendar_month_outlined,
          color: grey500,
        ),
      ),
    );
  }

  Column guideLanguage(TextfieldTagsController languages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ภาษาที่ใช้งาน',
          style: TextStyle(
            color: grey700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
        TextFieldTags(
          textfieldTagsController: languages,
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: (String tag) {
            if (languages.getTags!.contains(tag)) {
              return 'you already entered that';
            }
            return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return TextField(
                controller: tec,
                focusNode: fn,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: white,
                  filled: true,
                  border: yellowBorder,
                  enabledBorder: yellowBorder,
                  focusedBorder: yellowBorder,
                  helperText: languages.hasTags
                      ? "กรอกภาษาที่ใช้งาน(ได้มากกว่า 1 ภาษา)"
                      : '',
                  hintText: languages.hasTags
                      ? ''
                      : "กรอกภาษาที่ใช้งาน(ได้มากกว่า 1 ภาษา)",
                  errorText: error,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  prefixIcon: tags.isNotEmpty
                      ? SingleChildScrollView(
                          controller: sc,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: tags.map(
                              (String tag) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: yellow,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          '#$tag',
                                          style:
                                              const TextStyle(color: grey700),
                                        ),
                                        // onTap: () {
                                        //   print("$tag selected");
                                        // },
                                      ),
                                      const SizedBox(width: 4.0),
                                      InkWell(
                                        child: const Icon(
                                          Icons.cancel,
                                          size: 15.0,
                                          color: grey700,
                                        ),
                                        onTap: () {
                                          onTagDelete(tag);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        )
                      : null,
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              );
            });
          },
        ),
      ],
    );
  }

  Column guideConvinces() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'จังหวัดที่นำเที่ยว',
          style: TextStyle(
            color: grey700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
        DropDownMultiSelect(
          options: const [
            "กรุงเทพ",
            "สมุทรปราการ",
            "นนทบุรี",
            'สระบุรี',
            "เลย",
            "อ่างทอง",
          ],
          selectedValues: convinceSelected,
          onChanged: (List<String> x) {
            setState(() {
              convinceSelected = x;
            });
          },
          selected_values_style: const TextStyle(fontSize: 17),
          decoration: const InputDecoration(
              fillColor: white,
              filled: true,
              enabledBorder: yellowBorder,
              focusedBorder: yellowBorder,
              contentPadding: EdgeInsets.symmetric(vertical: 5)),
          hint: const Text(
            'เลือกจังหวัด',
            style: TextStyle(color: grey700, fontSize: 25),
          ),
        ),
      ],
    );
  }

  Column guideCardType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ประเภทการจดทะเบียน',
          style: TextStyle(
            color: grey700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          child: DropdownMenu<String>(
            width: screenWidth(context) - 40,
            hintText: 'เลือกประเภทการจดทะเบียน',
            onSelected: (String? value) {
              setState(() {
                cardType = value!;
                _viewModel.newGuideInfo.guideCardType = value;
              });
            },
            dropdownMenuEntries:
                typeList.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
            trailingIcon: const Icon(
              Icons.arrow_drop_down,
              color: grey500,
            ),
            textStyle: const TextStyle(fontSize: 17),
            inputDecorationTheme: const InputDecorationTheme(
              iconColor: black,
              filled: true,
              fillColor: white,
              enabledBorder: yellowBorder,
              focusedBorder: yellowBorder,
              focusColor: yellow,
              hoverColor: yellow,
            ),
            menuStyle: const MenuStyle(
              backgroundColor: MaterialStatePropertyAll(white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox sizedBox({double h = 10}) {
    return SizedBox(
      height: h,
    );
  }
}

class guideCardNo extends StatelessWidget {
  const guideCardNo({
    super.key,
    required this.cardNo,
  });

  final TextEditingController cardNo;

  @override
  Widget build(BuildContext context) {
    return TextFieldSM(
      labelTFF: 'เลขที่บัตรไกด์',
      hintTextinTFF: 'x-xxxxxx/xx-xxxxx',
      textController: cardNo,
      inputAction: TextInputAction.next,
    );
  }
}
