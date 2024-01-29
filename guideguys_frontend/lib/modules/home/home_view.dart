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
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

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

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  late HomeViewModel _viewModel;
  late TextEditingController tagsController;
  late List<String> typeTourList;
  late List<String> typeVehicleList;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.homeData = _viewModel.fetchAllInfo();
    tagsController = TextEditingController();
    typeTourList = [];
    typeVehicleList = [];
  }

  @override
  void dispose() {
    super.dispose();
    tagsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double width = screenWidth(context);
    double height = screenHeight(context);
    bool isTrue = false;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        appBar: CustomAppBar(
          appBarKey: _scaffoldKey,
        ),
        endDrawer: ProfileMenu(width: width),
        body: FutureBuilder(
          future: _viewModel.homeData,
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
                      menu: "ไกด์นำเที่ยว",
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FindAllListView(
                              pageTitle: 'ไกด์นำเที่ยว',
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
                      menu: "โปรแกรมนำเที่ยว",
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FindAllListView(
                              pageTitle: 'โปรแกรมนำเที่ยว',
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
                            base64Image: tour.tourImgPath,
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
                  },
                ),
              ),
              // filter button
              IconButton(
                onPressed: () {
                  // print('typeList-1: $typeList');
                  // print('tourTypeList-1: $typeTourList');
                  filterOption(context);
                  setState(() {});
                },
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.filter_alt,
                  color: Colors.grey[600],
                ),
                iconSize: screenWidht * 0.08,
              ),

              // SearchFilter(
              //   checkValue: isTrue,
              //   screenWidht: screenWidht,
              //   typeTourList: _viewModel.typeTourList,
              //   typeVehicleList: _viewModel.typeVehicleList,
              //   onUpdate: () {
              //     _viewModel.onUpdateFilter(
              //       typeTour: _viewModel.typeTourList,
              //       typeVehicle: _viewModel.typeVehicleList,
              //     );
              //   },
              // ),
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

  Future<void> filterOption(
    BuildContext context,
    // bool isTrue,
    // List<String> typeList,
    // List<String> vehicleList,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        late bool adventure = false;
        late bool shopping = false;
        late bool nature = false;
        late bool culture = false;
        late bool rural = false;
        late bool darkTour = false;
        late bool pubTrans = false;
        late bool priCar = false;
        late bool train = false;
        late bool boat = false;
        late bool walk = false;
        for (String type in typeTourList) {
          if (type == 'ผจญภัย') {
            adventure = true;
          } else if (type == 'ชอปปิง') {
            shopping = true;
          } else if (type == 'ธรรมชาติ') {
            nature = true;
          } else if (type == 'วัฒนธรรม ประวัติศาสตร์') {
            culture = true;
          } else if (type == 'ชนบท') {
            rural = true;
          } else if (type == 'Dark Tourism') {
            darkTour = true;
          }
        }
        for (String vehicle in typeVehicleList) {
          if (vehicle == 'รถสาธารณะ') {
            pubTrans = true;
          } else if (vehicle == 'รถยนต์ส่วนตัว') {
            priCar = true;
          } else if (vehicle == 'รถไฟ') {
            train = true;
          } else if (vehicle == 'เรือ') {
            boat = true;
          } else if (vehicle == 'เดิน') {
            walk = true;
          }
        }
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: bgColor,
          contentPadding: const EdgeInsets.all(15),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ประเภททัวร์',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                typeTourMultiSelect(
                  adventure,
                  shopping,
                  nature,
                  culture,
                  rural,
                  darkTour,
                ),
                const SizedBox(height: 20),
                const Text(
                  'ยานพาหนะ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                vehicleMultiSelect(
                  priCar,
                  pubTrans,
                  train,
                  boat,
                  walk,
                ),
              ],
            );
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                typeTourList = _viewModel.typeTourList;
                typeVehicleList = _viewModel.typeVehicleList;

                setState(() {});

                Navigator.pop(context, 'Cancel');
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: textPurple),
              ),
            ),
            TextButton(
              onPressed: () {
                _viewModel.typeTourList = typeTourList;
                _viewModel.typeVehicleList = typeVehicleList;
                setState(() {});
                Navigator.pop(context, 'OK');
              },
              child: const Text(
                'OK',
                style: TextStyle(color: textPurple),
              ),
            ),
          ],
        );
      },
    );
  }

  MultiSelectContainer<String> vehicleMultiSelect(
    bool priCar,
    bool pubTrans,
    bool train,
    bool boat,
    bool walk,
  ) {
    return MultiSelectContainer(
      itemsDecoration: MultiSelectDecorations(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
          border: Border.all(color: yellow),
        ),
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: yellow,
          border: Border.all(color: yellow),
        ),
      ),
      items: [
        MultiSelectCard(
            value: 'รถยนต์ส่วนตัว', label: 'รถยนต์ส่วนตัว', selected: priCar),
        MultiSelectCard(
            value: 'รถสาธารณะ', label: 'รถสาธารณะ', selected: pubTrans),
        MultiSelectCard(
          value: 'รถไฟ',
          label: 'รถไฟ',
          selected: train,
        ),
        MultiSelectCard(
          value: 'เรือ',
          label: 'เรือ',
          selected: boat,
        ),
        MultiSelectCard(
          value: 'เดิน',
          label: 'เดิน',
          selected: walk,
        ),
      ],
      onChange: (allSelectedItems, selectedItem) {
        typeVehicleList = allSelectedItems;
      },
    );
  }

  MultiSelectContainer<String> typeTourMultiSelect(
    bool adventure,
    bool shopping,
    bool nature,
    bool culture,
    bool rural,
    bool darkTour,
  ) {
    return MultiSelectContainer(
      itemsDecoration: MultiSelectDecorations(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
          border: Border.all(color: yellow),
        ),
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: yellow,
          border: Border.all(color: yellow),
        ),
      ),
      items: [
        MultiSelectCard(
          value: 'ผจญภัย',
          label: 'ผจญภัย',
          selected: adventure,
        ),
        MultiSelectCard(
          value: 'ชอปปิง',
          label: 'ชอปปิง',
          selected: shopping,
        ),
        MultiSelectCard(
          value: 'ธรรมชาติ',
          label: 'ธรรมชาติ',
          selected: nature,
        ),
        MultiSelectCard(
          value: 'วัฒนธรรม ประวัติศาสตร์',
          label: 'วัฒนธรรม ประวัติศาสตร์',
          selected: culture,
        ),
        MultiSelectCard(
          value: 'ชนบท',
          label: 'ชนบท',
          selected: rural,
        ),
        MultiSelectCard(
            value: 'Dark Tourism', label: 'Dark Tourism', selected: darkTour),
      ],
      onChange: (allSelectedItems, selectedItem) {
        setState(() {
          typeTourList = allSelectedItems;
        });
      },
    );
  }
}
