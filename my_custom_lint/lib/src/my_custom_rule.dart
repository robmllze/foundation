// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class MyCustomLint extends DartLintRule {
  const MyCustomLint()
      : super(
            code: const LintCode(
          name: 'my_custom_rule',
          problemMessage: 'Method name should not start with an underscore.',
          correctionMessage: 'Remove the underscore from the method name.',
        ));

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    // Use the resolver to get the resolved unit
    context.registry.addFunctionDeclaration((node) {
      if (node.name.toString().startsWith('_')) {
        //reporter.atNode(node, code);
        reporter.reportErrorForNode(code, node);
      }
      // final visitor = _Visitor(this, reporter);
      // unit.visitChildren(visitor);
    });
  }
}

// class _Visitor extends RecursiveAstVisitor<void> {
//   final MyCustomLint rule;
//   final ErrorReporter reporter;

//   _Visitor(this.rule, this.reporter);

//   @override
//   void visitMethodDeclaration(MethodDeclaration node) {
//     if (node.name.toString().startsWith('_')) {
//       reporter.atNode(node, rule.code);
//     }
//   }
// }
