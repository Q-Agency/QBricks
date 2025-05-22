# Service

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create your service with provided dependencies and methods, together
with a test file template

## How to use 🚀

```
mason make service --name databaseService
```

## Variables ✨

| Variable | Description             | Default         | Type     |
| -------- | ----------------------- | --------------- | -------- |
| `name`   | The name of the service | databaseService | `string` |

## Outputs 📦

```
mason make service --name databaseService
├── common
      ├── data
            ├── services
                  ├── database_service.dart
```

## Steps to finish setup

- register your service with GetIt's registerSingleton() method into your
  service locator
