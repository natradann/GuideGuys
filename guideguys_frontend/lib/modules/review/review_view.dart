import 'package:flutter/material.dart';
import 'package:guideguys/components/custom_appbar.dart';
import 'package:guideguys/components/profile_menu.dart';
import 'package:guideguys/components/seperate_line.dart';
import 'package:guideguys/components/star_rate.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/review/components/comment_card.dart';
import 'package:guideguys/modules/review/review_model.dart';
import 'package:guideguys/modules/review/review_view_model.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class ReviewView extends StatefulWidget {
  const ReviewView({
    required this.tourId,
    super.key,
  });

  final String tourId;

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  late ReviewViewModel _viewModel;
   final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = ReviewViewModel();
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
        appBar: CustomAppBar(appBarKey: _scaffoldKey,),
        endDrawer: ProfileMenu(width: width),
        body: FutureBuilder(
          future: _viewModel.fetchAllReview(tourId: widget.tourId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Image.asset(
                    "assets/images/blank-profile-picture.png",
                    height: height * 0.3,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _viewModel.allReviews.tourName,
                          style: const TextStyle(
                            color: textPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SeperateLine(),
                        const SizedBox(height: 10),
                        const Text(
                          'Reviews',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        // const SizedBox(height: 5),
                        Row(
                          children: [
                            StarRate(
                              sizeStar: width * 0.06,
                              pointRate: _viewModel.allReviews.tourPoint,
                            ),
                            const SizedBox(width: 10),
                            Text(
                                '${_viewModel.allReviews.tourPoint} จาก 5 คะแนน')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _viewModel.allReviews.rate.length,
                      itemBuilder: (context, index) {
                        RateModel rate = _viewModel.allReviews.rate[index];
                        return CommentCard(
                          model: rate,
                        );
                      },
                    ),
                  ),
                  // const CommentCard(),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   child: SeperateLine(),
                  // ),
                  // const CommentCard(),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   child: SeperateLine(),
                  // ),
                  // const CommentCard(),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   child: SeperateLine(),
                  // ),
                  // const CommentCard(),
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
}
