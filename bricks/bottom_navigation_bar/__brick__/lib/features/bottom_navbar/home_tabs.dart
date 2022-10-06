import 'package:flutter/material.dart';

{{#tabs}}
import 'package:{{project_name.snakeCase()}}/features/{{name.snakeCase()}}/presentation/pages/{{name.snakeCase()}}_page.dart'; {{/tabs}}

enum HomeTabs {
  {{#tabs}}
  {{name.camelCase()}}, {{/tabs}}
}

extension HomeTabExtension on HomeTabs {

  static final tabImagesPath = {
  {{#tabs}}
  HomeTabs.{{name.camelCase()}}: Icons.home,
  {{/tabs}}
  };

  static final tabTitle = {
   {{#tabs}}
   HomeTabs.{{name.camelCase()}}:'{{name.sentenceCase()}}', {{/tabs}}
  };

  static final tabRoute = {
     {{#tabs}}
     HomeTabs.{{name.camelCase()}}: {{name.pascalCase()}}Page.routeName, {{/tabs}}
  };

  static final snakeCaseTitle = {
    {{#tabs}}
    HomeTabs.{{name.camelCase()}}: '/{{name.snakeCase()}}', {{/tabs}}
  };


  String getTabTitle() => tabTitle[this]!;

  String getTabRoute() => tabRoute[this]!;

  IconData getImagePath() => tabImagesPath[this]!;

  String getSnakeCaseTitle() => snakeCaseTitle[this]!;

}
