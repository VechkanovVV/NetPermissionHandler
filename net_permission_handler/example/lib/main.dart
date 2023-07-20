
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:netPermissionHandler/connectivity_service.dart';
import 'package:netPermissionHandler/net_permission_handler.dart';



class ConnectionStatusWidget extends StatefulWidget {
  @override
  _ConnectionStatusWidgetState createState() => _ConnectionStatusWidgetState();
}

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {
  String _connectionStatus = 'Проверка соединения...';
  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void initState() {
    super.initState();
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    _connectivityService.connectivityStatusStream.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Состояние соединения'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Состояние соединения: $_connectionStatus'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Запрос разрешения камеры
              },
              child: Text('Запросить разрешение камеры'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: ConnectionStatusWidget(),
));