import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/either_failure_or.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/entities/failure.dart';

final urlLauncherRepositoryProvider = Provider<UrlLauncherRepository>(
  (ref) => UrlLauncherRepositoryImpl(),
);

abstract class UrlLauncherRepository {
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
