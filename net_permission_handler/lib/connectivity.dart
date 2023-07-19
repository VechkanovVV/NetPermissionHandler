

import 'dart:async';

import 'connectivity_platform_interface.dart';

// Export enums from the platform_interface so plugin users can use them directly.
export 'connectivity_platform_interface.dart'
    show ConnectivityResult;




class Connectivity {
  static Connectivity? _instance;
  static ConnectivityPlatform _platform = ConnectivityPlatform.instance;

  factory Connectivity() {
    _instance ??= Connectivity._();
    return _instance!;
  }

  Connectivity._();

  Stream<ConnectivityResult> get onConnectivityChanged {
    return _platform.onConnectivityChanged;
  }

  Future<ConnectivityResult> checkConnectivity() {
    return _platform.checkConnectivity();
  }
}
