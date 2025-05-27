# QNotifier

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create your q_notifier with provided dependencies and methods

## Prerequisites

Installed version of [get_it](https://pub.dev/packages/get_it)

## How to use 🚀

```
mason make q_notifier --name loginNotifier --feature_name login
```

## Variables ✨

| Variable       | Description                | Default       | Type     |
| -------------- | -------------------------- | ------------- | -------- |
| `project_name` | The name of the project    | app           | `string` |
| `name`         | The name of the q_notifier | loginNotifier | `string` |
| `feature_name` | The name of the feature    | login         | `string` |
| `state`        | The name of the state      |               | `string` |

## Outputs 📦

```
mason make q_notifier --name loginNotifier --feature_name login --state customState
├── features
      ├── login
          ├── domain
                ├── notifiers
                      ├── login_notifier.dart
```

## Steps to finish setup

- register your notifier with GetIt's registerLazySingleton() method with
  dispose parameter into your service locator
