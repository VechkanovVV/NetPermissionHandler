

import 'dart:async';

import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'src/utils.dart';


class MethodChannelConnectivity extends ConnectivityPlatform {

  @visibleForTesting
  MethodChannel methodChannel =
      const MethodChannel('dev.fluttercommunity.plus/connectivity');


  @visibleForTesting
  EventChannel eventChannel =
      const EventChannel('dev.fluttercommunity.plus/connectivity_status');

  Stream<ConnectivityResult>? _onConnectivityChanged;


  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
    _onConnectivityChanged ??= eventChannel
        .receiveBroadcastStream()
        .map((dynamic result) => result.toString())
        .map(parseConnectivityResult);
    return _onConnectivityChanged!;
  }

  @override
  Future<ConnectivityResult> checkConnectivity() {
    return methodChannel
        .invokeMethod<String>('check')
        .then((value) => parseConnectivityResult(value ?? ''));
  }
}
