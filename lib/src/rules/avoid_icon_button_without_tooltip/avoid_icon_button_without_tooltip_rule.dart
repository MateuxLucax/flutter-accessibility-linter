import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'avoid_icon_button_without_tooltip_fix.dart';

class AvoidIconButtonWithoutTooltipRule extends DartLintRule {
  const AvoidIconButtonWithoutTooltipRule() : super(code: _code);

  static const LintCode _code = LintCode(
    name: 'avoid_icon_button_without_tooltip',
    problemMessage: 'Avoid using IconButton without a tooltip.',
    correctionMessage: 'Specify a tooltip for the IconButton widget.',
    errorSeverity: ErrorSeverity.WARNING,
  );

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

      if (constructorName != 'IconButton') return;

      bool hasTooltip = false;
      for (final Expression argument in node.argumentList.arguments) {
        if (argument is! NamedExpression) continue;
        final String name = argument.name.label.name;

        if (name != 'tooltip') continue;

        hasTooltip = true;
        break;
      }

      if (hasTooltip) return;

      reporter.atNode(node, _code);
    });
  }

  @override
  List<Fix> getFixes() => <Fix>[AvoidIconButtonWithoutTooltipFix()];
}
