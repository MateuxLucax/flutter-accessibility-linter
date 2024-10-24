# Accessibility Lint

[![License: Apache License 2.0](https://img.shields.io/badge/license-Apache%202.0-blue?style=flat-square)](LICENSE)

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

A static analysis linter that helps developers create accessible Dart and Flutter applications by enforcing best practices for accessibility.

## Features
- **Avoid Icon Button Without Tooltip**: Ensures all `IconButton` widgets have a `tooltip` property.

## Installation

To add the accessibility linter to your project, run:

```bash
flutter pub add --dev custom_lint accessibility_lint
```

Then, add in your `analysis_options.yaml` file:

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Usage

To run the accessibility linter, run:

```bash
dart run custom_lint
```

## License

This project is licensed under the GNU GPL License - see the [LICENSE](LICENSE) file for details.
