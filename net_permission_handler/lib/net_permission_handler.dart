import 'dart:async';

import 'connectivity_service.dart';
import 'permission_service.dart';


class NetPermissionHandler {
 static Future<String> checkConnection() async {
  return ConnectivityService.checkConnection();
 }

 static Future<bool> requestCameraPermission() async {
  final bool granted = await PermissionService.requestCameraPermission();
  return granted;
 }

 static Future<String> startNetworkStatusListener(void Function(String status) onStatusChanged) async {
  Completer<String> completer = Completer<String>();

  ConnectivityService().connectivityStatusStream.listen((String status) {
   // When a new status arrives, complete the completer with the updated status
   completer.complete(status);
   // Call the provided callback function to notify about the status change
   onStatusChanged(status);
  });

  // Return the future of the completer
  return completer.future;
 }
}