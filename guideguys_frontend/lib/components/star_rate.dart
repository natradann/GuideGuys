import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';

class StarRate extends StatelessWidget {
  const StarRate({
    required this.sizeStar,
    required this.pointRate,
    super.key,
  });

  final double sizeStar;
  final double pointRate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          (pointRate >= 0.5 && pointRate < 1) ?
          Icons.star_half : 
          (pointRate >= 1) ? 
          Icons.star : Icons.star_border,
          color: starYellow,
          size: sizeStar,
        ),
        Icon(
          (pointRate >= 1.5 && pointRate < 2) ?
          Icons.star_half : 
          (pointRate >= 2) ? 
          Icons.star : Icons.star_border,
          color: starYellow,
          size: sizeStar,
        ),
        Icon(
          (pointRate >= 2.5 && pointRate < 3) ?
          Icons.star_half : 
          (pointRate > 3) ? 
          Icons.star : Icons.star_border,
          color: starYellow,
          size: sizeStar,
        ),
        Icon(
          (pointRate >= 3.5 && pointRate < 4) ?
          Icons.star_half : 
          (pointRate >= 4) ? 
          Icons.star : Icons.star_border,
          color: starYellow,
          size: sizeStar,
        ),
        Icon(
          (pointRate >= 4.5 && pointRate < 5) ?
          Icons.star_half : 
          (pointRate == 5) ? 
          Icons.star : Icons.star_border,
          color: starYellow,
          size: sizeStar,
        ),
      ],
    );
  }
}
