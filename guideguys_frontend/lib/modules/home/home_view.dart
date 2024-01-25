import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/search_bar.dart';
import 'package:guideguys/components/search_filter.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/find_all_list/find_all_list_view.dart';
import 'package:guideguys/modules/home/components/findallbar.dart';
import 'package:guideguys/modules/home/components/guide_card_sm.dart';
import 'package:guideguys/components/card_lg.dart';
import 'package:guideguys/modules/home/home_model.dart';
import 'package:guideguys/modules/home/home_view_model.dart';
import 'package:guideguys/modules/tour_detail/tour_detail_view.dart';
import '../../models/tour_card_lg_model.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel _viewModel;
  late TextEditingController tagsController;
  late List<String> typeTourList;
  late List<String> typeVehicleList;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    tagsController = TextEditingController();
    typeTourList = [];
    typeVehicleList = [];
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    bool isTrue = false;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        appBar: CustomAppBar(appBarKey: _scaffoldKey,),
        endDrawer: ProfileMenu(width: width),
        body: FutureBuilder(
          future: _viewModel.fetchAllInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            try {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _topOperation(
                        screenHeight: height,
                        screenWidht: width,
                        isTrue: isTrue),
                    FindAllBar(
                      h: height,
                      menu: "Guide",
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FindAllListView(
                              pageTitle: 'Guides',
                              guideList: _viewModel.allGuides,
                            ),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _viewModel.filterGuides().length,
                        itemBuilder: (context, index) {
                          GuideModel guide = _viewModel.filterGuides()[index];
                          return GuideCardSM(
                            model: guide,
                            screenHeight: height,
                            screenWidth: width,
                          );
                        },
                      ),
                    ),
                    FindAllBar(
                      h: height,
                      menu: "Tour",
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FindAllListView(
                              pageTitle: 'Tours',
                              tourList: _viewModel.allTours,
                            ),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _viewModel.filterTours().length,
                        itemBuilder: (context, index) {
                          TourCardLGModel tour =
                              _viewModel.filterTours()[index];
                          return CardLG(
                            id: tour.tourId,
                            title: tour.tourName,
                            imgPath: tour.tourImgPath,
                            tagList: tour.convinces +
                                tour.languages +
                                tour.type +
                                tour.vehicles,
                            price: tour.price,
                            ratePoint: tour.ratePoint,
                            screenHeight: height,
                            screenWidth: width,
                            onTapped: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TourDetialView(tourId: tour.tourId),
                                ),
                              );
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
            } catch (e) {
              rethrow;
            }
          },
        ),
      ),
    );
  }

  Padding _topOperation({
    required double screenHeight,
    required double screenWidht,
    required bool isTrue,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // search bar
              Expanded(
                child: SearchBar(
                  tagController: tagsController,
                  onUpdate: () async {
                    bool isAdded =
                        await _viewModel.addTag(newTag: tagsController.text);
                    if (isAdded) {
                      tagsController.clear();
                      setState(() {});
                    }
                    print(_viewModel.tagList);
                  },
                ),
              ),
              // filter button
              SearchFilter(
                checkValue: isTrue,
                screenWidht: screenWidht,
                typeTourList: _viewModel.typeTourList,
                typeVehicleList: _viewModel.typeVehicleList,
                onUpdate: () {
                  _viewModel.onUpdateFilter(typeTour: _viewModel.typeTourList, typeVehicle: _viewModel.typeVehicleList);
                },
              ),
            ],
          ),
          const SizedBox(height: 5),
          (_viewModel.tagList.isNotEmpty)
              ? SizedBox(
                  height: screenHeight * 0.035,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _viewModel.tagList.length,
                    itemBuilder: (context, index) {
                      String tag = _viewModel.tagList[index];
                      return Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: yellow,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#$tag',
                              style: const TextStyle(color: black),
                            ),
                            const SizedBox(width: 4.0),
                            InkWell(
                              child: const Icon(
                                Icons.cancel,
                                size: 18.0,
                                color: grey700,
                              ),
                              onTap: () async {
                                bool isDeleted = await _viewModel
                                    .onUserDeleteTag(tagName: tag);
                                if (isDeleted) {
                                  setState(() {});
                                }
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
