import 'package:analyzer/error/error.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
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
    context.registry.addInstanceCreationExpression(
      (final InstanceCreationExpression node) {
        if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

        final String constructorName = node.constructorName.type.toString();

        if (constructorName != 'IconButton') return;

        bool haveCommaBeforeEndToken = false;
        if (node.endToken.previous?.lexeme == ',') {
          haveCommaBeforeEndToken = true;
        }

        reporter
            .createChangeBuilder(
          message: 'Add tooltip proprty',
          priority: 0,
        )
            .addDartFileEdit(
          (
            final DartFileEditBuilder builder,
          ) {
            final int offset = node.endToken.offset - 1;

            builder.addInsertion(
              offset,
              (final DartEditBuilder builder) {
                if (haveCommaBeforeEndToken) {
                  builder.write(" tooltip: '");
                } else {
                  builder.write(", tooltip: '");
                }

                builder
                  ..selectHere()
                  ..writeln("',");
              },
            );
          },
        );
      },
    );
  }
}
