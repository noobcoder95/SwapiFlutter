import 'package:swapi_flutter/utils/enums/gender.dart';

extension GenderExt on Gender {
  String get label {
    switch (this) {
      case Gender.female: return "female";
      case Gender.hermaphrodite: return "hermaphrodite";
      case Gender.male: return "male";
      case Gender.none: return "none";
      case Gender.unknown: return "n/a";
    }
  }
}