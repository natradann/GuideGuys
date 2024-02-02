import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/purple_white_pair_button.dart';
import 'package:guideguys/components/textfield_sm.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/review_tour/review_tour_view_model.dart';
import 'package:guideguys/modules/travel_history/travel_history_view.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class ReviewTourView extends StatefulWidget {
  const ReviewTourView({
    required this.historyId,
    required this.tourId,
    required this.tourName,
    super.key,
  });

  final String historyId;
  final String tourId;
  final String tourName;

  @override
  State<ReviewTourView> createState() => _ReviewTourViewState();
}

class _ReviewTourViewState extends State<ReviewTourView> {
  late ReviewTourViewModel _viewModel;
  late int starPoint;
  late TextEditingController commentTour;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = ReviewTourViewModel();
    starPoint = 0;
    commentTour = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    commentTour.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        appBar: CustomAppBar(
          appBarKey: _scaffoldKey,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Image.asset(
                //   "assets/images/blank-profile-picture.png",
                //   height: height * 0.3,
                //   width: width,
                //   fit: BoxFit.cover,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.tourName,
                        style: const TextStyle(
                          color: textPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'ให้คะแนน (เต็ม 5)',
                        style: TextStyle(
                          color: black,
                        ),
                      ),
                      rateStarInput(width),
                      const SizedBox(height: 10),
                      Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: TextFieldSM(
                          labelTFF: 'แสดงความคิดเห็น',
                          hintTextinTFF: 'เขียนรีวิวโปรแกรมทัวร์',
                          textController: commentTour,
                          minLineAmount: 8,
                          inputType: TextInputType.multiline,
                          inputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: PurpleWhitePairButton(
                whiteButtonText: 'ยกเลิก',
                purpleButtonText: 'ยืนยัน',
                whiteButtonFn: () {
                  Navigator.pop(context);
                },
                purpleButtonFn: () async {
                  Navigator.pop(context);
                  bool isSavedReview = await _viewModel.saveReviewTour(
                    historyId: widget.historyId,
                    tourId: widget.tourId,
                    point: starPoint,
                    comment: commentTour.text,
                  );
                  if (isSavedReview && mounted) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TravelHistoryView(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row rateStarInput(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (starPoint >= 1)
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 0;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star,
                  color: starYellow,
                ),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 1;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star_border,
                  color: starYellow,
                ),
              ),
        const SizedBox(width: 10),
        (starPoint >= 2)
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 0;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star,
                  color: starYellow,
                ),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 2;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star_border,
                  color: starYellow,
                ),
              ),
        const SizedBox(width: 10),
        (starPoint >= 3)
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 0;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star,
                  color: starYellow,
                ),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 3;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star_border,
                  color: starYellow,
                ),
              ),
        const SizedBox(width: 10),
        (starPoint >= 4)
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 0;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star,
                  color: starYellow,
                ),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 4;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star_border,
                  color: starYellow,
                ),
              ),
        const SizedBox(width: 10),
        (starPoint == 5)
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 0;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star,
                  color: starYellow,
                ),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    starPoint = 5;
                  });
                },
                iconSize: width * 0.15,
                icon: const Icon(
                  Icons.star_border,
                  color: starYellow,
                ),
              ),
      ],
    );
  }
}
