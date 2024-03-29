import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/confirm_guide_detail/confirm_guide_detail_view.dart';
import 'package:guideguys/modules/review_tour/review_tour_view.dart';
import 'package:guideguys/components/tour_history_card.dart';
import 'package:guideguys/modules/travel_history/travel_history_model.dart';
import 'package:guideguys/modules/travel_history/travel_history_view_model.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class TravelHistoryView extends StatefulWidget {
  const TravelHistoryView({super.key});

  @override
  State<TravelHistoryView> createState() => _TravelHistoryViewState();
}

class _TravelHistoryViewState extends State<TravelHistoryView> {
  late TravelHistoryViewModel _viewModel;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = TravelHistoryViewModel();
    _viewModel.fetchTravelHistory();
    _viewModel.fetchSecureData();
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
            future: _viewModel.allTourHistoryData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileInfo(width),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Text(
                        'ประวัติ',
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: _viewModel.allTourHistory.histories.length,
                        itemBuilder: (context, index) {
                          History history =
                              _viewModel.allTourHistory.histories[index];
                          return TourHistoryCard(
                            tourName: history.tourName,
                            guideName: history.guideUsername,
                            status: history.status,
                            startDate: history.startDate,
                            endDate: history.endDate,
                            price: history.price,
                            screenWidth: width,
                            onPressed: () {
                              if (history.status == '0') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConfirmGuideDetailView(
                                      historyId: history.historyId,
                                      status: history.status,
                                    ),
                                  ),
                                );
                              } else if (history.status == '2') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewTourView(
                                      historyId: history.historyId,
                                      tourId: history.tourId,
                                      tourName: history.tourName,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConfirmGuideDetailView(
                                      historyId: history.historyId,
                                      status: history.status,
                                    ),
                                  ),
                                );
                              } 
                            },
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
            }),
      ),
    );
  }

  Container profileInfo(double width) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 30, 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: width * 0.07,
            backgroundImage: (_viewModel.allTourHistory.customerImg != null)
                ? Image.memory(
                        base64Decode(_viewModel.allTourHistory.customerImg!))
                    .image
                : const AssetImage('assets/images/blank-profile-picture.png'),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _viewModel.myUsername,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: grey700,
                  fontSize: width * 0.05,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _viewModel.myEmail,
                style: TextStyle(
                  color: grey500,
                  fontSize: width * 0.04,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
