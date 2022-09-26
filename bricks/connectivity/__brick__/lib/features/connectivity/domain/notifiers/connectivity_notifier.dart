import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, ConnectivityResult?>(
  (ref) => ConnectivityNotifier(Connectivity()),
);

class ConnectivityNotifier extends StateNotifier<ConnectivityResult?> {
  final Connectivity _connectivity;

  ConnectivityNotifier(this._connectivity) : super(null) {
    init();
  }

  void init() => _connectivity.onConnectivityChanged.listen((connectivityResult) {
        state = connectivityResult;
      });
}
