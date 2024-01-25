import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';

class TagInCard extends StatelessWidget {
  const TagInCard({required this.tagName, super.key});

  final String tagName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 45,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: tagColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          tagName,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: grey700,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
