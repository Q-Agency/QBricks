import 'package:json_annotation/json_annotation.dart';

part '{{model_name.snakeCase()}}.g.dart';

@JsonSerializable()
class {{model_name.pascalCase()}} {
  {{#properties}}
  final {{{type}}} {{name}};{{/properties}}
  
  const {{model_name.pascalCase()}}({{#hasProperties}}{ {{#properties}}
    {{^isOptional}}required{{/isOptional}} this.{{name}},{{/properties}}
  }{{/hasProperties}});

  factory {{model_name.pascalCase()}}.fromJson(Map<String, dynamic> json) => _${{model_name.pascalCase()}}FromJson(json);

  Map<String, dynamic> toJson() => _${{model_name.pascalCase()}}ToJson(this);
}
