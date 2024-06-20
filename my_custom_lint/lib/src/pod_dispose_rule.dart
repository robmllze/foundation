import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PodDisposeRule extends DartLintRule {
  const PodDisposeRule()
      : super(
          code: const LintCode(
            name: 'pod_dispose_rule',
            problemMessage: 'Instances of Pod must call dispose().',
            correctionMessage: 'Ensure that dispose() is called for each Pod instance.',
          ),
        );

  static final _podInstancesKey = 'podInstances';
  static final _disposeCallsKey = 'disposeCalls';

  @override
  Future<void> startUp(CustomLintResolver resolver, CustomLintContext context) async {
    context.sharedState.putIfAbsent(_podInstancesKey, () => <String, List<int>>{});
    context.sharedState.putIfAbsent(_disposeCallsKey, () => <String, List<int>>{});
  }

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addCompilationUnit((unit) {
      final podInstances = context.sharedState[_podInstancesKey] as Map<String, List<int>>;
      final disposeCalls = context.sharedState[_disposeCallsKey] as Map<String, List<int>>;

      final visitor = _PodVisitor(this, reporter, podInstances, disposeCalls);
      unit.visitChildren(visitor);
    });

    context.addPostRunCallback(() {
      _checkDisposeCalls(context, reporter);
    });
  }

  void _checkDisposeCalls(CustomLintContext context, ErrorReporter reporter) {
    final podInstances = context.sharedState[_podInstancesKey] as Map<String, List<int>>;
    final disposeCalls = context.sharedState[_disposeCallsKey] as Map<String, List<int>>;

    for (var filePath in podInstances.keys) {
      final instances = podInstances[filePath]!;
      final disposes = disposeCalls[filePath] ?? [];

      for (var instanceOffset in instances) {
        bool disposeCalled = false;
        for (var disposeOffset in disposes) {
          if (disposeOffset > instanceOffset) {
            disposeCalled = true;
            break;
          }
        }

        if (!disposeCalled) {
          reporter.reportErrorForOffset(
            code,
            instanceOffset,
            'Pod instance'.length,
          );
        }
      }
    }

    // Clear the state for the next analysis run
    podInstances.clear();
    disposeCalls.clear();
  }
}

class _PodVisitor extends RecursiveAstVisitor<void> {
  final PodDisposeRule rule;
  final ErrorReporter reporter;
  final Map<String, List<int>> podInstances;
  final Map<String, List<int>> disposeCalls;

  _PodVisitor(this.rule, this.reporter, this.podInstances, this.disposeCalls);

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    final initializer = node.initializer;
    if (initializer is InstanceCreationExpression) {
      final type = initializer.constructorName.type.toString();
      final regExp = RegExp(r'Pod(\<\w+\>)?');
      if (regExp.hasMatch(type)) {
        final offset = initializer.offset;
        final filePath =
            node.thisOrAncestorOfType<CompilationUnit>()!.declaredElement!.source.fullName;

        podInstances.putIfAbsent(filePath, () => <int>[]).add(offset);
      }
    }
    super.visitVariableDeclaration(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == 'dispose') {
      final target = node.target;
      if (target is SimpleIdentifier) {
        final filePath =
            node.thisOrAncestorOfType<CompilationUnit>()!.declaredElement!.source.fullName;

        disposeCalls.putIfAbsent(filePath, () => <int>[]).add(node.offset);
      }
    }
    super.visitMethodInvocation(node);
  }
}







// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/dart/ast/visitor.dart';
// import 'package:analyzer/error/listener.dart';
// import 'package:custom_lint_builder/custom_lint_builder.dart';

// class PodDisposeRule extends DartLintRule {
//   const PodDisposeRule()
//       : super(
//             code: const LintCode(
//           name: 'pod_dispose_rule',
//           problemMessage: 'Instances of Pod must call dispose().',
//           correctionMessage: 'Ensure that dispose() is called for each Pod instance.',
//         ));

//   @override
//   void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
//     context.registry.addCompilationUnit((unit) {
//       final visitor = _PodVisitor(this, reporter);
//       unit.visitChildren(visitor);
//     });
//   }
// }

// class _PodVisitor extends RecursiveAstVisitor<void> {
//   final PodDisposeRule rule;
//   final ErrorReporter reporter;

//   _PodVisitor(this.rule, this.reporter);

//   @override
//   void visitInstanceCreationExpression(InstanceCreationExpression node) {
//     final type = node.constructorName.type.toString();
//     final regExp = RegExp(r'Pod(\<\w+\>)?');
//     if (regExp.hasMatch(type)) {
//       // Add logic to check if dispose() is called on this Pod instance
//       _checkDisposeCall(node);
//     }
//     super.visitInstanceCreationExpression(node);
//   }

//   void _checkDisposeCall(InstanceCreationExpression node) {
//     // Traverse the entire unit to find the dispose call
//     final unit = node.thisOrAncestorOfType<CompilationUnit>();

//     if (unit != null) {
//       bool disposeCalled = false;
//       unit.visitChildren(_DisposeChecker(node, (called) {
//         disposeCalled = called;
//       }));

//       if (!disposeCalled) {
//         reporter.reportErrorForNode(rule.code, node);
//       }
//     }
//   }
// }

// class _DisposeChecker extends RecursiveAstVisitor<void> {
//   final InstanceCreationExpression node;
//   final void Function(bool) disposeCallback;

//   _DisposeChecker(this.node, this.disposeCallback);

//   @override
//   void visitMethodInvocation(MethodInvocation invocation) {
//     if (invocation.methodName.name == 'dispose') {
//       final target = invocation.target;
//       if (target is SimpleIdentifier) {
//         final targetName = target.name;
//         final srcName = node.parent?.beginToken.toString();
//         final namesMatch = targetName == srcName;
//         final type = node.constructorName.type.toString();
//         final regExp = RegExp(r'Pod(\<\w+\>)?');
//         final typesMatch = regExp.hasMatch(type);
//         if (namesMatch && typesMatch) {
//           disposeCallback(true);
//         }
//       }
//     }
//     super.visitMethodInvocation(invocation);
//   }
// }
