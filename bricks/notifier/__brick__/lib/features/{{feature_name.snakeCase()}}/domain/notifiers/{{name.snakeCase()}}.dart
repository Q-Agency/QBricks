{{#dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/repositories/{{dependencyName.snakeCase()}}.dart';
{{/dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:q_architecture/base_notifier.dart';

final {{name.camelCase()}}Provider = NotifierProvider<{{name.pascalCase()}}, BaseState<{{entity.pascalCase()}}>>(
  () => {{name.pascalCase()}}(),
);

class {{name.pascalCase()}} extends BaseNotifier<BaseState<{{entity.pascalCase()}}>>{
  {{#dependencies}}late {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  @override
  void prepareForBuild() {
  {{#dependencies}}
    _{{dependencyName.camelCase()}} = ref.watch({{dependencyName.camelCase()}}Provider);
  {{/dependencies}}
  }

  {{#methods}}
  Future<{{{type}}}> {{methodName}}({{#parameters}}
      {{{type}}} {{parameterName}},{{/parameters}}) async {
    throw UnimplementedError();
  } {{/methods}}
}
