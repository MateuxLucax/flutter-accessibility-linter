import 'package:analyzer/error/error.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../../utils/fix_utils.dart';

class AvoidIconButtonWithoutTooltipFix extends DartFix {
  @override
  void run(
    final CustomLintResolver resolver,
    final ChangeReporter reporter,
    final CustomLintContext context,
    final AnalysisError analysisError,
    final List<AnalysisError> others,
  ) {
    context.registry.addInstanceCreationExpression(
      (final InstanceCreationExpression node) {
        if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

        final String constructorName = node.constructorName.type.toString();

        if (constructorName != 'IconButton') return;

        FixUtils.addPropertyToReporter(
          reporter,
          'tooltip',
          node,
        );
      },
    );
  }
}
