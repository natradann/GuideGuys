import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';

class FindAllBar extends StatelessWidget {
  const FindAllBar({
    required this.h,
    required this.menu,
    required this.action,
    super.key,
  });

  final double h;
  final String menu;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: h * 0.035,
      decoration: const BoxDecoration(
        color: yellow,
        boxShadow: [
          BoxShadow(),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            menu,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: action,
            child: Row(
              children: const [
                Text(
                  "ดูทั้งหมด",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.navigate_next_rounded)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
