# Model

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create your model for a desired feature with properties, and from
json method.

## How to use 🚀

```
mason make model --model_name userResponse --feature_name login
```

## Variables ✨

| Variable       | Description             | Default      | Type     |
| -------------- | ----------------------- | ------------ | -------- |
| `model_name`   | The name of the model   | userResponse | `string` |
| `feature_name` | The name of the feature | login        | `string` |

## Outputs 📦

```
mason make model --model_name userResponse --feature_name login
├── features
      ├── login
          ├── data
                ├── models
                      ├── user_response.dart
```
