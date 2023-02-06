# multipart_request_handler

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add multipart_request_handler service to your project, as a custom solution for sending multipart file requests.

This brick was created when encountering issues with sending multipart file requests for projects that support both mobile and web. If you donpt have issues with the dio package and don't need detailed control over the request sending, it's better to stick with the dio package. The brick can be used if you want to avoid importing the dio package just for this case, as well.

The web has issues with using files and switching between dart_io & universal_io packages for handling files, therefore the multipart_file_holder serves as a wrapper to provide just a Stream of bytes. We encountered issues with communicating with external SDK on web as well, where optionaly some custom tweaking of the request can be needed.

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
mason make multipart_request_handler --project_name app
├── common
      ├── data
            ├── multipart_request_handler
                ├── multipart_request_handler.dart
                ├── multipart_request.dart
                ├── multipart_file_holder.dart
```
