import 'package:analyzer/error/error.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidIconButtonWithoutTooltipFix extends DartFix {
  @override
  void run(
    final CustomLintResolver resolver,
    final ChangeReporter reporter,
    final CustomLintContext context,
    final AnalysisError analysisError,
    final List<AnalysisError> others,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

      final constructorName = node.constructorName.type.toString();

      if (constructorName != 'IconButton') return;

      bool haveCommaBeforeEndToken = false;
      if (node.endToken.previous?.lexeme == ',') {
        haveCommaBeforeEndToken = true;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add tooltip proprty',
        priority: 0,
      );

      changeBuilder.addDartFileEdit((builder) {
        final offset = node.endToken.offset - 1;

        builder.addInsertion(
          offset,
          (builder) {
            if (haveCommaBeforeEndToken) {
              builder.write(' tooltip: \'');
            } else {
              builder.write(', tooltip: \'');
            }

            builder.selectHere();
            builder.writeln('\',');
          },
        );
      });
    });
  }
}
