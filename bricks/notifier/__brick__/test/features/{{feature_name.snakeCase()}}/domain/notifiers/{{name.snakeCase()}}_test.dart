import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';

import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/notifiers/{{name.snakeCase()}}.dart';

//ignore: prefer-match-file-name
{{#dependencies}}
class Mock{{dependencyName.pascalCase()}} extends Mock implements {{dependencyName.pascalCase()}} {} {{/dependencies}}

void main() {
  {{#dependencies}}late {{dependencyName.pascalCase()}} {{dependencyName.camelCase()}};
  {{/dependencies}}
  late ProviderContainer providerContainer;

  setUp(() {
  TestWidgetsFlutterBinding.ensureInitialized();
  {{#dependencies}}{{dependencyName.camelCase()}} = Mock{{dependencyName.pascalCase()}}();
  {{/dependencies}}
  providerContainer = ProviderContainer(overrides: [
    {{name.camelCase()}}Provider.overrideWith((ref) =>
      {{name.pascalCase()}}()),
  {{#dependencies}}
    {{dependencyName.camelCase()}}Provider.overrideWith((ref) => {{dependencyName.camelCase()}}),
  {{/dependencies}}
  ]);
  });

  {{#methods}}
  group('{{methodName}}', () {
    test('executes success flow', () async {
      // when(someRepository.method).thenAnswer(
      // (_) async => const Right(None()),
      // );
      final states = <BaseState>[];
      providerContainer.listen(
        {{name.camelCase()}}Provider,
        (_, state) => states.add(state),
      );
      final notifier = providerContainer.read({{name.camelCase()}}Provider.notifier);
      // await notifier.{{methodName}}();
      // expect([], states);
    });

    test('executes failure flow', () async {
      // when(someRepository.method).thenAnswer(
      // (_) async => Left(testGenericFailure),
      // );
      final states = <BaseState>[];
      providerContainer.listen(
        {{name.camelCase()}}Provider,
        (_, state) => states.add(state),
      );
      final notifier = providerContainer.read({{name.camelCase()}}Provider.notifier);
      // await notifier.{{methodName}}();
      // expect([], states);
    });
  });
  {{/methods}}
}
