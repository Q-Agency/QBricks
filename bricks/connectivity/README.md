# connectivity

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add connectivity feature to your project

## Prerequisites

- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)
- [connectivity_plus](https://pub.dev/packages/connectivity_plus)

## How to use 🚀

```
mason make connectivity --project_name app
```

## Variables ✨

| Variable       | Description             | Default | Type     |
|----------------|-------------------------|---------|----------|
| `project_name` | The name of the project | app     | `string` |

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
                      ├── connection_status.dart
```

## Steps to finish setup
- add `ref.globalConnectivityListener();` in the widget where you want to listen for connection changes