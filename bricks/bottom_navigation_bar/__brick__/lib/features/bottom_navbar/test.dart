{{^navbar}}// For testing replace this code inside base_router_provider.dart 

//if (routeInformation.location!.contains('counter')) {
//  return CounterLocation(routeInformation);
//} else if ({{#tabs}}routeInformation.location!.endsWith('{{name.snakeCase()}}') {{^isLast}}||{{/isLast}} {{/tabs}}) {
//return BottomNavbarLocation(routeInformation);}


// Put this code inside example_page.dart
// TextButton(
//  onPressed: () => ref.pushNamed({{#tabs}}{{#isFirst}}{{name.pascalCase()}}{{/isFirst}}{{/tabs}}Page.routeName),
//  child: const Text('Login'),
//),
{{/navbar}}{{#navbar}}
// For testing replace this code inside locationBuilder in base_router_provider.dart 

//if ({{#tabs}}routeInformation.location!.contains('{{name.snakeCase()}}') {{^isLast}}||{{/isLast}} {{/tabs}}) {
//  return BottomNavbarLocation(routeInformation);
//} 

// Put this code inside example_page.dart
// TextButton(
//  onPressed: () => ref.pushNamed({{#tabs}}{{#isFirst}}{{name.pascalCase()}}{{/isFirst}}{{/tabs}}Page.routeName),
//  child: const Text('Login'),
//),
{{/navbar}}


