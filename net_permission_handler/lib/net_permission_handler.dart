import 'connectivity_service.dart';
import 'permission_service.dart';

class NetPermissionHandler{
 static Future<String> checkConnection() async{
   return ConnectivityService.checkConnection();
 }


 static Future<bool> requestCameraPermission() async {
   final bool granted = await  await PermissionService.requestCameraPermission();
   return granted;
 }

}