import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'connectivity.dart';

class ConnectivityService {

  static Future<String> checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return "mobile";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return "wifi";
    } else {
      return "none";
    }
  }
}
