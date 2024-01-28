import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guideguys/components/star_rate.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/guide_profile/guide_profile_view.dart';
import 'package:guideguys/modules/home/home_model.dart';

class GuideCardSM extends StatelessWidget {
  const GuideCardSM({
    required this.model,
    required this.screenHeight,
    required this.screenWidth,
    super.key,
  });

  final GuideModel model;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    double cardHeight = screenHeight * 0.23;
    double cardWidth = screenWidth * 0.32;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                GuideProfileView(guideId: model.guideId),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (model.guideImg != null)
                      ? Image.memory(
                          base64Decode(model.guideImg!),
                          height: cardHeight * 0.56,
                          width: screenWidth,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/blank-profile-picture.png",
                          height: cardHeight * 0.53,
                          width: cardWidth,
                          fit: BoxFit.cover,
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.guideName,
                          style: TextStyle(
                            fontSize: cardHeight * 0.08,
                            color: black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: cardHeight * 0.11,
                          child: Wrap(
                            spacing: 2,
                            runSpacing: 0,
                            clipBehavior: Clip.hardEdge,
                            children: model.convinces
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: StarRate(
                  sizeStar: cardWidth * 0.14,
                  pointRate: model.ratePoint,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
