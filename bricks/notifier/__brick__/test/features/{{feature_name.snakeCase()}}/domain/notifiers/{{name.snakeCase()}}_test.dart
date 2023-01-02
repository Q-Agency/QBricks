import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:{{project_name.snakeCase()}}/common/domain/notifiers/base_state.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/notifiers/{{name.snakeCase()}}.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

//ignore: prefer-match-file-name
{{#dependencies}}
class Mock{{dependencyName.pascalCase()}} extends Mock implements {{dependencyName.pascalCase()}} {} {{/dependencies}}

void main() {
  {{#dependencies}}late {{dependencyName.pascalCase()}} {{dependencyName.camelCase()}};
  {{/dependencies}}

  setUp(() {
  {{#dependencies}}{{dependencyName.camelCase()}} = Mock{{dependencyName.pascalCase()}}();
  {{/dependencies}}
  });

  ProviderContainer getProviderContainer() => ProviderContainer(overrides: [
    {{name.camelCase()}}Provider.overrideWith((ref) =>
      {{name.pascalCase()}}({{#dependencies}}{{dependencyName.camelCase()}}, {{/dependencies}}ref)),
  ]);

  {{#methods}}
  group('{{methodName}}', () {
  stateNotifierTest<{{name.pascalCase()}}, BaseState<{{entity.pascalCase()}}>>(
    'executes success flow',
    build: () => getProviderContainer().read({{name.camelCase()}}Provider.notifier),
    setUp: () {
      // when(someRepository.method()).thenAnswer(
      // (_) async => Future.value(const Right(None())),
      // );
    },
    actions: (stateNotifier) {},
    expect: () => [],
  );
  stateNotifierTest<{{name.pascalCase()}}, BaseState<{{entity.pascalCase()}}>>(
    'executes failure flow',
    build: () => getProviderContainer().read({{name.camelCase()}}Provider.notifier),
    setUp: () {
      // when(someRepository.method()).thenAnswer(
      // (_) async => Future.value(const Right(None())),
      // );
    },
    actions: (stateNotifier) {},
    expect: () => [],
  );
  });
  {{/methods}}
}
