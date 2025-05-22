{{#dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/repositories/{{dependencyName.snakeCase()}}.dart';
{{/dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/notifiers/{{state.snakeCase()}}.dart';
import 'package:q_architecture/q_architecture.dart';

class {{name.pascalCase()}} extends QNotifier<{{state.pascalCase()}}>{
  {{#dependencies}}final {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  {{name.pascalCase()}}(
    {{#dependencies}}
    this._{{dependencyName.camelCase()}},
    {{/dependencies}}
    {super.autoDispose}
  ): super({{state.pascalCase()}});
  
  {{#methods}}
  Future<{{{type}}}> {{methodName}}({{#parameters}}
      {{{type}}} {{parameterName}},{{/parameters}}) async {
    throw UnimplementedError();
  } {{/methods}}
}
