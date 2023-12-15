# Service

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create your service with provided dependencies and methods, together with a test file template

## Prerequisites

Installed version of [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)

## How to use 🚀

```
mason make service --name databaseService
```

## Variables ✨

| Variable       | Description             | Default         | Type      |
|----------------|-------------------------|-----------------| --------- |
| `name`         | The name of the service | databaseService | `string`  |

## Outputs 📦

```
mason make service --name databaseService
├── common
      ├── data
            ├── services
                  ├── database_service.dart
```

```dart
// database_service.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/user.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseServiceImpl());

abstract interface class DatabaseService { 
  Future<void> init();
}

class DatabaseServiceImpl implements DatabaseService{
  DatabaseServiceImpl();
  
  @override
  Future<void> init() async {
    // TODO: - Implement method
  } 
}


// database_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late DatabaseService databaseService;
  
  setUp(() {
    databaseService = DatabaseServiceImpl();
  });
    
  group('init()', () {
    test('executes success flow', () async {
      final value = databaseService.init();
      //expect(value, equals(smth));
    });
    
    test('executes failure flow', () async {
      final value = databaseService.init();
      //expect(value, equals(smth));
    });
  });
}
```