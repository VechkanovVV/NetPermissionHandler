

import 'dart:async';

import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';

// Export enums from the platform_interface so plugin users can use them directly.
export 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart'
    show ConnectivityResult;

export 'src/connectivity_plus_linux.dart'
    if (dart.library.html) 'src/connectivity_plus_web.dart';


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
