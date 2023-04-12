# Notifier

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create your notifier with provided dependencies and methods

## Prerequisites

Installed version of [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)

## How to use 🚀

```
mason make notifier --name loginNotifier --feature_name login
```

## Variables ✨

| Variable       | Description                    | Default       | Type      |
|----------------|--------------------------------|---------------| --------- |
| `project_name` | The name of the project        | app           | `string`  |
| `name`         | The name of the notifier       | loginNotifier | `string`  |
| `entity`       | Entity related to the notifier | user          | `string`  |
| `feature_name` | The name of the feature        | login         | `string`  |

## Outputs 📦

```
mason make notifier --name loginNotifier --feature_name login --entity user
├── features
      ├── login
          ├── domain
                ├── notifiers
                      ├── login_notifier.dart
```

```dart
// login_notifier.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:myapp/common/domain/notifiers/base_state_notifier.dart';
import 'package:myapp/common/domain/notifiers/base_state.dart';
import 'package:myapp/features/login/domain/entities/user.dart';

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, BaseState<User>>((ref) => 
  LoginNotifier(
    ref,
  ));

class LoginNotifier extends BaseStateNotifier<User>{
  
  LoginNotifier(super.ref);
  
  Future<void> login() async {
    throw UnimplementedError();
  }
}



// login_notifier_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier_test/state_notifier_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUp(() {

  });

  ProviderContainer getProviderContainer() => ProviderContainer(overrides: [
    loginNotifierProvider
        .overrideWith((ref) => LoginNotifier(ref)),
  ]);

  group('login(String username)', () {
    stateNotifierTest<LoginNotifier, BaseState<User>>(
      'executes success flow',
      build: () => getProviderContainer().read(loginNotifierProvider.notifier),
      setUp: () {
        // when(someRepository.method).thenAnswer(
        // (_) async => Future.value(const Right(None())),
        // );
      },
      actions: (stateNotifier) {},
      expect: () => [],
    );
    stateNotifierTest<LoginNotifier, BaseState<User>>(
      'executes failure flow',
      build: () => getProviderContainer().read(loginNotifierProvider.notifier),
      setUp: () {
        // when(someRepository.method).thenAnswer(
        // (_) async => Future.value(const Right(None())),
        // );
      },
      actions: (stateNotifier) {},
      expect: () => [],
    );
  });
}
```