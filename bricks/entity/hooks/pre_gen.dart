import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;

  if (!logger.confirm(
    '? Do you want to add properties to your entity?',
    defaultValue: true,
  )) {
    context.vars = {
      ...context.vars,
      'hasProperties': false,
    };
    return;
  }

  logger.alert(lightYellow.wrap('enter "e" to exit adding properties'));
  logger.alert('Format: dataType propertyName e.g, String myProperty:');
  final properties = <Map<String, dynamic>>[];

  while (true) {
    final property = logger.prompt(':').replaceAll(RegExp('\\s+'), ' ').trim();
    if (property.toLowerCase() == 'e') {
      break;
    }
    if (!property.contains(' ')) {
      logger.alert(
          'That was not a valid format -> dataType propertyName e.g, String myProperty');
      continue;
    }
    if ((property.contains('<') && !property.contains('>')) ||
        (property.contains('>') && !property.contains('<'))) {
      logger.alert(
          'It seems you are missing a < or >, please retype this property');
      continue;
    }
    final splitProperty = property.split(' ');
    final lastSpaceIndex = property.lastIndexOf(' ');
    final propertyType = property.substring(0, lastSpaceIndex);
    final propertyName = property.substring(lastSpaceIndex + 1);
    final isOptional = propertyType.endsWith('?');
    properties.add({
      'name': propertyName,
      'type': propertyType,
      'isOptional': isOptional,
    });
  }
  context.vars = {
    ...context.vars,
    'properties': properties,
    'hasProperties': properties.isNotEmpty,
  };
}
