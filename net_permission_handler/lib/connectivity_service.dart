
import 'connectivity.dart';
import 'connectivity_platform_interface.dart';

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
