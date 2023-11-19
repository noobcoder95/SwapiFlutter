import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends Shimmer {
  AppShimmer({
    super.key,
    required double height,
    double? width
  }) : super.fromColors(
    highlightColor: Colors.grey.withOpacity(.5),
    baseColor: Colors.grey.shade200,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      width: width,
      height: height,
    ),
  );
}