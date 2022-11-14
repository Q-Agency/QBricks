import 'package:freezed_annotation/freezed_annotation.dart';

part '{{model_name.snakeCase()}}.g.dart';

@JsonSerializable()
class {{model_name.pascalCase()}} {
  {{#properties}}
  final {{#hasSpecial}}{{{type}}}{{/hasSpecial}}{{^hasSpecial}}{{type}}{{/hasSpecial}} {{name}};{{/properties}}
  
  const {{model_name.pascalCase()}}({{#hasProperties}}{ {{#properties}}
    required this.{{name}},{{/properties}}
  }{{/hasProperties}});

  factory {{model_name.pascalCase()}}.fromJson(Map<String, dynamic> json) => _${{model_name.pascalCase()}}FromJson(json);
}
