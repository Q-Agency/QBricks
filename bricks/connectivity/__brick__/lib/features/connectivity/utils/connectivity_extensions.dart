import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/features/connectivity/domain/notifiers/connectivity_notifier.dart';

extension ConnectivityExtensions on WidgetRef {
  void globalConnectivityListener() {
    listen<ConnectivityResult?>(
      connectivityProvider,
      (previous, current) {
        if (current == ConnectivityResult.none && previous != null) {
          log('no connection');
        } else if (previous == ConnectivityResult.none &&
            (current == ConnectivityResult.mobile || current == ConnectivityResult.wifi)) {
          log('connection is back');
        }
      },
    );
  }
}
