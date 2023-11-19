import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static Future<bool> get check async {
    final res = await Connectivity().checkConnectivity();
    if (res == ConnectivityResult.mobile) {
      return true;
    } else if (res == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static Stream<bool> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged.map(
          (event) => event != ConnectivityResult.none,
    );
  }
}