import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:{{project_name.snakeCase()}}/common/data/api_client.dart';
import 'package:{{project_name.snakeCase()}}/common/data/generic_error_resolver.dart';
import 'package:{{project_name.snakeCase()}}/common/data/providers.dart';

final {{name.camelCase()}}Provider = Provider<{{name.pascalCase()}}>((ref) =>
    {{name.pascalCase()}}Impl(
      ref.watch(apiClientProvider),
      {{#dependencies}}ref.watch({{dependencyName.camelCase()}}Provider),{{/dependencies}}
    ));

abstract interface class {{name.pascalCase()}} { {{#methods}}
  EitherFailureOr<{{{type}}}> {{methodName}}({{#parameters}}
    {{{type}}} {{parameterName}},{{/parameters}});
  {{/methods}}
}

class {{name.pascalCase()}}Impl with ErrorToFailureMixin  implements {{name.pascalCase()}}{
  final ApiClient _apiClient;
  {{#dependencies}}final {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  {{name.pascalCase()}}Impl(this._apiClient, {{#dependencies}}this._{{dependencyName.camelCase()}},{{/dependencies}});
  
  {{#methods}}
  @override
  EitherFailureOr<{{{type}}}> {{methodName}}({{#parameters}}
      {{{type}}} {{parameterName}},{{/parameters}}) => execute(
        () async {
          throw UnimplementedError();
        },
        errorResolver: const GenericErrorResolver(),
      ); 
  {{/methods}}
}
