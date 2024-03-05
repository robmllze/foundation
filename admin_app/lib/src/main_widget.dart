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

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MainWidget extends StatelessWidget {
  //
  //
  //

  const MainWidget({super.key});

  //
  //
  //

  //
  @override
  Widget build(BuildContext context) {
    return RespondingPodListBuilder(
      podListResponder: G.mainWidgetPlr,
      builder: (context, child, values) {
        final appEnvironment = G.appEnvironmentSnapshot();
        if (appEnvironment != null) {
          return MaterialApp.router(
            key: UniqueKey(),
            title: "App||app_title".tr(),
            routerConfig: appEnvironment.routeManager.router,
            theme: G.appThemeSnapshot().data,
            debugShowCheckedModeBanner: false,
            builder: (context, body) => Scaffold(body: body),
          );
        } else {
          return const Center(
            child: WSpinner(
              child: MyAppIcon(),
            ),
          );
        }
      },
    );
  }
}
