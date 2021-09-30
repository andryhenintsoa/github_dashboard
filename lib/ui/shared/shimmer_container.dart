import 'dart:math';

import 'package:flutter/material.dart';

import '../styling.dart';

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? randomRangeHeight;
  final double? randomRangeWidth;

  const ShimmerContainer({
    Key? key,
    this.height,
    this.width,
    this.randomRangeHeight,
    this.randomRangeWidth,
  }) : super(key: key);

  ShimmerContainer.text({
    Key? key,
    double? width,
    double? randomRangeWidth,

  }) :this(height: shimmerTextHeight(),
    width: width,
    randomRangeWidth: randomRangeWidth,
  );

  @override
  Widget build(BuildContext context) {
    double? calculatedWidth = width;

    if (randomRangeWidth != null && calculatedWidth != null) {
      calculatedWidth += Random().nextInt(randomRangeWidth!.ceil());
    }

    double? calculatedHeight = height;

    if (randomRangeHeight != null && calculatedHeight != null) {
      calculatedHeight += Random().nextInt(randomRangeHeight!.ceil());
    }

    return Container(
      height: calculatedHeight,
      width: calculatedWidth,
      color: Colors.white,
    );
  }
}
