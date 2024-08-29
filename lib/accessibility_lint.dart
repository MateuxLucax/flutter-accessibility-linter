import 'package:accessibility_lint/src/rules/avoid_icon_button_without_tooltip/avoid_text_without_semantic_rule.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _AccessibilityLintPlugin();

class _AccessibilityLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [AvoidIconButtonWithoutTooltipRule()];
  }
}
