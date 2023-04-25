import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:{{project_name.snakeCase()}}/common/data/providers.dart';

final {{name.camelCase()}}Provider = Provider<{{name.pascalCase()}}>((ref) =>
    {{name.pascalCase()}}Impl(
      {{#dependencies}}ref.watch({{dependencyName.camelCase()}}Provider),{{/dependencies}}
    ));

abstract class {{name.pascalCase()}} { {{#methods}}
  Future<{{{type}}}> {{methodName}}({{#parameters}}
    {{{type}}} {{parameterName}},{{/parameters}});
  {{/methods}}
}

class {{name.pascalCase()}}Impl implements {{name.pascalCase()}}{
  {{#dependencies}}final {{dependencyName.pascalCase()}} _{{dependencyName.camelCase()}};
  {{/dependencies}}

  const {{name.pascalCase()}}Impl({{#dependencies}}this._{{dependencyName.camelCase()}},{{/dependencies}});
  
  {{#methods}}
  @override
  Future<{{{type}}}> {{methodName}}({{#parameters}}
      {{{type}}} {{parameterName}},{{/parameters}}) async {
    throw UnimplementedError();
  } {{/methods}}
}
