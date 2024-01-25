import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/fixedsize_buffer.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/purple_white_pair_button.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/text_styles.dart';
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
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    XFile? image;
     final _scaffoldKey = GlobalKey<ScaffoldState>();

    Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile;

      try {
        pickedFile = await picker.pickImage(source: ImageSource.gallery);
      } catch (e) {
        print("Error picking image: $e");
      }

      if (pickedFile != null) {
        print('not null');
        setState(() {
          image = pickedFile;
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: bgColor,
        appBar: CustomAppBar(appBarKey: _scaffoldKey,),
        endDrawer: ProfileMenu(width: width),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              (image != null)
                  ? Image.file(
                      File(image!.path),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(),
              const FixedSizeBuffer(),
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
                      onPressed: pickImage,
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(15)),
                          backgroundColor: MaterialStateProperty.all(white),
                          shape:
                              MaterialStateProperty.all(const CircleBorder())),
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
                  )
                ],
              ),
              PurpleWhitePairButton(
                whiteButtonText: 'ยกเลิก',
                purpleButtonText: 'ยืนยัน',
                whiteButtonFn: () {
                  Navigator.pop(context);
                },
                purpleButtonFn: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
