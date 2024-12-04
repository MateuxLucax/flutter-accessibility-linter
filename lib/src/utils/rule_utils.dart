import 'package:analyzer/dart/ast/ast.dart';

class RuleUtils {
  static bool hasArgument(
    final NodeList<Expression> arguments,
    final String argumentName,
  ) {
    for (final Expression argument in arguments) {
      if (argument is! NamedExpression) continue;
      final String name = argument.name.label.name;

      if (name != argumentName) continue;

      return true;
    }

    return false;
  }
}
