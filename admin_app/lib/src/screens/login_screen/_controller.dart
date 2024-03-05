//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// X|Y|Z & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

part of 'login_screen.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class LoginScreenController extends TLoginScreenController {
  //
  //
  //

  LoginScreenController(super.screen, super.state);

  //
  //
  //

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //
  //
  //

  Future<void> logInWithEmailAndPassword() async {
    await app.serviceEnvironment.authServiceBroker.logInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    // final context = this.state.context;
    // late void Function() removeOverlay;
    // showAppLogoOverlay(
    //   context,
    //   remover: (r) {
    //     removeOverlay = r;
    //     app.routeManager.pScreenBreadcrumbs.addSingleExecutionListener(r);
    //   },
    // );
    // try {
    //   await app.serviceEnvironment.authServiceBroker.logInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    // } catch (e) {
    //   removeOverlay();

    //   if (context.mounted) {
    //     showErrorToastOverlay(
    //       context,
    //       error: "$e",
    //       remover: (r) => Future.delayed(const Duration(seconds: 3), r),
    //     );
    //   }
    // }
  }

  //
  //
  //

  Future<void> forgotPassword() async {
    await showOverlay(
      this.state.context,
      builder: (context, remove) {
        return MyEmailResetDialogBody(
          emailController: emailController,
          onCancel: remove,
          onSend: (email) async {
            await app.serviceEnvironment.authServiceBroker.sendPasswordResetEmail(
              email: email,
            );
          },
        );
      },
    );
  }

  //
  //
  //

  @override
  void dispose() {
    this.emailController.dispose();
    this.passwordController.dispose();
    super.dispose();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension LoginScreenControllerExtension on LoginScreenController {
  // Tip: You can break up your controller into multiple files using extensions.
}
