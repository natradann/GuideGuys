import 'package:flutter/material.dart';
import 'package:guideguys/components/star_rate.dart';
import 'package:guideguys/components/tag_in_card.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/create_tour/create_tour_view.dart';
import 'package:guideguys/modules/my_tour_list/my_tour_list_model.dart';
import 'package:guideguys/modules/tour_detail/tour_detail_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TourCard extends StatelessWidget {
  const TourCard({
    required this.model,
    required this.screenHeight,
    required this.screenWidth,
    required this.onTapped,
    super.key,
  });

  final MyTourListModel model;
  final double screenHeight;
  final double screenWidth;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    double cardHeight = screenHeight * 0.3;
    double cardWidth = screenWidth;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          GestureDetector(
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
                      Image.asset(
                        model.tourImgPath,
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
                                  model.tourName,
                                  style: TextStyle(
                                    fontSize: cardHeight * 0.08,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  "${model.price} บาท",
                                  style: TextStyle(
                                    fontSize: cardHeight * 0.06,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 30,
                              width: cardWidth * 0.5,
                              child: Wrap(
                                runSpacing: 5,
                                clipBehavior: Clip.hardEdge,
                                children: (model.convinces + model.languages + model.type)
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
                        // Text(
                        //   "ขายได้ 5",
                        //   style: TextStyle(
                        //     fontSize: cardHeight * 0.04,
                        //     color: black,
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: screenWidth * 0.01,
                        // ),
                        // Icon(
                        //   Icons.circle,
                        //   size: cardWidth * 0.01,
                        // ),
                        // SizedBox(
                        //   width: screenWidth * 0.01,
                        // ),
                        Text(
                          'คะแนน ${(model.ratePoint).toString()}',
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
                          pointRate: model.ratePoint,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                isDense: true,
                dropdownStyleData: DropdownStyleData(
                  width: cardWidth * 0.3,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: white,
                  ),
                  offset: const Offset(0, -8),
                ),
                customButton: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgColor,
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: grey700,
                    size: cardWidth * 0.08,
                  ),
                ),
                onChanged: (value) {},
                items: [
                  DropdownMenuItem(
                    value: 'Edit',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const CreateTourView(),
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: grey700,
                          ),
                          SizedBox(width: 10),
                          Text('Edit'),
                        ],
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Delete',
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: grey700,
                          ),
                          SizedBox(width: 10),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _reviewDetail(double cardHeight, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "ขายได้ 5",
          style: TextStyle(
            fontSize: cardHeight * 0.04,
            color: black,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.01,
        ),
        Icon(
          Icons.circle,
          size: width * 0.04,
        ),
        SizedBox(
          width: screenWidth * 0.01,
        ),
        Text(
          "2 รีวิว",
          style: TextStyle(
            fontSize: cardHeight * 0.04,
            color: black,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.01,
        ),
        Icon(
          Icons.circle,
          size: width * 0.04,
        ),
        SizedBox(
          width: screenWidth * 0.01,
        ),
        StarRate(
          sizeStar: width * 0.15,
          pointRate: 4,
        ),
      ],
    );
  }

  ClipRRect tagInCard({required String tagName}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        color: tagColor,
        child: Text(
          tagName,
          style: const TextStyle(fontSize: 8),
        ),
      ),
    );
  }
}
