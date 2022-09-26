import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/error_codes.dart';
import 'package:local_auth/local_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:local_auth_android/local_auth_android.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/either_failure_or.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/entities/failure.dart';

final localAuthRepositoryProvider =
    Provider<LocalAuthRepository>((ref) => LocalAuthRepositoryImpl(LocalAuthentication()));

abstract class LocalAuthRepository {
  EitherFailureOr<BiometricType> getAvailableBiometricType();

  EitherFailureOr<bool> authenticate({
    required String localizedReason,
    List<AuthMessages>? authMessages,
    AuthenticationOptions? options,
  });
}

class LocalAuthRepositoryImpl implements LocalAuthRepository {
  final LocalAuthentication _localAuthentication;

  const LocalAuthRepositoryImpl(this._localAuthentication);

  @override
  EitherFailureOr<bool> authenticate({
    required String localizedReason,
    List<AuthMessages>? authMessages,
    AuthenticationOptions? options,
  }) async {
    try {
      final result = await _localAuthentication.authenticate(
        localizedReason: localizedReason,
        authMessages: authMessages ?? [const AndroidAuthMessages(biometricHint: '')],
        options: options ?? const AuthenticationOptions(),
      );
      return Right(result);
    } on PlatformException catch (error, stackTrace) {
      if (error.code == notEnrolled) {
        return Left(Failure.generic(title: 'No hardware', error: error, stackTrace: stackTrace));
      } else if (error.code == lockedOut || error.code == permanentlyLockedOut) {
        return Left(Failure.generic(title: 'Locked out', error: error, stackTrace: stackTrace));
      } else {
        return Left(Failure.generic(title: 'Local auth error', error: error, stackTrace: stackTrace));
      }
    }
  }

  @override
  EitherFailureOr<BiometricType> getAvailableBiometricType() async {
    final availableBiometrics = await LocalAuthentication().getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      return Left(Failure.generic(title: 'No biometrics available'));
    } else if (availableBiometrics.contains(BiometricType.face)) {
      return const Right(BiometricType.face);
    } else if (availableBiometrics.contains(BiometricType.iris)) {
      return const Right(BiometricType.iris);
    }
    return const Right(BiometricType.fingerprint);
  }
}
