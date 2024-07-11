{{#dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/repositories/{{dependencyName.snakeCase()}}.dart';
{{/dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/notifiers/{{state.snakeCase()}}.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final {{name.camelCase()}}Provider = NotifierProvider<{{name.pascalCase()}}, {{state.pascalCase()}}>(() =>
    {{name.pascalCase()}}());

class {{name.pascalCase()}} extends SimpleNotifier<{{state.pascalCase()}}>{
  {{#dependencies}}late {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  @override
  {{state.pascalCase()}} prepareForBuild() {
  {{#dependencies}}
    _{{dependencyName.camelCase()}} = ref.watch({{dependencyName.camelCase()}}Provider);
  {{/dependencies}}
  return ;
  }
  
  {{#methods}}
  Future<{{{type}}}> {{methodName}}({{#parameters}}
      {{{type}}} {{parameterName}},{{/parameters}}) async {
    throw UnimplementedError();
  } {{/methods}}
}
