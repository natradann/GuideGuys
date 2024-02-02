import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guideguys/components/star_rate.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/review/review_model.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    required this.model,
    super.key,
  });

  final RateModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: (model.customerImg != null)
                  ? Image.memory(base64Decode(model.customerImg!))
                      .image
                  : const AssetImage('assets/images/blank-profile-picture.png'),
                 
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.customerUsername,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    StarRate(
                      sizeStar: 20,
                      pointRate: model.point,
                    ),
                    Text(
                      DateFormat('MM-dd-yyyy HH:mm')
                          .format(model.commentDate)
                          .toString(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                model.comment,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
