import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;
  final int choosenNavbar =
      context.vars.entries.elementAt(1).value == 'PERSISTENT' ? 1 : 2;
  final int numberOfTabs = int.parse(context.vars.entries.elementAt(2).value);

  if (numberOfTabs < 2) {
    logger.alert("Number of tabs can't be less then 2!!!");
    exit(0);
  } else if (numberOfTabs > 6) {
    logger.alert("Number of tabs can't be greater then 6!!!");
    exit(0);
  }

  logger.info(
      'Write name of $numberOfTabs tabs in lowercase. Click enter after each one.');

  final tabs = <Map<String, dynamic>>[];

  while (true && tabs.length < numberOfTabs) {
    final property = logger
        .prompt('${tabs.length + 1}. tab: ')
        .replaceAll(RegExp('\\s+'), ' ')
        .trim();

    tabs.add({
      'name': property,
      'indexAt': tabs.length,
      'isFirst': tabs.length == 0,
      'isLast': (tabs.length == numberOfTabs - 1),
    });
  }

  context.vars = {
    ...context.vars,
    'tabs': tabs,
    'navbar': choosenNavbar == 1 ? true : false,
  };
  print(context.vars.entries.toList());
}
