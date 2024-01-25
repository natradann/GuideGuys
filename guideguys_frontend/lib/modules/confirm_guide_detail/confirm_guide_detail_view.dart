import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/purple_white_pair_button.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/text_styles.dart';
import 'package:guideguys/modules/confirm_guide_detail/confirm_guide_detail_view_model.dart';
import 'package:guideguys/modules/payment/payment_view.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class ConfirmGuideDetailView extends StatefulWidget {
  const ConfirmGuideDetailView({
    required this.historyId,
    super.key,
  });

  final String historyId;

  @override
  State<ConfirmGuideDetailView> createState() => _ConfirmGuideDetailViewState();
}

class _ConfirmGuideDetailViewState extends State<ConfirmGuideDetailView> {
  late ConfirmGuideDetailViewModel _viewModel;
   final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = ConfirmGuideDetailViewModel();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: bgColor,
        appBar: CustomAppBar(appBarKey: _scaffoldKey,),
        endDrawer: ProfileMenu(width: width),
        body: FutureBuilder(
          future:
              _viewModel.fetchConfirmGuideDatail(historyId: widget.historyId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          upperComfirmDetail(width),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                      child: LinearPercentIndicator(
                                        progressColor: const Color.fromRGBO(
                                            103, 80, 164, 1),
                                        barRadius: const Radius.circular(10),
                                        percent: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: width,
                                      height: 30,
                                      child: const Text(
                                        'แบบยืนยันการว่าจ้างไกด์',
                                        style: titlePuple,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    guideDetail(),
                                    const SizedBox(height: 15),
                                    tourDetail(),
                                    const SizedBox(height: 15),
                                    appointmentDetail(),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: PurpleWhitePairButton(
                                    whiteButtonText: "กลับ",
                                    purpleButtonText: "ต่อไป",
                                    whiteButtonFn: () {
                                      Navigator.pop(context);
                                    },
                                    purpleButtonFn: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PaymentView(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
          },
        ),
      ),
    );
  }

  Column appointmentDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'การนัดหมาย',
          style: detailTitle,
        ),
        Row(
          children: const [
            Text(
              "วันที่นัดหมาย: ",
              style: detailTitle,
            ),
            Text(style: detailText, "6 ตุลาคม 2566"),
          ],
        ),
        Row(
          children: const [
            Text(
              "สถานที่นัดหมาย: ",
              style: detailTitle,
            ),
            Text(style: detailText, "Central Ladprao"),
          ],
        ),
        Row(
          children: const [
            Text(
              "หมายเหตุ*: ",
              style: detailTitle,
            ),
            Text(style: detailText, "Central Ladprao"),
          ],
        ),
      ],
    );
  }

  Column tourDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'ข้อมูลทัวร์',
          style: detailTitle,
        ),
        Row(
          children: [
            const Text(
              "ชื่อทัวร์: ",
              style: detailTitle,
            ),
            Text(style: detailText, _viewModel.formDetail.tourName),
          ],
        ),
        Row(
          children: [
            const Text(
              "วันที่เที่ยว: ",
              style: detailTitle,
            ),
            Text(
                style: detailText,
                "${DateFormat.yMd().format(_viewModel.formDetail.startDate)} - ${DateFormat.yMd().format(_viewModel.formDetail.endDate)}"),
          ],
        ),
        Row(
          children: [
            const Text(
              "ราคา: ",
              style: detailTitle,
            ),
            Text(style: detailText, "${_viewModel.formDetail.price} บาท"),
          ],
        ),
        Row(
          children: [
            const Text(
              "จำนวนคน: ",
              style: detailTitle,
            ),
            Text(style: detailText, "${_viewModel.formDetail.headcount} คน"),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "แผนการท่องเที่ยว (ถ้ามี): ",
              style: detailTitle,
            ),
            Text(
              style: detailText,
              _viewModel.formDetail.plan,
              softWrap: true,
            ),
          ],
        ),
      ],
    );
  }

  Column guideDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'ข้อมูลไกด์',
          style: detailTitle,
        ),
        Row(
          children: [
            const Text(
              "ไกด์: ",
              style: detailTitle,
            ),
            Text(style: detailText, _viewModel.formDetail.guideName),
          ],
        ),
        Row(
          children: [
            const Text(
              "เลขบัตรไกด์: ",
              style: detailTitle,
            ),
            Text(style: detailText, _viewModel.formDetail.guideCardNo),
          ],
        ),
        Row(
          children: [
            const Text(
              "ภาษา: ",
              style: detailTitle,
            ),
            Wrap(
              spacing: 5,
              clipBehavior: Clip.hardEdge,
              children: (_viewModel.formDetail.languages)
                  .map(
                    (item) => Text(
                      item,
                      style: detailText,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

  Container upperComfirmDetail(double width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _viewModel.formDetail.tourName,
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.035,
                ),
              ),
              Text(
                'รอการรีวิว',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.03,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _viewModel.formDetail.guideUsername,
                style: TextStyle(
                  color: black,
                  fontSize: width * 0.025,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateFormat.yMEd().format(_viewModel.formDetail.startDate)} - ${DateFormat.yMEd().format(_viewModel.formDetail.endDate)}',
                style: TextStyle(
                  color: black,
                  fontSize: width * 0.025,
                ),
              ),
              Text(
                '${_viewModel.formDetail.price} บาท',
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.03,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
