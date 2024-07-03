import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final bool isBorder;

  ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    required this.isBorder,
  }) : shapeBorder = RoundedRectangleBorder(
    borderRadius: isBorder ? BorderRadius.circular(15) : BorderRadius.zero,
  );

  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
    required this.isBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.secondary!,
      highlightColor: Theme.of(context).colorScheme.primary!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey[400]!,
          shape: shapeBorder,

        ),
      ),
    );
  }
}
