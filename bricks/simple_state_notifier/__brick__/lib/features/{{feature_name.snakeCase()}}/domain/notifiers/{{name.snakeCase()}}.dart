{{#dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/repositories/{{dependencyName.snakeCase()}}.dart';
{{/dependencies}}
import 'package:q_architecture/q_architecture.dart';

final {{name.camelCase()}}Provider = StateNotifierProvider<{{name.pascalCase()}}, >((ref) =>
    {{name.pascalCase()}}(
      {{#dependencies}}ref.watch({{dependencyName.camelCase()}}Provider),{{/dependencies}} ref,
    ));

class {{name.pascalCase()}} extends SimpleStateNotifier<>{
  {{#dependencies}}final {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  {{name.pascalCase()}}({{#dependencies}}this._{{dependencyName.camelCase()}},{{/dependencies}} super.ref);
  
  {{#methods}}
  Future<{{{type}}}> {{methodName}}({{#parameters}}
      {{{type}}} {{parameterName}},{{/parameters}}) async {
    throw UnimplementedError();
  } {{/methods}}
}
