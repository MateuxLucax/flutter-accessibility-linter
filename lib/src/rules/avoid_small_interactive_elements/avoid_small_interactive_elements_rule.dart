import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidSmallInteractiveElementsRule extends DartLintRule {
  const AvoidSmallInteractiveElementsRule() : super(code: _code);

  static const LintCode _code = LintCode(
    name: 'avoid_small_interactive_elements',
    problemMessage: 'Avoid using small interactive elements.',
    correctionMessage:
        'Interactive elements should have at least 48pt in width and height.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const List<String> interactiveElements = <String>[
    'IconButton',
    'FloatingActionButton',
    'ElevatedButton',
    'TextButton',
  ];

  static const List<String> validContainers = <String>[
    'SizedBox',
    'Container',
  ];

  static const double minimumSize = 48;

  @override
  void run(
    final CustomLintResolver resolver,
    final ErrorReporter reporter,
    final CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((
      final InstanceCreationExpression node,
    ) {
      final String constructorName = node.constructorName.type.toString();

      if (!interactiveElements.contains(constructorName)) return;

      AstNode? parentNode = node.parent;

      while (parentNode != null && parentNode is! InstanceCreationExpression) {
        parentNode = parentNode.parent;
      }

      if (parentNode == null) return;
      if (parentNode is! InstanceCreationExpression) return;

      final String parentConstructorName =
          parentNode.constructorName.type.toString();

      if (!validContainers.contains(parentConstructorName)) {
        reporter.atNode(node, _code);
        return;
      }

      final double width = double.tryParse(
            _getArgumentValue(
              parentNode.argumentList.arguments,
              'width',
            ),
          ) ??
          0;

      final double height = double.tryParse(
            _getArgumentValue(
              parentNode.argumentList.arguments,
              'height',
            ),
          ) ??
          0;

      if (width >= minimumSize && height >= minimumSize) return;

      reporter.atNode(node, _code);
    });
  }

  static dynamic _getArgumentValue(
    final NodeList<Expression> arguments,
    final String argumentName,
  ) {
    for (final Expression argument in arguments) {
      if (argument is! NamedExpression) continue;
      final String name = argument.name.label.name;

      if (name != argumentName) continue;

      return argument.expression.endToken.value();
    }

    return null;
  }
}
