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

part of 'home_screen.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _View extends THomeScreenView {
  //
  //
  //

  @override
  Widget layout(Widget body) {
    return super.layout(
      Column(
        children: [
          MyHeader(
            title: this.widget.configuration?.title,
            onBackButtonPressed: G.app.routeManager.goBack,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.sc),
                child: SizedBox(
                  width: double.infinity,
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
    return WColumn(
      divider: SizedBox(height: 20.sc),
      children: [
        PodBuilder(
          pod: this.c.pCounter,
          builder: (context, child, counter) {
            return Text("Count: $counter");
          },
        ),
        TextButton(
          onPressed: () {
            G.app.serviceEnvironment.authServiceBroker.logOut();
          },
          child: const Text("LOG OUT"),
        ),
      ],
    );
  }
}