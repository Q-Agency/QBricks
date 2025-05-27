# Repository

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create your repository with provided dependencies and methods,
together with a test file template

## Prerequisites

Installed version of [get_it](https://pub.dev/packages/get_it)

## How to use 🚀

```
mason make repository --name loginRepository --feature_name login
```

## Variables ✨

| Variable       | Description                | Default         | Type     |
| -------------- | -------------------------- | --------------- | -------- |
| `name`         | The name of the repository | loginRepository | `string` |
| `feature_name` | The name of the feature    | login           | `string` |

## Outputs 📦

```
mason make repository --name loginRepository --feature_name login
├── features
      ├── login
          ├── data
                ├── repositories
                      ├── login_repository.dart
```

## Steps to finish setup

- register your repository with GetIt's registerSingleton() method into your
  service locator
