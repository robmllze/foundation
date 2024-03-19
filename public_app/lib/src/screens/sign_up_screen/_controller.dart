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

part of 'sign_up_screen.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class SignUpScreenController extends TSignUpScreenController {
  //
  //
  //

  SignUpScreenController(super.screen, super.state);

  //
  //
  //

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //
  //
  //

  Future<void> signUpWithEmailAndPassword() async {
    final context = this.state.context;
    late void Function() removeOverlay;
    showSpinningAppIconOverlay(
      context,
      remover: (r) {
        removeOverlay = r;
        G.app.routeManager.pScreenBreadcrumbs.addSingleExecutionListener(r);
      },
    );
    try {
      await G.app.serviceEnvironment.authServiceBroker.signUpWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await this._createAndWriteNewUserData(
        displayName: nameController.text,
        email: emailController.text,
        userId: G.app.serviceEnvironment.authServiceBroker.pCurrentUser.value!.userId,
      );
    } catch (e) {
      removeOverlay();
      if (context.mounted) {
        showErrorToastOverlay(
          context,
          error: "$e",
          remover: (r) => Future.delayed(const Duration(seconds: 3), r),
        );
      }
    }
  }

  //
  //
  //

  Future<void> _createAndWriteNewUserData({
    required String displayName,
    required String email,
    required String userId,
  }) async {
    final userPubId = IdUtils.mapUserIdToPubId(userId: userId);
    await G.app.serviceEnvironment.databaseServiceBroker.batchWrite([
      BatchWriteOperation(
        Schema.usersRef(userId: userId),
        model: ModelUser(
          id: userId,
          userPubId: userPubId,
        ),
      ),
      BatchWriteOperation(
        Schema.userPubsRef(userPubId: userPubId),
        model: ModelUserPub(
          id: userPubId,
          userId: userId,
          displayName: displayName,
          displayNameSearchable: displayName.toLowerCase(),
          emailSearchable: email.toLowerCase(),
        ),
      ),
    ]);
  }

  //
  //
  //

  @override
  void dispose() {
    this.nameController.dispose();
    this.emailController.dispose();
    this.passwordController.dispose();
    super.dispose();
  }
}
