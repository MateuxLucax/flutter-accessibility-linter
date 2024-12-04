import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/rule_utils.dart';
import 'avoid_image_without_semantic_label_fix.dart';

class AvoidImageWithoutSemanticLabelRule extends DartLintRule {
  const AvoidImageWithoutSemanticLabelRule() : super(code: _code);

  static const LintCode _code = LintCode(
    name: 'avoid_image_without_semantic_label',
    problemMessage: 'Avoid using images without a semantic label.',
    correctionMessage: 'Specify a semantic label for the image widget.',
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

      if (constructorName != 'Image') return;

      final bool hasSemanticLabel = RuleUtils.hasArgument(
        node.argumentList.arguments,
        'semanticLabel',
      );

      if (hasSemanticLabel) return;

      reporter.atNode(node, _code);
    });
  }

  @override
  List<Fix> getFixes() => <Fix>[AvoidImageWithoutSemanticLabelFix()];
}
