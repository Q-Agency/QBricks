import 'package:hooks_riverpod/hooks_riverpod.dart';
{{#methods}}
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/entities/{{#isList}}{{{listType.snakeCase()}}}{{/isList}}{{^isList}}{{{type.snakeCase()}}}{{/isList}}.dart';
{{/methods}}
import 'package:{{project_name.snakeCase()}}/common/data/api_client.dart';
import 'package:{{project_name.snakeCase()}}/common/data/providers.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/either_failure_or.dart';

final {{name.camelCase()}}Provider = Provider<{{name.pascalCase()}}>((ref) {
  return {{name.pascalCase()}}Impl(
      ref.watch(apiClientProvider),
      {{#dependencies}}ref.watch({{dependencyName.camelCase()}}Provider),{{/dependencies}}
  );
});

abstract class {{name.pascalCase()}} { {{#methods}}
  EitherFailureOr<{{{type}}}{{#isOptional}}?{{/isOptional}}> {{methodName}};
  {{/methods}}
}

class {{name.pascalCase()}}Impl implements {{name.pascalCase()}}{
  final ApiClient _apiClient;
  {{#dependencies}}final {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  {{name.pascalCase()}}Impl(this._apiClient, {{#dependencies}}this._{{dependencyName.camelCase()}},{{/dependencies}});
  
  {{#methods}}
  @override
  EitherFailureOr<{{{type}}}{{#isOptional}}?{{/isOptional}}> {{methodName}} async {
    throw UnimplementedError();
  } {{/methods}}
}
