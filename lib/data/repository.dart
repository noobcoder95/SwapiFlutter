import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:swapi_flutter/localizations/locale_keys.g.dart';
import 'package:flutter/foundation.dart';
import 'package:swapi_flutter/data/models/api_response.dart';
import 'package:swapi_flutter/main.dart';
import 'package:swapi_flutter/utils/connectivity_helper.dart';
import 'package:isolated_worker/js_isolated_worker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class Repository {
  Future<ApiResponse> fromApi(String path);
  dynamic fromLocal(String path);
  Future<ApiResponse> getData(String path);
}

class RepositoryImplementation implements Repository {
  @override
  Future<ApiResponse> fromApi(String path) async {
    final isOnline = await ConnectivityHelper.check;

    if (!isOnline) {
      return ApiResponse(message: LocaleKeys.noInternetConnection.tr().toUpperCase());
    }

    /// Using isolated worker to support concurrency/multithreading in web platform
    if(kIsWeb) {
      await JsIsolatedWorker().importScripts(['obfuscated_http_client.js']);
      final response =  await JsIsolatedWorker().run(
        functionName: 'get',
        arguments: path,
      ) as LinkedHashMap<dynamic, dynamic>;
      final map = response.map((a, b) => MapEntry(a as String, b));
      return ApiResponse(data: map['jsonResponse']
      );
    }

    return await compute(httpGet, path);
  }

  @override
  dynamic fromLocal(String path) {
    final storage = di.get<SharedPreferences>();
    final data = storage.getString(path) ?? '';

    /// Get date created of cached data
    final dateTime = DateTime.tryParse(
        storage.getString('dateCreated') ?? '');

    /// Check if cached data is older than 7 days
    if(dateTime != null && dateTime.subtract(
        const Duration(days: 7)).isBefore(DateTime.now())) {
      /// Return null if there's no data stored in local storage
      if(data.isEmpty) {
        return null;
      }
      return jsonDecode(data);
    } else if(dateTime != null && dateTime.subtract(
        const Duration(days: 7)).isAfter(DateTime.now())) {
      storage.clear(); /// Clear local storage
    }

    return null;
  }

  @override
  Future<ApiResponse> getData(String path) async {
    final storage = di.get<SharedPreferences>();
    final localData = fromLocal(path);

    /// Check if there's data stored in local storage
    if(localData == null) {
      /// Fetch data from API
      final response = await fromApi(path);
      if(response.data != null) {
        final dateTime = DateTime.tryParse(
            storage.getString('dateCreated') ?? '');
        if(dateTime == null) {
          /// Set date created of local storage
          storage.setString('dateCreated', DateTime.now().toString());
        }

        /// Save data from API to local storage
        storage.setString(path, jsonEncode(response.data));
      }
      return response;
    }

    return ApiResponse(data: localData);
  }
}

/// The API call function must be a top level function
/// to support concurrency/multithreading on mobile using compute()
Future<ApiResponse> httpGet(String path) async {
  try {
    final client = http.Client();
    final response = await client.get(Uri.parse(path));

    return ApiResponse(data: jsonDecode(response.body)
    );
  } catch (e, st) {
    if(kDebugMode) {
      log('Error Message: $e');
      log('Stack Trace: $st');
    }
    return ApiResponse(message: '$e');
  }
}