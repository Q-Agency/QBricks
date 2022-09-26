# file_picker

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add file_picker feature to your project

## Prerequisites

- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)
- [file_picker](https://pub.dev/packages/file_picker)

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
mason make file_picker --project_name app
├── features
      ├── file_picker
          ├── data
                ├── repositories
                      ├── file_picker_repository.dart
```
