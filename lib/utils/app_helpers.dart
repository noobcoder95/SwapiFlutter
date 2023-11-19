import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swapi_flutter/main.dart';

class AppHelpers {
  static BuildContext? get context => di.get<GlobalKey<NavigatorState>>().currentContext;

  static bool get isWebDesktop => kIsWeb
      && defaultTargetPlatform != TargetPlatform.android
      && defaultTargetPlatform != TargetPlatform.iOS;
  static bool get isAndroid => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static void showSnackBar({
    required String message,
    BuildContext? context,
    Color? textColor,
    Color? bgColor,
    Duration? duration,
    SnackBarAction? action}) {
    final snackBar = SnackBar(
        content: Text(message),
        action: action,
        duration: duration ?? const Duration(seconds: 4),
        backgroundColor: bgColor);
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      di.get<GlobalKey<ScaffoldMessengerState>>().currentState?.showSnackBar(snackBar);
    }
  }
}