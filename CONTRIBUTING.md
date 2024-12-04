# Contributing

This project was laid out in a way that makes it easy to contribute. Here are some guidelines to follow:

1. Fork the repository
2. Follow the [Naming conventions](#naming-conventions) for new rules
3. Add your rule to the `lib/src/rules` directory
4. Add your rule to the `lib/src/accessibility_lint.dart` file
5. Add a valid test on the `example/lib/main.dart` file (You can reference the other rules)
6. Add the rule to the `README.md` features section

## Naming conventions

- The rule name should be in `snake_case`
- The rule name should start with `avoid_` or `add_`
- The rule name should be descriptive
- The rule name should be in English

## Opening a Pull Request

After you have added your rule, open a pull request with the following information:

1. The rule name
2. The rule description
3. Why the rule is important
4. An example of the rule in action
5. The rule severity

You can use this template:

<pre lang="md">
## Rule name

- **Description**: A brief description of the rule

- **Why it's important**: Why this rule is important

- **Example**:

```dart
// expect_lint: avoid_icon_button_without_tooltip
IconButton(
  icon: Icon(Icons.add),
  onPressed: () {},
)
```

- **Severity**: `Severity.warning` or `Severity.error`
</pre>

## Testing

To test your rule, run the following command:

```bash
dart pub run custom_lint
```