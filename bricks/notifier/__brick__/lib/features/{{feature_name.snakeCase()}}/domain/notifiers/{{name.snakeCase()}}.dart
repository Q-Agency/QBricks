import 'package:hooks_riverpod/hooks_riverpod.dart';
{{#dependencies}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/repositories/{{dependencyName.snakeCase()}}.dart';
{{/dependencies}}
import 'package:{{project_name.snakeCase()}}/common/domain/notifiers/base_state_notifier.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/notifiers/base_state.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';


final {{name.camelCase()}}Provider = BaseStateNotifierProvider<{{name.pascalCase()}}, {{entity.pascalCase()}}>((ref) {
  return {{name.pascalCase()}}(
      {{#dependencies}}ref.watch({{dependencyName.camelCase()}}Provider),{{/dependencies}} ref,
  );
});

class {{name.pascalCase()}} extends BaseStateNotifier<{{entity.pascalCase()}}>{
  {{#dependencies}}final {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  {{name.pascalCase()}}({{#dependencies}}this._{{dependencyName.camelCase()}},{{/dependencies}} super.ref);
  
  {{#methods}}
  Future<{{type}}> {{methodName}} async {
    throw UnimplementedError();
  } {{/methods}}
}
