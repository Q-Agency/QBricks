# local_auth

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add multipart_request_handler service to your project

## Prerequisites

- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)

## How to use 🚀

```
mason make multipart_request_handler --project_name app
```

## Variables ✨

| Variable       | Description             | Default | Type     |
|----------------|-------------------------|---------|----------|
| `project_name` | The name of the project | app     | `string` |

## Outputs 📦

```
mason make local_auth --project_name app
├── common
      ├── data
            ├── multipart_request_handler
                ├── multipart_request_handler.dart
                ├── multipart_request.dart
                ├── multipart_file_holder.dart
```
