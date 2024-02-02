import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/purple_button.dart';
import 'package:guideguys/components/seperate_line.dart';
import 'package:guideguys/components/star_rate.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/chat/chat_view.dart';
import 'package:guideguys/modules/guide_profile/components/tour_card_sm.dart';
import 'package:guideguys/modules/guide_profile/guide_profile_model.dart';
import 'package:guideguys/modules/guide_profile/guide_profile_view_model.dart';
import 'package:intl/intl.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class GuideProfileView extends StatefulWidget {
  const GuideProfileView({
    required this.guideId,
    super.key,
  });

  final String guideId;

  @override
  State<GuideProfileView> createState() => _GuideProfileViewState();
}

class _GuideProfileViewState extends State<GuideProfileView> {
  late GuideProfileViewModel _viewModel;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = GuideProfileViewModel();
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
          future: _viewModel.fetchGuideProfile(id: widget.guideId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (_viewModel.guideProfile.guideImage != null)
                                  ? Image.memory(
                                      base64Decode(
                                          _viewModel.guideProfile.guideImage!),
                                      height: height * 0.3,
                                      width: width * 0.5,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/blank-profile-picture.png",
                                      height: height * 0.3,
                                      width: width * 0.5,
                                      fit: BoxFit.cover,
                                    ),
                              rightInfomation()
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'ประสบการนำเที่ยว: \n${_viewModel.guideProfile.experience}',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const SeperateLine(),
                                const SizedBox(height: 10),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: width * 0.5,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 1,
                                    mainAxisExtent: height * 0.25,
                                  ),
                                  itemCount:
                                      _viewModel.guideProfile.alltours.length,
                                  itemBuilder: (_, index) {
                                    TourModel tour =
                                        _viewModel.guideProfile.alltours[index];
                                    return TourCardSM(
                                      screenHeight: height,
                                      screenWidth: width,
                                      model: tour,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: PurpleButton(
                      buttonText: 'contact guide',
                      onTapped: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatView(
                              receiverId: _viewModel.guideProfile.guideUserId,
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

  Expanded rightInfomation() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _viewModel.guideProfile.guideName,
              style: const TextStyle(
                color: textPurple,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            StarRate(
                sizeStar: 20, pointRate: _viewModel.guideProfile.guidePoint),
            Row(
              children: [
                const Icon(Icons.person, color: grey700),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'ชื่อ-สกุล: ${_viewModel.guideProfile.firstName} ${_viewModel.guideProfile.lastName}',
                    softWrap: true,
                    // style: TextStyle(fontSize: width * 0.05),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.badge_outlined,
                  color: grey700,
                ),
                const SizedBox(width: 5),
                Text('เลขบัตรไกด์: ${_viewModel.guideProfile.guideCardNo}'),
              ],
            ),
            // Text(_viewModel.guideProfile.guideCardType),
            Text(
                'วันหมดอายุ: ${DateFormat.yMd().format(_viewModel.guideProfile.cardExpired)}'),
            const SizedBox(width: 5),
            Wrap(spacing: 2, children: [
              const Icon(
                Icons.pin_drop_outlined,
                color: grey700,
              ),
              ..._viewModel.guideProfile.convinces
                  .map((item) => Text(
                        item,
                      ))
                  .toList(),
            ]),
            const SizedBox(width: 5),
            Wrap(spacing: 2, children: [
              const Icon(
                Icons.language,
                color: grey700,
              ),
              ..._viewModel.guideProfile.languages
                  .map((item) => Text(
                        item,
                      ))
                  .toList(),
            ]),
          ],
        ),
      ),
    );
  }
}
