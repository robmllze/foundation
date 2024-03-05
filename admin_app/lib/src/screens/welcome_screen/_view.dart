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

part of 'welcome_screen.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _View extends TWelcomeScreenView {
  //
  //
  //

  @override
  Widget layout(Widget body) {
    return super.layout(
      Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 60.sc,
              left: 20.sc,
              right: 20.sc,
            ),
            child: body,
          ),
        ),
      ),
    );
  }

  //
  //
  //

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "$VIEW_IMAGES_PATH/logo.svg",
          width: 200.sc,
          height: 200.sc,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 12.sc),
        Text(
          "Welcome to JobXcel||welcome".screenTr(),
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        SizedBox(height: 32.sc),
        Wrap(
          spacing: 12.sc,
          runSpacing: 12.sc,
          children: [
            FilledButton(
              onPressed: () => app.routeManager.go(LoginScreenConfiguration()),
              child: SizedBox(
                width: 80.sc,
                child: Center(child: Text("Log In||log_in".screenTr())),
              ),
            ),
            FilledButton(
              onPressed: () => app.routeManager.go(SignUpScreenConfiguration()),
              child: SizedBox(
                width: 80.sc,
                child: Center(child: Text("Sign Up||sign_up".screenTr())),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
