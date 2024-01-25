import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guideguys/components/purple_white_pair_button.dart';
import 'package:guideguys/components/textfield_sm.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/textfield_decoration.dart';
import 'package:guideguys/modules/guide_register/guide_register_view_model.dart';
import 'package:guideguys/modules/home/home_view.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:multiselect/multiselect.dart';

class GuideRegisterView extends StatefulWidget {
  const GuideRegisterView({super.key});

  @override
  State<GuideRegisterView> createState() => _GuideRegisterViewState();
}

class _GuideRegisterViewState extends State<GuideRegisterView> {
  List<String> typeList = const ["มัคคุเทศก์ทั่วไป", "มัคคุเทศก์เฉพาะ"];
  late GuideRegisterViewModel _viewModel;
  TextEditingController cardNo = TextEditingController();
  String cardType = '';
  DateTime expiredDate = DateTime.now();
  TextEditingController convince = TextEditingController();
  TextfieldTagsController language = TextfieldTagsController();
  TextEditingController exp = TextEditingController();
  List<String> convinceSelected = [];

  @override
  void initState() {
    super.initState();
    _viewModel = GuideRegisterViewModel();
  }

  @override
  Widget build(BuildContext context) {
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
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
                TextFieldSM(
                  labelTFF: 'เลขที่บัตรไกด์',
                  hintTextinTFF: 'x-xxxxxx/xx-xxxxx',
                  textController: cardNo,
                  inputAction: TextInputAction.next,
                  onEditingEnd: () async {
                    // _viewModel.newGuideInfo.guideCardNumber = cardNo.text;
                    // setState(() {
                    //   cardNo = TextEditingController(
                    //     text: _viewModel.newGuideInfo.guideCardNumber,
                    //   );
                    // });
                  },
                ),
                sizedBox(),
                guideCardType(),
                sizedBox(),
                TextFieldSM(
                  labelTFF: 'วันหมดอายุบัตรไกด์',
                  hintTextinTFF: 'เลือกวันหมดอายุ',
                  textController: TextEditingController(
                      text: DateFormat.yMd().format(expiredDate).toString()),
                  inputAction: TextInputAction.next,
                  // inputType: TextInputType.datetime,
                  pfIcon: IconButton(
                    onPressed: () async {
                      DateTime datePicked = await _selectDate(
                        dateController: TextEditingController(
                            text: DateFormat.yMd()
                                .format(expiredDate)
                                .toString()),
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
                ),
                sizedBox(),
                guideConvinces(),
                sizedBox(),
                guideLanguage(language),
                sizedBox(),
                TextFieldSM(
                  labelTFF: 'ประสบการณ์ทำงาน',
                  hintTextinTFF: 'กรอกประสบการณ์ทำงาน',
                  textController: exp,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.multiline,
                  minLineAmount: 5,
                  maxLineAmount: null,
                  onEditingEnd: () async {},
                ),
                sizedBox(h: 20),
                PurpleWhitePairButton(
                  whiteButtonText: "ยกเลิก",
                  purpleButtonText: "ยืนยัน",
                  whiteButtonFn: () {},
                  purpleButtonFn: () async {
                    bool isGuideRegis = await _viewModel.onUserRegisterGuide(
                      cardNo: cardNo.text,
                      cardType: cardType,
                      expiredDate: expiredDate,
                      convinces: convinceSelected,
                      languageList: language,
                      experience: exp.text,
                    );
                    print(isGuideRegis);
                    if (isGuideRegis) {
                      print(_viewModel.newGuideInfo.guideCardNumber);
                      print(_viewModel.newGuideInfo.guideCardType);
                      print(_viewModel.newGuideInfo.expiredDate);
                      print(_viewModel.newGuideInfo.convinces);
                      print(_viewModel.newGuideInfo.languages);
                    }

                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => const HomeView(),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
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
              return Padding(
                padding: EdgeInsets.zero,
                child: TextField(
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
                    prefixIcon: tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: sc,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: tags.map((String tag) {
                              return Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: yellow,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        '#$tag',
                                        style: const TextStyle(color: grey700),
                                      ),
                                      onTap: () {
                                        print("$tag selected");
                                      },
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
                            }).toList()),
                          )
                        : null,
                  ),
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                ),
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
            // initialSelection: typeList.first,
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
