import 'package:accessibility_lint/src/rules/avoid_icon_button_without_tooltip/avoid_text_without_semantic_fix.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidIconButtonWithoutTooltipRule extends DartLintRule {
  AvoidIconButtonWithoutTooltipRule() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_icon_button_without_tooltip',
    problemMessage: 'Avoid using IconButton without a tooltip.',
    correctionMessage: 'Specify a tooltip for the IconButton widget.',
  );

  @override
  void run(
    final CustomLintResolver resolver,
    final ErrorReporter reporter,
    final CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final constructorName = node.constructorName.type.toString();

      if (constructorName != 'IconButton') return;

      bool hasTooltip = false;
      for (final Expression argument in node.argumentList.arguments) {
        if (argument is NamedExpression) {
          final name = argument.name.label.name;

          if (name == 'tooltip') {
            hasTooltip = true;
            break;
          }
        }
      }

      if (!hasTooltip) {
        reporter.atNode(node, _code);
      }
    });
  }

  @override
  List<Fix> getFixes() {
    return [AvoidIconButtonWithoutTooltipFix()];
  }
}
