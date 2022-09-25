# connectivity

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add connectivity feature to your project

## Prerequisites

Installed version of [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)

## How to use 🚀

```
mason make connectivity --project_name app
```

## Variables ✨

| Variable         | Description                      | Default         | Type      |
| ---------------- | -------------------------------- | --------------- | --------- |
| `project_name`   | The name of the project          | app             | `string`  |

## Outputs 📦

```
mason make connectivity --project_name app
├── features
      ├── connectivity
          ├── domain
                ├── notifiers
                      ├── connectivity_notifier.dart
                ├── utils
                      ├── connectivity_extensions.dart
```

## Steps to finish setup
- add connectivity_plus package to your project's pubspec.yaml
- add `ref.globalConnectivityListener();` in the widget where you want to listen for connection changes