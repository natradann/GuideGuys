import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/purple_button.dart';
import 'package:guideguys/components/seperate_line.dart';
import 'package:guideguys/components/star_rate.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/chat/chat_provider.dart';
import 'package:guideguys/modules/chat/chat_view.dart';
import 'package:guideguys/modules/review/review_view.dart';
import 'package:guideguys/modules/tour_detail/tour_detail_view_model.dart';
import 'package:provider/provider.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class TourDetialView extends StatefulWidget {
  const TourDetialView({
    required this.tourId,
    super.key,
  });

  final String tourId;

  @override
  State<TourDetialView> createState() => _TourDetialViewState();
}

class _TourDetialViewState extends State<TourDetialView> {
  late TourDetailViewModel _viewModel;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = TourDetailViewModel();
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
        body: FutureBuilder(
          future: _viewModel.fetchTourDetail(tourId: widget.tourId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (_viewModel.tour.tourImage != null)
                      ? Image.memory(
                          base64Decode(
                              _viewModel.tour.tourImage!),
                          height: height * 0.3,
                          width: width,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/blank-profile-picture.png",
                          height: height * 0.3,
                          width: width,
                          fit: BoxFit.cover,
                        ),
                  // Image.asset(
                  //   _viewModel.tour.imgPath,
                  //   height: height * 0.3,
                  //   width: width,
                  //   fit: BoxFit.cover,
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _viewModel.tour.tourName,
                                    style: const TextStyle(
                                      color: textPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      leftTourDetail(screenWidth: width),
                                      rightTourDetail()
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const SeperateLine(),
                                  const SizedBox(height: 10),
                                  Text(
                                    _viewModel.tour.tourDetail,
                                    maxLines: null,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PurpleButton(
                      buttonText: 'contact guide',
                      onTapped: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ChatView(
                              guideId: _viewModel.tour.guideId,
                              receiverId: _viewModel.tour.guideUserId,
                              role: 'guide',
                            ),
                          ),
                        );
                      },
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

  Column rightTourDetail() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(_viewModel.tour.username),
            const SizedBox(width: 10),
            const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/blank-profile-picture.png'),
            )
          ],
        ),
        Text(
          '${_viewModel.tour.tourPrice} บาท',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Column leftTourDetail({required double screenWidth}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tourRate(widthForStar: screenWidth),
        Row(
          children: [
            const Icon(
              Icons.pin_drop_outlined,
              color: black,
            ),
            const SizedBox(width: 10),
            Wrap(
              spacing: 2,
              children: _viewModel.tour.convinces
                  .map((item) => Text(
                        item,
                      ))
                  .toList(),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.language,
              color: black,
            ),
            const SizedBox(width: 10),
            Wrap(
              spacing: 2,
              children: _viewModel.tour.languages
                  .map((item) => Text(
                        item,
                      ))
                  .toList(),
            ),
          ],
        ),
        Row(
          children: [
            const Text('การเดินทาง/ยานพาหนะ : '),
            Wrap(
              spacing: 2,
              children: _viewModel.tour.vehicle
                  .map((item) => Text(
                        item,
                      ))
                  .toList(),
            ),
          ],
        ),
        Row(
          children: [
            const Text('การท่องเที่ยว : '),
            Wrap(
              spacing: 2,
              children: _viewModel.tour.type
                  .map((item) => Text(
                        item,
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

  Row _tourRate({required double widthForStar}) {
    return Row(
      children: [
        StarRate(
          sizeStar: widthForStar * 0.05,
          pointRate: _viewModel.tour.tourPoint,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    ReviewView(tourId: widget.tourId),
              ),
            );
          },
          child: const Text(
            'ดูรีวิวทั้งหมด',
            style: TextStyle(
              color: black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
