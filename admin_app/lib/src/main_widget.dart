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

class MainWidget extends StatefulWidget {
  //
  //
  //

  const MainWidget({super.key});

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MainWidget> {
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return PodListBuilder(
      podList: [
        pAppSession,
        pAppTheme,
        localeManager.pLocaleRef,
        pAppUnits,
      ],
      builder: (context, child, values) {
        final appSession = values.elementAt(0) as AppSession?;
        final appTheme = values.elementAt(1) as AppTheme;
        if (appSession != null) {
          return MaterialApp.router(
            key: UniqueKey(),
            title: "App||app_title".tr(),
            // ignore: invalid_use_of_protected_member
            routerConfig: app.routeManager.router,
            theme: appTheme.data,
            builder: (context, body) {
              return Scaffold(body: body);
            },
          );
        } else {
          return Material(
            child: Center(
              child: WSpinner(
                child: MyAppIcon(
                  size: 50.sc,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
