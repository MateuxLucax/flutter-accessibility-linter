import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AddHapticFeedbackOnUserInteractionRule extends DartLintRule {
  const AddHapticFeedbackOnUserInteractionRule() : super(code: _code);

  static const LintCode _code = LintCode(
    name: 'add_haptic_feedback_on_user_interaction',
    problemMessage: 'Add haptic feedback on user interaction.',
    correctionMessage:
        'Add haptic feedback to provide a tactile response to user interactions.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const List<String> interactiveElements = <String>[
    'IconButton',
    'FloatingActionButton',
    'ElevatedButton',
    'TextButton',
  ];

  static final RegExp hapticFeedbackRegex = RegExp(r'\bHapticFeedback');

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

      final NamedExpression onPressedArgument =
          node.argumentList.arguments.whereType<NamedExpression>().firstWhere(
                (final NamedExpression arg) =>
                    arg.name.label.name == 'onPressed',
              );

      final Expression onPressedExpression = onPressedArgument.expression;

      final String onPressedSource = onPressedExpression.toSource();

      if (!hapticFeedbackRegex.hasMatch(onPressedSource)) {
        reporter.atNode(node, _code);
      }
    });
  }
}
