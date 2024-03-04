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

/// Holds and manages all the services used by the app.
class AppSession {
  //
  //
  //

  final pUserService = Pod<UserService?>(null);
  final pUserPubService = Pod<UserPubService?>(null);
  final pUserEventsService = Pod<EventService?>(null);
  final pRelationshipService = Pod<RelationshipService?>(null);

  //
  //
  //

  final ServiceEnvironment serviceEnvironment;

  //
  //
  //

  AppSession(this.serviceEnvironment);

  //
  //
  //

  Future<void> startSession(UserInterface currentUser) async {
    await pUserService.set(
      await initService(
        UserService(
          serviceEnvironment: this.serviceEnvironment,
          id: currentUser.userId,
        ),
      ),
    );

    await pUserPubService.set(
      await initService(
        UserPubService(
          serviceEnvironment: this.serviceEnvironment,
          id: currentUser.userPubId,
        ),
      ),
    );

    await pUserEventsService.set(
      await initService(
        EventService(
          serviceEnvironment: this.serviceEnvironment,
          ref: Schema.userEventsRef(
            userPubId: currentUser.userPubId,
          ),
          limit: 50,
        ),
      ),
    );

    await pRelationshipService.set(
      await initService(
        RelationshipService(
          serviceEnvironment: this.serviceEnvironment,
          userPubId: currentUser.userPubId,
          limit: 100,
        ),
      ),
    );
  }

  //
  //
  //

  Future<void> stopSession() async {
    final loggedOut = this.serviceEnvironment.authServiceBroker.loggedOut;
    assert(loggedOut);
    if (loggedOut) {
      pRelationshipService.value?.dispose();
      await pRelationshipService.set(null);

      pUserEventsService.value?.dispose();
      await pUserEventsService.set(null);

      pUserPubService.value?.dispose();
      await pUserPubService.set(null);

      pUserService.value?.dispose();
      await pUserService.set(null);
    }
  }
}