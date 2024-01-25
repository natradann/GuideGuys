import 'package:flutter/material.dart';
import 'package:guideguys/components/star_rate.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/guide_profile/guide_profile_model.dart';
import 'package:guideguys/modules/tour_detail/tour_detail_view.dart';

class TourCardSM extends StatelessWidget {
  const TourCardSM({
    required this.screenHeight,
    required this.screenWidth,
    required this.model,
    super.key,
  });

  final double screenHeight;
  final double screenWidth;
  final TourModel model;

  @override
  Widget build(BuildContext context) {
    double cardHeight = screenHeight * 0.25;
    double cardWidth = screenWidth * 0.4;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                TourDetialView(tourId: model.tourId),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/blank-profile-picture.png',
                    height: cardHeight * 0.5,
                    width: cardWidth,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.tourName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Wrap(
                          spacing: 2,
                          clipBehavior: Clip.hardEdge,
                          children: (model.convinces + model.tourType)
                              .map(
                                (item) => Text(
                                  '$item,',
                                  style: const TextStyle(
                                    fontSize: 8.5,
                                    color: grey700,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${model.tourPrice} บาท',
                      style: const TextStyle(fontSize: 10),
                    ),
                    StarRate(
                      sizeStar: cardWidth * 0.1,
                      pointRate: model.tourRatePoint,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
