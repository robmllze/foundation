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

final class MyAppStateManager {
  //
  //
  //

  final MyAppEnvironment app;

  //
  //
  //

  MyAppStateManager(this.app);

  // ---------------------------------------------------------------------------
  // App Root.
  // ---------------------------------------------------------------------------

  TPodList appRootPlr() {
    return [
      app.pAppSession,
      app.localeManager.pLocaleRef,
      pDefaultAppTheme,
      pDefaultAppScale,
    ];
  }

  AppSession? appSessionRootSnapshot() {
    return app.pAppSession.value;
  }

  LocaleRef? localeRefRootSnapshot() {
    return app.localeManager.pLocaleRef.value;
  }

  AppTheme? appThemeRootSnapshot() {
    return pDefaultAppTheme.value;
  }

  AppScale? appScaleRootSnapshot() {
    return pDefaultAppScale.value;
  }

  // ---------------------------------------------------------------------------
  // User Service.
  // ---------------------------------------------------------------------------

  Pod<UserService?>? userServicePoller() {
    return app.pAppSession.value.pUserService;
  }

  TPodList userServicePlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pUserService,
    ];
  }

  UserService? userServiceSnapshot() {
    return app.pAppSession.value.pUserService.value;
  }

  // ---------------------------------------------------------------------------
  // User.
  // ---------------------------------------------------------------------------

  Pod<ModelUser?>? userPoller() {
    return app.pAppSession.value.pUserService.value?.pValue;
  }

  TPodList userPlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pUserService,
      app.pAppSession.value.pUserService.value?.pValue,
    ];
  }

  ModelUser? userSnapshot() {
    return app.pAppSession.value.pUserService.value?.pValue.value;
  }

  // ---------------------------------------------------------------------------
  // User Pub Service.
  // ---------------------------------------------------------------------------

  Pod<UserPubService?>? userPubServicePoller() {
    return app.pAppSession.value.pUserPubService;
  }

  TPodList userPubServicePlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pUserPubService,
    ];
  }

  UserPubService? userPubServiceSnapshot() {
    return app.pAppSession.value.pUserPubService.value;
  }

  // ---------------------------------------------------------------------------
  // User Pub.
  // ---------------------------------------------------------------------------

  Pod<ModelUserPub?>? userPubPoller() {
    return app.pAppSession.value.pUserPubService.value?.pValue;
  }

  TPodList userPubPlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pUserPubService,
      app.pAppSession.value.pUserPubService.value?.pValue,
    ];
  }

  ModelUserPub? userPubSnapshot() {
    return app.pAppSession.value.pUserPubService.value?.pValue.value;
  }

  // ---------------------------------------------------------------------------
  // User Event Service.
  // ---------------------------------------------------------------------------

  Pod<EventService?>? userEventsServicePoller() {
    return app.pAppSession.value.pUserEventsService;
  }

  EventService? userEventServiceSnapshot() {
    return app.pAppSession.value.pUserEventsService.value;
  }

  TPodList userEventPoolPlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pUserEventsService,
      app.pAppSession.value.pUserEventsService.value?.pValue,
    ];
  }

  Iterable<ModelEvent>? userEventPoolSnapshot() {
    return app.pAppSession.value.pUserEventsService.value?.pValue.value;
  }

  // ---------------------------------------------------------------------------
  // Relationship Service.
  // ---------------------------------------------------------------------------

  Pod<RelationshipService?>? relationshipServicePoller() {
    return app.pAppSession.value.pRelationshipService;
  }

  RelationshipService? relationshipServiceSnapshot() {
    return app.pAppSession.value.pRelationshipService.value;
  }

  // ---------------------------------------------------------------------------
  // Relationship Pool.
  // ---------------------------------------------------------------------------

  Pod<Iterable<ModelRelationship>?>? relationshipPoolPoller() {
    return app.pAppSession.value.pRelationshipService.value?.pValue;
  }

  Iterable<ModelRelationship>? relationshipPoolSnapshot() {
    return app.pAppSession.value.pRelationshipService.value?.pValue.value;
  }

  TPodList relationshipPoolPlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pRelationshipService,
      app.pAppSession.value.pRelationshipService.value?.pValue,
    ];
  }

  // ---------------------------------------------------------------------------
  // Relationship Event Services.
  // ---------------------------------------------------------------------------

  Pod<Map<String, EventService>>? relationshipEventServicePoller() {
    return app.pAppSession.value.pRelationshipService.value?.pEventServicePool;
  }

  Map<String, EventService>? relationshipEventServicePoolSnapshot() {
    return app.pAppSession.value.pRelationshipService.value?.pEventServicePool.value;
  }

  TPodList relationshipEventServicePoolPlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pRelationshipService,
      app.pAppSession.value.pRelationshipService.value?.pEventServicePool,
    ];
  }

  // ---------------------------------------------------------------------------
  // Relationship Event Pool.
  // ---------------------------------------------------------------------------

  Iterable<ModelEvent>? relationshipEventPoolSnapshot(String? relationshipId) {
    return app.pAppSession.value.pRelationshipService.value?.pEventServicePool.value[relationshipId]
        ?.pValue.value;
  }

  TPodList relationshipEventPoolPlr(String? relationshipId) {
    return [
      app.pAppSession,
      app.pAppSession.value.pRelationshipService,
      app.pAppSession.value.pRelationshipService.value?.pEventServicePool,
      app.pAppSession.value.pRelationshipService.value?.pEventServicePool.value[relationshipId]
          ?.pValue,
    ];
  }

  // ---------------------------------------------------------------------------
  // Cumulative Relationship Event Pool.
  // ---------------------------------------------------------------------------

  TPodList cumulativeRelationshipEventPoolPlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pRelationshipService,
      app.pAppSession.value.pRelationshipService.value?.pEventServicePool,
      ...?app.pAppSession.value.pRelationshipService.value?.pEventServicePool.value.values
          .map((e) => e.pValue),
    ];
  }

  Map<String, Iterable<ModelEvent>>? cumulativeRelationshipEventPoolSnapshot() {
    return app.pAppSession.value.pRelationshipService.value?.pEventServicePool.value
        .map((k, v) => MapEntry(k, v.pValue.value))
        .nonNulls;
  }

  // ---------------------------------------------------------------------------
  // Connection Service Pool.
  // ---------------------------------------------------------------------------

  Map<String, UserPubService>? connectionServicePoolSnapshot() {
    return app.pAppSession.value.pRelationshipService.value?.pConnectionServicePool.value;
  }

  TPodList connectionServicePoolPlr() {
    return [
      app.pAppSession,
      app.pAppSession.value.pRelationshipService,
      app.pAppSession.value.pRelationshipService.value?.pValue,
      app.pAppSession.value.pRelationshipService.value?.pConnectionServicePool,
    ];
  }
}
