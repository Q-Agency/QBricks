import 'package:mason/mason.dart';

void run(HookContext context) async {
  final logger = context.logger;

  if (logger.confirm(
    '? Do you want to add dependencies to your repository?\nNOTE: apiClient is automatically added as a dependency.',
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
    '? Do you want to add methods to your repository?\nNOTE: All repository methods have EitherFailureOr<Type> return type',
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
    var propertyType = method.substring(0, index);
    final propertyName = method.substring(index);
    if (!propertyName.toLowerCase().contains('(') ||
        !propertyName.toLowerCase().contains(')')) {
      logger.alert(
          'That was not a valid method format -> method must have () and optionally parameters inside');
      continue;
    }
    final isOptional = propertyType.endsWith('?');
    if (isOptional) {
      propertyType = propertyType.substring(0, propertyType.length - 1);
    }
    final isList = propertyType.toLowerCase().contains('<') ||
        propertyType.toLowerCase().contains('>') &&
            propertyType.contains('List');
    String? listType = null;
    bool listTypeOptional = false;
    if (isList) {
      final startIndex = propertyType.indexOf('<');
      final endIndex = propertyType.indexOf('>');
      listType = propertyType.substring(startIndex + 1, endIndex).trim();
      listTypeOptional = listType.endsWith('?');
      if (listTypeOptional) {
        listType = listType.substring(0, listType.length - 1);
      }
    }
    methods.add({
      'methodName': propertyName,
      'type': propertyType,
      'isOptional': isOptional,
      'isList': isList,
      'listType': listType,
    });
  }
  context.vars = {
    ...context.vars,
    'methods': methods,
  };
}
