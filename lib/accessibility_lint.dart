import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'src/rules/add_haptic_feedback_on_user_interaction/add_haptic_feedback_on_user_interaction_rule.dart';
import 'src/rules/avoid_icon_button_without_tooltip/avoid_icon_button_without_tooltip_rule.dart';
import 'src/rules/avoid_icon_without_semantic_label/avoid_icon_without_semantic_label_rule.dart';
import 'src/rules/avoid_image_without_semantic_label/avoid_image_without_semantic_label_rule.dart';
import 'src/rules/avoid_small_interactive_elements/avoid_small_interactive_elements_rule.dart';

PluginBase createPlugin() => _AccessibilityLintPlugin();

class _AccessibilityLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(
    final CustomLintConfigs configs,
  ) =>
      <LintRule>[
        const AvoidIconButtonWithoutTooltipRule(),
        const AvoidImageWithoutSemanticLabelRule(),
        const AvoidIconWithoutSemanticLabelRule(),
        const AvoidSmallInteractiveElementsRule(),
        const AddHapticFeedbackOnUserInteractionRule(),
      ];
}
