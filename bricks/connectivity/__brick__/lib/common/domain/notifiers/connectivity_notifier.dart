import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:{{project_name.snakeCase()}}/common/utils/connection_status.dart';

class ConnectivityNotifier extends QNotifier<ConnectionStatus> {
  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>>
      _connectivitySubscription;

  ConnectivityNotifier({super.autoDispose})
      : _connectivity = Connectivity(),
        super(ConnectionStatus.undefined) {
    _init();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _init() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      connectivityResult,
    ) {
      final isConnected =
          connectivityResult.contains(ConnectivityResult.wifi) ||
              connectivityResult.contains(ConnectivityResult.mobile);
      state = isConnected ? ConnectionStatus.online : ConnectionStatus.offline;
    });
  }
}
