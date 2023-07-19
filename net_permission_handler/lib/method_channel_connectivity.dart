

import 'dart:async';

import 'connectivity_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'src/utils.dart';


class MethodChannelConnectivity extends ConnectivityPlatform {


  MethodChannel methodChannel = const MethodChannel('dev.fluttercommunity.plus/connectivity');



  EventChannel eventChannel = const EventChannel('dev.fluttercommunity.plus/connectivity_status');

  Stream<ConnectivityResult>? _onConnectivityChanged;


  @override
  Future<ConnectivityResult> checkConnectivity() {
    return methodChannel
        .invokeMethod<String>('check')
        .then((value) => parseConnectivityResult(value ?? ''));
  }
}
