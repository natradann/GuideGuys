import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:intl/intl.dart';

class TourHistoryCard extends StatelessWidget {
  const TourHistoryCard({
    required this.tourName,
    required this.guideName,
    this.status = 'รอการยืนยัน',
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.screenWidth,
    required this.onPressed,
    super.key,
  });

  final String tourName;
  final String guideName;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final int price;
  final double screenWidth;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
          color: white,
          border: Border.symmetric(
            horizontal: BorderSide(color: yellow),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  tourName,
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                //เพิ่ม status & แก้สีตัวอักษร
                Text(
                  (status == '0')
                      ? 'รอการยืนยัน'
                      : (status == '1')
                          ? 'ยืนยันสำเร็จ'
                          : (status == '2')
                              ? 'รอการรีวิว'
                              : 'สำเร็จ',
                  style: TextStyle(
                    color: (status == '0')
                        ? yellow
                        : (status == '1')
                            ? Colors.green
                            : (status == '2')
                                ? Colors.purple
                                : Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  guideName,
                  style: TextStyle(
                    color: black,
                    fontSize: screenWidth * 0.025,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat.yMEd().format(startDate)} - ${DateFormat.yMEd().format(endDate)}',
                  style: TextStyle(
                    color: black,
                    fontSize: screenWidth * 0.025,
                  ),
                ),
                Text(
                  '$price บาท',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
