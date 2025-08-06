import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:{{project_name.snakeCase()}}/common/utils/service_locator.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/notifiers/{{name.snakeCase()}}.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/notifiers/{{state.snakeCase()}}.dart';

{{#dependencies}}
class Mock{{dependencyName.pascalCase()}} extends Mock implements {{dependencyName.pascalCase()}} {} {{/dependencies}}

void main() {
  {{#dependencies}}late {{dependencyName.pascalCase()}} {{dependencyName.camelCase()}};
  {{/dependencies}}

  setUp(() {
  TestWidgetsFlutterBinding.ensureInitialized();
  getIt.allowReassignment = true;
  setupServiceLocator();
  {{#dependencies}}
  {{dependencyName.camelCase()}} = Mock{{dependencyName.pascalCase()}}();
  getIt.registerSingleton<{{dependencyName.pascalCase()}}>({{dependencyName.camelCase()}});
  {{/dependencies}}
  });

  {{#methods}}
  group('{{methodName}}', () {
    test('executes success flow', () async {
      // when(someRepository.method).thenAnswer(
      // (_) async => const Right(None()),
      // );
      final states = <{{state.pascalCase()}}>[];
      final notifier = getIt<{{name.pascalCase()}}>();
      final _ = notifier.listen(
        (currentState, _) => states.add(currentState),
        fireImmediately: false,
      );
      // await notifier.{{methodName}}();
      // expect([], states);
    });

    test('executes failure flow', () async {
      // when(someRepository.method).thenAnswer(
      // (_) async => Left(testGenericFailure),
      // );
      final states = <{{state.pascalCase()}}>[];
      final notifier = getIt<{{name.pascalCase()}}>();
      final _ = notifier.listen(
        (currentState, _) => states.add(currentState),
        fireImmediately: false,
      );
      // await notifier.{{methodName}}();
      // expect([], states);
    });
  });
  {{/methods}}
}
