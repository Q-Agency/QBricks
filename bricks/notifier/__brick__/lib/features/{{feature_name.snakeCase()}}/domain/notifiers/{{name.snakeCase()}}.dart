{{#dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/repositories/{{dependencyName.snakeCase()}}.dart';
{{/dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:q_architecture/q_architecture.dart';

final {{name.camelCase()}}Provider = BaseStateNotifierProvider<{{name.pascalCase()}}, {{entity.pascalCase()}}>((ref) =>
    {{name.pascalCase()}}(
      {{#dependencies}}ref.watch({{dependencyName.camelCase()}}Provider),{{/dependencies}} ref,
    ));

class {{name.pascalCase()}} extends BaseStateNotifier<{{entity.pascalCase()}}>{
  {{#dependencies}}final {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  {{name.pascalCase()}}({{#dependencies}}this._{{dependencyName.camelCase()}},{{/dependencies}} super.ref);
  
  {{#methods}}
  Future<{{{type}}}> {{methodName}}({{#parameters}}
      {{{type}}} {{parameterName}},{{/parameters}}) async {
    throw UnimplementedError();
  } {{/methods}}
}
