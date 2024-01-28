import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/fixedsize_buffer.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/purple_white_pair_button.dart';
import 'package:guideguys/components/textfield_sm.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/text_styles.dart';
import 'package:guideguys/modules/create_confirm_guide/create_confirm_guide_model.dart';
import 'package:guideguys/modules/create_confirm_guide/create_confirm_guide_view_model.dart';
import 'package:intl/intl.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class CreateConfirmGuideView extends StatefulWidget {
  const CreateConfirmGuideView({
    required this.guideId,
    required this.userId,
    super.key,
  });

  final String guideId;
  final String userId;

  @override
  State<CreateConfirmGuideView> createState() => _CreateConfirmGuideViewState();
}

class _CreateConfirmGuideViewState extends State<CreateConfirmGuideView> {
  late CreateConfirmGuideViewModel _viewModel;
   final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = CreateConfirmGuideViewModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    TextEditingController tourName =
        TextEditingController(text: _viewModel.confirmForm.tourName);
    TextEditingController startDate = TextEditingController(
        text: DateFormat.yMd().format(_viewModel.confirmForm.startDate));
    TextEditingController endDate = TextEditingController(
        text: DateFormat.yMd().format(_viewModel.confirmForm.endDate));
    TextEditingController price =
        TextEditingController(text: _viewModel.confirmForm.price);
    TextEditingController headCount = TextEditingController(
        text: _viewModel.confirmForm.headCount.toString());
    TextEditingController tourPlan =
        TextEditingController(text: _viewModel.confirmForm.plan);
    TextEditingController aptDate = TextEditingController(
        text: DateFormat.yMd().format(_viewModel.confirmForm.aptDate));
    TextEditingController aptPlace =
        TextEditingController(text: _viewModel.confirmForm.aptPlace);

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
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        appBar: CustomAppBar(appBarKey: _scaffoldKey,),
        endDrawer: ProfileMenu(width: width),
        body: FutureBuilder(
            future: _viewModel.fetchGuideInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'แบบยืนยันการว่าจ้างไกด์',
                            style: titlePuple,
                          ),
                        ),
                        const FixedSizeBuffer(),
                        guideDetails(),
                        const FixedSizeBuffer(),
                        const Text(
                          'ข้อมูลทัวร์',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Autocomplete<TourModel>(
                          displayStringForOption: (TourModel option) =>
                              option.tourName,
                          optionsBuilder: (TextEditingValue text) =>
                              _viewModel.filterTour(text.text),
                          optionsViewBuilder: (context, onSelected, tours) {
                            return SizedBox(
                              width: 200,
                              child: Material(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxHeight: height * 0.4,
                                    maxWidth: width * 0.2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: height * 0.4,
                                        maxWidth: width * 0.2),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (coserntext, int index) {
                                        TourModel tour = tours.elementAt(index);
                                        return SizedBox(
                                          child: ListTile(
                                            title: Text(tour.tourName),
                                            // dense: true,
                                            onTap: () {
                                              onSelected(tour);
                                              _viewModel.confirmForm.tourName =
                                                  tour.tourName;
                                              _viewModel.confirmForm.tourId =
                                                  tour.tourId;
                                            },
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, int index) {
                                        return const Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: yellow,
                                          height: 0,
                                          thickness: 1.5,
                                        );
                                      },
                                      itemCount: tours.length,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            return TextFieldSM(
                              labelTFF: 'ชื่อทัวร์',
                              hintTextinTFF: 'เลือกชื่อทัวร์',
                              textController: textEditingController,
                              inputAction: TextInputAction.next,
                              focusNode: focusNode,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.4,
                              child: TextFieldSM(
                                labelTFF: 'วันที่เที่ยว',
                                hintTextinTFF: 'วันเริ่ม',
                                textController: startDate,
                                inputAction: TextInputAction.next,
                                pfIcon: IconButton(
                                  onPressed: () async {
                                    DateTime datePicked = await _selectDate(
                                      dateController: startDate,
                                      datePicked:
                                          _viewModel.confirmForm.startDate,
                                    );
                                    setState(() {
                                      startDate = TextEditingController(
                                          text: DateFormat.yMd()
                                              .format(datePicked));
                                      _viewModel.confirmForm.startDate =
                                          datePicked;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: grey500,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              '_',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: width * 0.4,
                              child: TextFieldSM(
                                labelTFF: '',
                                hintTextinTFF: 'วันจบ',
                                textController: endDate,
                                inputAction: TextInputAction.next,
                                pfIcon: IconButton(
                                  onPressed: () async {
                                    DateTime datePicked = await _selectDate(
                                      dateController: endDate,
                                      datePicked:
                                          _viewModel.confirmForm.endDate,
                                    );
                                    setState(() {
                                      endDate = TextEditingController(
                                        text:
                                            DateFormat.yMd().format(datePicked),
                                      );
                                      _viewModel.confirmForm.endDate =
                                          datePicked;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: grey500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFieldSM(
                          labelTFF: 'ราคา',
                          hintTextinTFF: 'จำนวนเงิน',
                          textController: price,
                          inputAction: TextInputAction.next,
                          pfIcon: const Icon(
                            Icons.attach_money_rounded,
                            color: grey500,
                          ),
                          onEditingEnd: () async {
                            _viewModel.confirmForm.price = price.text;
                            setState(() {
                              price = TextEditingController(
                                text: _viewModel.confirmForm.price,
                              );
                            });
                          },
                        ),
                        TextFieldSM(
                          labelTFF: 'จำนวนคน',
                          hintTextinTFF: 'จำนวนคน',
                          textController: headCount,
                          inputAction: TextInputAction.next,
                          onTextChenged: (value) {
                            setState(() {
                              headCount = TextEditingController(text: value);
                            });
                          },
                          onEditingEnd: () async {
                            _viewModel.confirmForm.headCount = headCount.text;
                            setState(() {
                              headCount = TextEditingController(
                                  text: _viewModel.confirmForm.headCount);
                            });
                          },
                        ),
                        TextFieldSM(
                          labelTFF: 'แผนการท่องเที่ยว (ถ้ามี)',
                          hintTextinTFF: 'รายละเอียดแผนการเที่ยว',
                          textController: tourPlan,
                          // inputAction: TextInputAction.next,
                          inputType: TextInputType.multiline,
                          minLineAmount: 5,
                          onEditingEnd: () async {
                            _viewModel.confirmForm.plan = tourPlan.text;
                            setState(() {
                              tourPlan = TextEditingController(
                                  text: _viewModel.confirmForm.plan);
                            });
                          },
                        ),
                        const FixedSizeBuffer(),
                        const Text(
                          'การนัดหมาย',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextFieldSM(
                          labelTFF: 'วันที่นัดหมาย',
                          hintTextinTFF: 'วัน/เดือน/ปี',
                          textController: aptDate,
                          inputAction: TextInputAction.next,
                          pfIcon: IconButton(
                            onPressed: () async {
                              DateTime datePicked = await _selectDate(
                                dateController: aptDate,
                                datePicked: _viewModel.confirmForm.aptDate,
                              );
                              setState(() {
                                aptDate = TextEditingController(
                                    text: DateFormat.yMd().format(datePicked));
                                _viewModel.confirmForm.aptDate = datePicked;
                              });
                            },
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              color: grey500,
                            ),
                          ),
                        ),
                        TextFieldSM(
                          labelTFF: 'สถานที่นัดหมาย',
                          hintTextinTFF: 'รายละเอียดสถานที่นัดหมาย',
                          textController: aptPlace,
                          inputAction: TextInputAction.done,
                          minLineAmount: 2,
                          onEditingEnd: () async {
                            _viewModel.confirmForm.aptPlace = aptPlace.text;
                            setState(() {
                              aptPlace = TextEditingController(
                                text: _viewModel.confirmForm.aptPlace,
                              );
                            });
                          },
                        ),
                        const FixedSizeBuffer(h: 20),
                        PurpleWhitePairButton(
                          whiteButtonText: 'ยกเลิก',
                          purpleButtonText: 'ยืนยัน',
                          whiteButtonFn: () {
                            Navigator.pop(context);
                          },
                          purpleButtonFn: () async {
                            _viewModel.confirmForm.customerId = widget.userId;
                            _viewModel.confirmForm.guideId = widget.guideId;
                            bool isCreated =
                                await _viewModel.createConfirmForm();
                            if (isCreated && mounted) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(
                        color: grey500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading...'),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  Column guideDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ข้อมูลไกด์',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        RichText(
          text: TextSpan(
            style: GoogleFonts.notoSansThai(color: black),
            children: [
              const TextSpan(
                text: "ไกด์: ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextSpan(text: _viewModel.guideInfo.guideName),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: GoogleFonts.notoSansThai(color: black),
            children: [
              const TextSpan(
                text: "เลขบัตรไกด์: ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextSpan(text: _viewModel.guideInfo.cardNo),
            ],
          ),
        ),
        Row(
          children: [
            const Text(
              "ภาษา: ",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 2,
              children: (_viewModel.guideInfo.languages)
                  .map((lang) => Text(lang))
                  .toList(),
            )
          ],
        ),
      ],
    );
  }
}
