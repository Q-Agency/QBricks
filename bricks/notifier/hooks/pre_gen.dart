import 'package:mason/mason.dart';

void run(HookContext context) async {
  final logger = context.logger;

  if (logger.confirm(
    '? Do you want to add dependencies to your notifier?',
    defaultValue: true,
  )) {
    logger.alert(lightYellow.wrap('enter "e" to exit adding dependencies'));
    logger.alert('Format: dependencyName');
    final dependencies = <Map<String, dynamic>>[];
    while (true) {
      final dependency =
          logger.prompt(':').replaceAll(RegExp('\\s+'), ' ').trim();
      if (dependency.toLowerCase() == 'e') {
        break;
      }
      if (dependency.contains(' ')) {
        logger.alert(
            'That was not a valid format, no spaces just the name -> dependencyName');
        continue;
      }
      if (dependency == '' || dependency == '\n' || dependency.length == 1) {
        continue;
      }
      dependencies.add({'dependencyName': dependency});
    }
    context.vars = {
      ...context.vars,
      'dependencies': dependencies,
    };
  }
  if (!logger.confirm(
    '? Do you want to add methods to your notifier?',
    defaultValue: true,
  )) {
    return;
  }
  logger.alert(lightYellow.wrap('enter "e" to exit adding methods'));
  logger.alert(
      'Format: returnType methodName(returnType name, ...) e.g, String myMethod():');

  final methods = <Map<String, dynamic>>[];
  while (true) {
    final method = logger.prompt(':').replaceAll(RegExp('\\s+'), ' ').trim();
    if (method.toLowerCase() == 'e') {
      break;
    }
    if (!method.contains(' ')) {
      logger.alert(
          'That was not a valid format -> returnType methodName e.g, String myMethod()');
      continue;
    }
    final index = method.indexOf(' ');
    final propertyType = method.substring(0, index);
    final propertyName = method.substring(index);
    if (!propertyName.toLowerCase().contains('(') ||
        !propertyName.toLowerCase().contains(')')) {
      logger.alert(
          'That was not a valid method format -> method must have () and optionally parameters inside');
      continue;
    }
    methods.add({
      'methodName': propertyName,
      'type': propertyType,
    });
  }
  context.vars = {
    ...context.vars,
    'methods': methods,
  };
}
