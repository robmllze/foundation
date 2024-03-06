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

class _View extends TSignUpScreenView {
  //
  //
  //

  @override
  Widget layout(Widget body) {
    return super.layout(
      Column(
        children: [
          MyHeaderBackButton(
            onBackButtonPressed: () =>
                app.routeManager.go(WelcomeScreenConfiguration()),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.sc),
                  child: body,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  //
  //

  @override
  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Sign Up||title".screenTr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 24.sc),
        TextField(
          decoration: InputDecoration(
            labelText: "Name||name".screenTr(),
            border: const OutlineInputBorder(),
          ),
          controller: this.c.nameController,
        ),
        SizedBox(height: 16.sc),
        TextField(
          decoration: InputDecoration(
            labelText: "Email||email".screenTr(),
            border: const OutlineInputBorder(),
          ),
          controller: this.c.emailController,
        ),
        SizedBox(height: 16.sc),
        TextField(
          decoration: InputDecoration(
            labelText: "Password||password".screenTr(),
            border: const OutlineInputBorder(),
          ),
          obscureText: true,
          controller: this.c.passwordController,
          onSubmitted: (_) => this.c.signUpWithEmailAndPassword(),
        ),
        SizedBox(height: 32.sc),
        FilledButton(
          onPressed: this.c.signUpWithEmailAndPassword,
          child: Text("Sign Up||sign_up".screenTr()),
        ),
        SizedBox(height: 12.sc),
        TextButton(
          onPressed: () => app.routeManager.go(LoginScreenConfiguration()),
          child: Text("Or Log In||or_log_in".screenTr()),
        ),
      ],
    );
  }
}
