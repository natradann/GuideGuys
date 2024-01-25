import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/search_bar.dart';
import 'package:guideguys/components/search_filter.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/create_tour/create_tour_view.dart';
import 'package:guideguys/modules/my_tour_list/components/tour_card.dart';
import 'package:guideguys/modules/my_tour_list/my_tour_list_model.dart';
import 'package:guideguys/modules/my_tour_list/my_tour_list_view_model.dart';
import 'package:guideguys/modules/tour_detail/tour_detail_view.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class MyTourListView extends StatefulWidget {
  const MyTourListView({super.key});

  @override
  State<MyTourListView> createState() => _MyTourListViewState();
}

class _MyTourListViewState extends State<MyTourListView> {
  late MyTourListViewModel _viewModel;
  late TextEditingController tagsController;
  late List<String> typeTourList;
  late List<String> typeVehicleList;
 final _scaffoldKey = GlobalKey<ScaffoldState>();
 
  @override
  void initState() {
    super.initState();
    _viewModel = MyTourListViewModel();
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
        backgroundColor: bgColor,
        appBar: CustomAppBar(appBarKey: _scaffoldKey,),
        endDrawer: ProfileMenu(width: width),
        body: FutureBuilder(
            future: _viewModel.fetchAllTourList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    _searchAndFilter(width, height, isTrue),
                    Text(
                      'My Tours',
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: textPurple,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _viewModel.myTourList.length,
                        itemBuilder: (context, index) {
                          MyTourListModel tour = _viewModel.myTourList[index];
                          return TourCard(
                              model: tour,
                              screenHeight: height,
                              screenWidth: width,
                              onTapped: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TourDetialView(tourId: tour.tourId),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DottedBorder(
                        padding: EdgeInsets.zero,
                        dashPattern: const [4, 3],
                        strokeCap: StrokeCap.round,
                        color: grey500,
                        borderType: BorderType.Circle,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const CreateTourView(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(15)),
                              backgroundColor: MaterialStateProperty.all(white),
                              shape: MaterialStateProperty.all(
                                  const CircleBorder())),
                          child: const Icon(
                            Icons.add,
                            color: grey500,
                          ),
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
            }),
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
                  },
                ),
              ),
              SizedBox(
                width: width * 0.01,
              ),
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
