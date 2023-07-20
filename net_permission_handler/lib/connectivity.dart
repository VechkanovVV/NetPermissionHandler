import 'dart:async';
import 'connectivity_platform_interface.dart';

export 'connectivity_platform_interface.dart' show ConnectivityResult;

class Connectivity {
  static final Connectivity _instance = Connectivity._();
  static final ConnectivityPlatform _platform = ConnectivityPlatform.instance;

  factory Connectivity() => _instance;

  Connectivity._();

  Stream<ConnectivityResult> get onConnectivityChanged => _platform.onConnectivityChanged;

  Future<ConnectivityResult> checkConnectivity() => _platform.checkConnectivity();
}