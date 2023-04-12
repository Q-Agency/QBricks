import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/notifiers/{{name.snakeCase()}}.dart';

//ignore: prefer-match-file-name
{{#dependencies}}
class Mock{{dependencyName.pascalCase()}} extends Mock implements {{dependencyName.pascalCase()}} {} {{/dependencies}}

void main() {
  {{#dependencies}}late {{dependencyName.pascalCase()}} {{dependencyName.camelCase()}};
  {{/dependencies}}

  setUpAll(() {
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
      // when(someRepository.method).thenAnswer(
      // (_) async => const Right(None()),
      // );
    },
    actions: (stateNotifier) {},
    expect: () => [],
  );
  stateNotifierTest<{{name.pascalCase()}}, BaseState<{{entity.pascalCase()}}>>(
    'executes failure flow',
    build: () => getProviderContainer().read({{name.camelCase()}}Provider.notifier),
    setUp: () {
      // when(someRepository.method).thenAnswer(
      // (_) async => Left(testGenericFailure),
      // );
    },
    actions: (stateNotifier) {},
    expect: () => [],
  );
  });
  {{/methods}}
}
