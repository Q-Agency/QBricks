import 'package:equatable/equatable.dart';

class {{model_name.pascalCase()}} extends Equatable {
  {{#properties}}
  final {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}} {{name}};{{/properties}}

  const {{model_name.pascalCase()}}({{#hasProperties}}{ {{#properties}}
    {{^isOptional}}required{{/isOptional}} this.{{name}},{{/properties}}
  }{{/hasProperties}});

  
  {{model_name.pascalCase()}} copyWith({{#hasProperties}}{ {{#properties}}
    {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}}{{^isOptional}}?{{/isOptional}} {{name}},{{/properties}}
  }{{/hasProperties}}) {
    return {{model_name.pascalCase()}}({{#properties}}
      {{name}}: {{name}} ?? this.{{name}},{{/properties}}
    );
  }
  @override
  List<Object?> get props => [{{#properties}}
        {{name}},{{/properties}}
      ];
}
