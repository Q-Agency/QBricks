import 'package:mason/mason.dart';

void run(HookContext context) async {
  final logger = context.logger;

  if (logger.confirm(
    '? Do you want to add dependencies to your simple_notifier?',
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
    '? Do you want to add methods to your simple_notifier?',
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
    if (!method.contains(' ') ||
        method.contains('(') ||
        method.split(' ').length < 2) {
      logger.alert(
          'That was not a valid format -> returnType methodName e.g, String myMethod');
      continue;
    }
    final splitProperty = method.split(' ');
    final propertyType = splitProperty[0];
    final propertyName = splitProperty[1];

    final parameters = <Map<String, dynamic>>[];
    if (logger.confirm(
      '? Method has parameters?',
      defaultValue: true,
    )) {
      logger.alert(lightYellow.wrap('enter "e" to exit adding parameters'));
      logger.alert('Parameters: Type parameterName:');
      while (true) {
        final parameter =
            logger.prompt(':').replaceAll(RegExp('\\s+'), ' ').trim();
        if (parameter.toLowerCase() == 'e') {
          break;
        }
        final splitProperty = parameter.split(' ');
        final parameterType = splitProperty[0];
        final parameterName = splitProperty[1];

        parameters.add({
          'parameterName': parameterName,
          'type': parameterType,
        });
      }
    }
    logger.alert('Added method! More methods? enter \'e\' to to finish');

    methods.add({
      'methodName': propertyName,
      'type': propertyType,
      'parameters': parameters,
    });
  }
  context.vars = {
    ...context.vars,
    'methods': methods,
  };
}
