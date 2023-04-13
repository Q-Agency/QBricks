import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
{{#dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/notifiers/{{dependencyName.snakeCase()}}.dart';
{{/dependencies}}

class {{name.pascalCase()}} extends ConsumerWidget {
  const {{name.pascalCase()}}({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    {{#dependencies}}final {{dependencyName.camelCase()}}State = ref.watch({{dependencyName.camelCase()}}Provider);
    {{/dependencies}}
    return const Scaffold(
      body: Placeholder(),
    );
  }
}
