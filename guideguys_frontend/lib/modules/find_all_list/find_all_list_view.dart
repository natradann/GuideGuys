import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/search_bar.dart';
import 'package:guideguys/components/search_filter.dart';
import 'package:guideguys/components/card_lg.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/models/tour_card_lg_model.dart';
import 'package:guideguys/modules/find_all_list/find_all_list_view_model.dart';
import 'package:guideguys/modules/guide_profile/guide_profile_view.dart';
import 'package:guideguys/modules/home/home_model.dart';
import 'package:guideguys/modules/tour_detail/tour_detail_view.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class FindAllListView extends StatefulWidget {
  const FindAllListView({
    required this.pageTitle,
    this.tourList,
    this.guideList,
    super.key,
  });

  final String pageTitle;
  final List<TourCardLGModel>? tourList;
  final List<GuideModel>? guideList;

  @override
  State<FindAllListView> createState() => _FindGuieViewState();
}

class _FindGuieViewState extends State<FindAllListView> {
  late FindAllListViewModel _viewModel;
  late TextEditingController tagsController;
  late List<String> typeTourList;
  late List<String> typeVehicleList;
   final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = FindAllListViewModel();
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
        appBar: CustomAppBar(appBarKey: _scaffoldKey,),
        backgroundColor: bgColor,
        endDrawer: ProfileMenu(width: width),
        body: Column(
          children: [
            _searchAndFilter(width, height, isTrue),
            Text(
              widget.pageTitle,
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
                color: textPurple,
              ),
            ),
            Expanded(
              child: (widget.pageTitle == 'Tours')
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _viewModel
                          .filterTours(allTours: widget.tourList!)
                          .length,
                      itemBuilder: (context, index) {
                        TourCardLGModel tour = widget.tourList![index];
                        return CardLG(
                          // model: tour,
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
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _viewModel
                          .filterGuides(allGuides: widget.guideList!)
                          .length,
                      itemBuilder: (context, index) {
                        GuideModel guide = widget.guideList![index];
                        return CardLG(
                          // model: guide,
                          id: guide.guideId,
                          title: guide.guideName,
                          imgPath: guide.guideImgPath,
                          tagList: guide.convinces + guide.languages,
                          ratePoint: guide.ratePoint,
                          screenHeight: height,
                          screenWidth: width,
                          onTapped: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GuideProfileView(guideId: guide.guideId),
                              ),
                            );
                          },
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Padding _searchAndFilter(double width, double height, bool isTrue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                screenWidht: width,
                typeTourList: typeTourList,
                typeVehicleList: typeVehicleList,
                
              ),
            ],
          ),
          const SizedBox(height: 5),
          (_viewModel.tagList.isNotEmpty)
              ? SizedBox(
                  height: height * 0.035,
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
                        margin: EdgeInsets.symmetric(horizontal: 3),
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
                                  print(_viewModel.tagList);
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
