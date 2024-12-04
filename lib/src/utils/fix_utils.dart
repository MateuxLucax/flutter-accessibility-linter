import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class FixUtils {
  static void addPropertyToReporter(
    final ChangeReporter reporter,
    final String property,
    final InstanceCreationExpression node,
  ) {
    bool haveCommaBeforeEndToken = false;
    if (node.endToken.previous?.lexeme == ',') {
      haveCommaBeforeEndToken = true;
    }

    reporter
        .createChangeBuilder(
      message: 'Add $property property',
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
              builder.write(" $property: '");
            } else {
              builder.write(", $property: '");
            }

            builder
              ..selectHere()
              ..writeln("',");
          },
        );
      },
    );
  }
}
