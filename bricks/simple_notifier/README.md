# SimpleNotifier

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create your simple_notifier with provided dependencies and methods

## Prerequisites

Installed version of [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)

## How to use 🚀

```
mason make simple_notifier --name loginNotifier --feature_name login
```

## Variables ✨

| Variable       | Description                     | Default       | Type     |
| -------------- | ------------------------------- | ------------- | -------- |
| `project_name` | The name of the project         | app           | `string` |
| `name`         | The name of the simple_notifier | loginNotifier | `string` |
| `feature_name` | The name of the feature         | login         | `string` |
| `state`        | The name of the state           |               | `string` |

## Outputs 📦

```
mason make simple_notifier --name loginNotifier --feature_name login --state customState
├── features
      ├── login
          ├── domain
                ├── notifiers
                      ├── login_notifier.dart
```

```dart
// login_notifier.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:myapp/features/login/domain/notifiers/custom_state.dart';

final loginNotifierProvider = NotifierProvider<LoginNotifier, CustomState>(() => 
  LoginNotifier());

class LoginNotifier extends SimpleNotifier<CustomState>{
  
  LoginNotifier(super.ref);
  @override
  CustomState prepareForBuild() {
    return ;
  }
  
  Future<void> login() async {
    throw UnimplementedError();
  }
}



// login_notifier_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:myapp/features/login/domain/notifiers/login_notifier.dart';
import 'package:myapp/features/login/domain/notifiers/custom_state.dart';

void main() {
  late ProviderContainer providerContainer;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    providerContainer = ProviderContainer(overrides: [
    ]);
  });

  group('login()', () {
    test('executes success flow', () async {
      when(someRepository.method).thenAnswer(
        (_) async => const Right(None()),
      );
      final states = <CustomState>[];
      providerContainer.listen(
         loginNotifierProvider,
         (_, state) => states.add(state),
      );
      final notifier = providerContainer.read(loginNotifierProvider.notifier);
      await notifier.login();
      expect([], states);
    });

    test('executes failure flow', () async {
      when(someRepository.method).thenAnswer(
        (_) async => Left(testGenericFailure),
      );
      final states = <CustomState>[];
      providerContainer.listen(
        loginNotifierProvider,
        (_, state) => states.add(state),
      );
      final notifier = providerContainer.read(loginNotifierProvider.notifier);
      await notifier.login();
      expect([], states);
    });
  });
}
```
