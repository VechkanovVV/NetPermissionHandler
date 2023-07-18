
import 'package:flutter/services.dart';


class PermissionCamera{

  static Future<bool> requestCameraPermission() async {
    MethodChannel _channel = const MethodChannel('dev.fluttercommunity.plus/connectivity');
    final bool granted = await _channel.invokeMethod('requestCameraPermission');
    return granted;
  }

}