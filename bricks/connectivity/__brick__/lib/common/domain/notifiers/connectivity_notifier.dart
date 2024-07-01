import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:{{project_name.snakeCase()}}/common/utils/connection_status.dart';

final connectivityProvider =
    NotifierProvider<ConnectivityNotifier, ConnectionStatus>(
  () => ConnectivityNotifier(),
);

class ConnectivityNotifier extends Notifier<ConnectionStatus> {
  late Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  ConnectionStatus build() {
    _connectivity = Connectivity();
    _init();
    ref.onDispose(() => _connectivitySubscription.cancel());
    return ConnectionStatus.undefined;
  }

  void _init() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        final isConnected =
            connectivityResult.contains(ConnectivityResult.wifi) ||
                connectivityResult.contains(ConnectivityResult.mobile);
        state =
            isConnected ? ConnectionStatus.online : ConnectionStatus.offline;
      },
    );
  }
}
