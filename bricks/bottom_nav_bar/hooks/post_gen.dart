import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  Directory directory = Directory.current;
  final list = directory.listSync(recursive: true);
  list.forEach((element) {
    if (element is File && element.path.contains(".gitkeep")) {
      element.delete();
    }
  });
}
