# url_launcher

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add url_launcher feature to your project

## Prerequisites

- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)
- [url_launcher](https://pub.dev/packages/url_launcher)

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
mason make url_launcher --project_name app
├── features
      ├── url_launcher
          ├── data
                ├── repositories
                      ├── url_launcher_repository.dart
```
