import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:my_custom_lint/src/pod_dispose_rule.dart';
import 'src/my_custom_rule.dart';

PluginBase createPlugin() => _CustomLintPlugin();

class _CustomLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      const MyCustomLint(),
      const PodDisposeRule(),
    ];
  }
}
