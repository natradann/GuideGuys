import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:guideguys/components/star_rate.dart';
import 'package:guideguys/components/tag_in_card.dart';
import 'package:guideguys/constants/colors.dart';

class CardLG extends StatelessWidget {
  const CardLG({
    // required this.model,
    required this.id,
    required this.title,
    this.base64Image,
    required this.tagList,
    this.price,
    required this.ratePoint,
    required this.screenHeight,
    required this.screenWidth,
    required this.onTapped,
    super.key,
  });

  // final TourCardLGModel model;
  final String id;
  final String title;
  final String? base64Image;
  final List<String> tagList;
  final int? price;
  final double ratePoint;
  final double screenHeight;
  final double screenWidth;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    double cardHeight = screenHeight * 0.28;
    double cardWidth = screenWidth;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTapped,
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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (base64Image != null) ?
                  Image.memory(
                    base64Decode(base64Image!),
                    height: cardHeight * 0.56,
                    width: screenWidth,
                    fit: BoxFit.cover,
                  ) :
                  Image.asset(
                    "assets/images/blank-profile-picture.png",
                    height: cardHeight * 0.56,
                    width: screenWidth,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: cardHeight * 0.08,
                                color: black,
                              ),
                            ),
                            (price != null)
                                ? Text(
                                    "$price บาท",
                                    style: TextStyle(
                                      fontSize: cardHeight * 0.06,
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: cardHeight * 0.12,
                          width: cardWidth * 0.5,
                          child: Wrap(
                            runSpacing: 5,
                            clipBehavior: Clip.hardEdge,
                            children: (tagList)
                                .map(
                                  (item) => TagInCard(
                                    tagName: item,
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'คะแนน ${ratePoint.toString()}',
                      style: TextStyle(
                        fontSize: cardHeight * 0.045,
                        color: black,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.01,
                    ),
                    Icon(
                      Icons.circle,
                      size: cardWidth * 0.01,
                    ),
                    SizedBox(
                      width: screenWidth * 0.01,
                    ),
                    StarRate(
                      sizeStar: cardWidth * 0.05,
                      pointRate: ratePoint,
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
