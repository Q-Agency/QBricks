# url_launcher

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add url_launcher feature to your project

## Prerequisites

- [url_launcher](https://pub.dev/packages/url_launcher)

## How to use 🚀

```
mason make url_launcher
```

## Outputs 📦

```
mason make url_launcher
├── common
      ├── data
          ├── repositories
                ├── url_launcher_repository.dart
```

## Steps to finish setup

- register your UrlLauncherRepository with GetIt's registerSingleton() method
  into your service locator
