{{#dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/repositories/{{dependencyName.snakeCase()}}.dart';
{{/dependencies}}
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';

final {{name.camelCase()}}Provider = NotifierProvider<{{name.pascalCase()}}, >(() =>
    {{name.pascalCase()}}());

class {{name.pascalCase()}} extends SimpleNotifier<>{
  {{#dependencies}}final {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  @override
   prepareForBuild() {
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
