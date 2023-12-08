import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:url_launcher/url_launcher.dart';

final urlLauncherRepositoryProvider = Provider<UrlLauncherRepository>(
  (ref) => UrlLauncherRepositoryImpl(),
);

abstract interface class UrlLauncherRepository {
  EitherFailureOr<bool> openUrl({
    Uri? url,
    String? urlString,
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  });

  EitherFailureOr<bool> canOpenUrl({
    Uri? url,
    String? urlString,
  });
}

class UrlLauncherRepositoryImpl implements UrlLauncherRepository {
  @override
  EitherFailureOr<bool> openUrl({
    Uri? url,
    String? urlString,
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) async {
    Uri? tmpUrl = url;
    if (tmpUrl == null && urlString != null) {
      tmpUrl = Uri.tryParse(urlString);
    }
    if (tmpUrl != null) {
      try {
        return Right(await launchUrl(
          tmpUrl,
          mode: mode,
          webViewConfiguration: webViewConfiguration,
          webOnlyWindowName: webOnlyWindowName,
        ));
      } catch (error, stackTrace) {
        return Left(Failure.generic(error: error, stackTrace: stackTrace));
      }
    }
    return Left(Failure.generic());
  }

  @override
  EitherFailureOr<bool> canOpenUrl({
    Uri? url,
    String? urlString,
  }) async {
    Uri? tmpUrl = url;
    if (tmpUrl == null && urlString != null) {
      tmpUrl = Uri.tryParse(urlString);
    }
    if (tmpUrl != null) {
      try {
        return Right(await canLaunchUrl(tmpUrl));
      } catch (error, stackTrace) {
        return Left(Failure.generic(error: error, stackTrace: stackTrace));
      }
    }
    return Left(Failure.generic());
  }
}
