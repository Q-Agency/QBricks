# Page

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create your page

## Prerequisites

Installed version of [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)

## How to use 🚀

```
mason make page --name login --feature_name login
```

## Variables ✨

| Variable       | Description             | Default | Type      |
|----------------|-------------------------|---------| --------- |
| `name`         | The name of the page    | login   | `string`  |
| `feature_name` | The name of the feature | login   | `string`  |

## Outputs 📦

```
mason make page --name login --feature_name login
├── features
      ├── login
          ├── presentation
                ├── pages
                      ├── login_page.dart
```

```dart
// login_page.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerWidget {
    const LoginPage({super.key});
    
    @override 
    Widget build(BuildContext context, WidgetRef ref) {
      return const Scaffold(
        body: Placeholder(),
      );
    }
}
```