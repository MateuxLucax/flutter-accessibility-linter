import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'src/rules/avoid_icon_button_without_tooltip/avoid_icon_button_without_tooltip_rule.dart';

PluginBase createPlugin() => _AccessibilityLintPlugin();

class _AccessibilityLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(
    final CustomLintConfigs configs,
  ) =>
      <LintRule>[
        const AvoidIconButtonWithoutTooltipRule(),
      ];
}
