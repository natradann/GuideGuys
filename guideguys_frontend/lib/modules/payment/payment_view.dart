import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/fixedsize_buffer.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/purple_white_pair_button.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/text_styles.dart';
import 'package:guideguys/modules/payment/payment_view_model.dart';
import 'package:guideguys/modules/travel_history/travel_history_view.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class PaymentView extends StatefulWidget {
  const PaymentView({
    required this.historyId,
    // required this.receiverId,
    // required this.receiverUsername,
    super.key,
  });

  final String historyId;
  // final String receiverId;
  // final String receiverUsername;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PaymentViewModel _viewModel;
  Uint8List? image;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    late Uint8List imageBytes;

    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );

      if (pickedFile != null) {
        imageBytes = await pickedFile.readAsBytes();
        setState(() {
          image = imageBytes;
        });
      }
    } catch (e) {
      throw ("Error picking image: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _viewModel = PaymentViewModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: bgColor,
        appBar: CustomAppBar(
          appBarKey: _scaffoldKey,
        ),
        endDrawer: ProfileMenu(width: width),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      progressColor: const Color.fromRGBO(103, 80, 164, 1),
                      barRadius: const Radius.circular(10),
                      percent: 1,
                    ),
                    const FixedSizeBuffer(),
                    const Text(
                      'การชำระเงิน',
                      style: titlePuple,
                    ),
                    const FixedSizeBuffer(),
                    const Text(
                      'สแกน QR code ด้านล่างเพื่อชำระเงิน',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const FixedSizeBuffer(h: 20),
                    Image.asset(
                      'assets/images/blank-profile-picture.png',
                      width: width * 0.6,
                    ),
                    const FixedSizeBuffer(h: 20),
                    const Text(
                      'หลักฐานการชำระเงิน',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const FixedSizeBuffer(),
                    (image != null)
                        ? Image.memory(
                            image!,
                            // width: w,
                            // height: 200,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(),
                    const FixedSizeBuffer(h: 30),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DottedBorder(
                          padding: EdgeInsets.zero,
                          dashPattern: const [4, 3],
                          strokeCap: StrokeCap.round,
                          color: grey500,
                          borderType: BorderType.Circle,
                          child: ElevatedButton(
                            onPressed: () async {
                              pickImage();
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(15)),
                                backgroundColor:
                                    MaterialStateProperty.all(white),
                                shape: MaterialStateProperty.all(
                                    const CircleBorder())),
                            child: const Icon(
                              Icons.add,
                              color: grey500,
                            ),
                          ),
                        ),
                        const FixedSizeBuffer(),
                        const Text(
                          'เพิ่มรูปภาพ',
                          style: TextStyle(color: grey500),
                        ),
                        const FixedSizeBuffer(h: 20),
                      ],
                    ),
                  ],
                ),
              ),
              PurpleWhitePairButton(
                whiteButtonText: 'ยกเลิก',
                purpleButtonText: 'ยืนยัน',
                whiteButtonFn: () {
                  Navigator.pop(context);
                },
                purpleButtonFn: () async {
                  bool isPaymentSaved = await _viewModel.savePaymentInfo(
                    historyId: widget.historyId,
                    slipImage: image!,
                  );

                  if (isPaymentSaved && mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TravelHistoryView()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
