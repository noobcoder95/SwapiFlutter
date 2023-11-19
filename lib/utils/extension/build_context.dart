import 'package:flutter/material.dart';
import 'package:swapi_flutter/utils/app_helpers.dart';

extension BuildContextExt on BuildContext {
  bool get isMobileScreen {
    return MediaQuery.of(this).size.width <= 900;
  }

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get maxAllowedWidth => AppHelpers.isWebDesktop && !isMobileScreen
      ? 900 : screenWidth;

  double get maxBottomSheetWidth => AppHelpers.isWebDesktop && !isMobileScreen
      ? 640 : screenWidth;
}