// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "ascending": "Ascending",
  "chooseStarship": "Choose Starship",
  "chooseVehicle": "Choose Vehicle",
  "climate": "Climate",
  "close": "Close",
  "costInCredits": "Cost in Credits",
  "descending": "Descending",
  "filterByGender": "Filter by Gender",
  "filtersAndSort": "Filters & Sort",
  "gender": "Gender",
  "homeworld": "Homeworld",
  "hyperdriveRating": "Hyperdrive Rating",
  "pleaseWait": "Please Wait",
  "manufacturer": "Manufacturer",
  "model": "Model",
  "noInternetConnection": "No Internet Connection",
  "population": "Population",
  "showMore": "Show More",
  "showResult": "Show Results",
  "sortByName": "Sort by Name",
  "starship": "Starship",
  "strarshipClass": "Starship Class",
  "vehicle": "Vehicle"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
