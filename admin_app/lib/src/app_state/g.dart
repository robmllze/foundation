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

/// A static class that acts as the primary access point for retrieving and
/// handling the state of the app.
abstract final class G {
  //.cyan
  // App Root.
  //.cyan~

  static AppEnvironmentState get app => G.appEnvironmentSnapshot()!;

  static TPodList mainWidgetPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.localeManager.pLocaleRef,
      pDefaultAppTheme,
      pDefaultAppScale,
    ];
  }

  static AppEnvironmentState? appEnvironmentSnapshot() {
    return pAppState.value;
  }

  static AppTheme appThemeSnapshot() {
    return pDefaultAppTheme.value;
  }

  static AppScale appScaleSnapshot() {
    return pDefaultAppScale.value;
  }

  //.cyan
  // App Session.
  //.cyan~

  static Pod<AppSessionState?>? appSessionPoller() {
    return pAppState.value?.pAppSession;
  }

  static TPodList appSessionPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
    ];
  }

  static AppSessionState? appSessionSnapshot() {
    return pAppState.value?.pAppSession.value;
  }

  //.cyan
  // Locale Ref.
  //.cyan~

  static Pod<LocaleRef>? localeRefPoller() {
    return pAppState.value?.localeManager.pLocaleRef;
  }

  static TPodList localeRefPlr() {
    return [
      pAppState,
      pAppState.value?.localeManager.pLocaleRef,
    ];
  }

  static LocaleRef? localeRefSnapshot() {
    return pAppState.value?.localeManager.pLocaleRef.value;
  }

  //.cyan
  // User Service.
  //.cyan~

  static Pod<UserService?>? userServicePoller() {
    return pAppState.value?.pAppSession.value.pUserService;
  }

  static TPodList userServicePlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pUserService,
    ];
  }

  static UserService? userServiceSnapshot() {
    return pAppState.value?.pAppSession.value.pUserService.value;
  }

  //.cyan
  // User.
  //.cyan~

  static Pod<ModelUser?>? userPoller() {
    return pAppState.value?.pAppSession.value.pUserService.value?.pValue;
  }

  static TPodList userPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pUserService,
      pAppState.value?.pAppSession.value.pUserService.value?.pValue,
    ];
  }

  static ModelUser? userSnapshot() {
    return pAppState.value?.pAppSession.value.pUserService.value?.pValue.value;
  }

  //.cyan
  // User Pub Service.
  //.cyan~

  static Pod<UserPubService?>? userPubServicePoller() {
    return pAppState.value?.pAppSession.value.pUserPubService;
  }

  static TPodList userPubServicePlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pUserPubService,
    ];
  }

  static UserPubService? userPubServiceSnapshot() {
    return pAppState.value?.pAppSession.value.pUserPubService.value;
  }

  //.cyan
  // User Pub.
  //.cyan~

  static Pod<ModelUserPub?>? userPubPoller() {
    return pAppState.value?.pAppSession.value.pUserPubService.value?.pValue;
  }

  static TPodList userPubPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pUserPubService,
      pAppState.value?.pAppSession.value.pUserPubService.value?.pValue,
    ];
  }

  static ModelUserPub? userPubSnapshot() {
    return pAppState.value?.pAppSession.value.pUserPubService.value?.pValue.value;
  }

  //.cyan
  // User Event Service.
  //.cyan~

  static Pod<EventService?>? userEventsServicePoller() {
    return pAppState.value?.pAppSession.value.pUserEventsService;
  }

  static EventService? userEventServiceSnapshot() {
    return pAppState.value?.pAppSession.value.pUserEventsService.value;
  }

  static TPodList userEventPoolPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pUserEventsService,
      pAppState.value?.pAppSession.value.pUserEventsService.value?.pValue,
    ];
  }

  static Iterable<ModelEvent>? userEventPoolSnapshot() {
    return pAppState.value?.pAppSession.value.pUserEventsService.value?.pValue.value;
  }

  //.cyan
  // Relationship Service.
  //.cyan~

  static Pod<RelationshipService?>? relationshipServicePoller() {
    return pAppState.value?.pAppSession.value.pRelationshipService;
  }

  static RelationshipService? relationshipServiceSnapshot() {
    return pAppState.value?.pAppSession.value.pRelationshipService.value;
  }

  //.cyan
  // Relationship Pool.
  //.cyan~

  static Pod<Iterable<ModelRelationship>?>? relationshipPoolPoller() {
    return pAppState.value?.pAppSession.value.pRelationshipService.value?.pValue;
  }

  static Iterable<ModelRelationship>? relationshipPoolSnapshot() {
    return pAppState.value?.pAppSession.value.pRelationshipService.value?.pValue.value;
  }

  static TPodList relationshipPoolPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pRelationshipService,
      pAppState.value?.pAppSession.value.pRelationshipService.value?.pValue,
    ];
  }

  //.cyan
  // Relationship Event Services.
  //.cyan~

  static Pod<Map<String, EventService>>? relationshipEventServicePoller() {
    return pAppState.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool;
  }

  static Map<String, EventService>? relationshipEventServicePoolSnapshot() {
    return pAppState.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool.value;
  }

  static TPodList relationshipEventServicePoolPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pRelationshipService,
      pAppState.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool,
    ];
  }

  //.cyan
  // Relationship Event Pool.
  //.cyan~

  static Iterable<ModelEvent>? relationshipEventPoolSnapshot(
    String? relationshipId,
  ) {
    return pAppState.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool
        .value[relationshipId]?.pValue.value;
  }

  static TPodList relationshipEventPoolPlr(String? relationshipId) {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pRelationshipService,
      pAppState.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool,
      pAppState.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool
          .value[relationshipId]?.pValue,
    ];
  }

  //.cyan
  // Cumulative Relationship Event Pool.
  //.cyan~

  static TPodList cumulativeRelationshipEventPoolPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pRelationshipService,
      pAppState.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool,
      ...?pAppState
          .value?.pAppSession.value.pRelationshipService.value?.pEventServicePool.value.values
          .map((e) => e.pValue),
    ];
  }

  static Map<String, Iterable<ModelEvent>>? cumulativeRelationshipEventPoolSnapshot() {
    return pAppState.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool.value
        .map((k, v) => MapEntry(k, v.pValue.value))
        .nonNulls;
  }

  //.cyan
  // Connection Service Pool.
  //.cyan~

  static Map<String, UserPubService>? connectionServicePoolSnapshot() {
    return pAppState
        .value?.pAppSession.value.pRelationshipService.value?.pConnectionServicePool.value;
  }

  static TPodList connectionServicePoolPlr() {
    return [
      pAppState,
      pAppState.value?.pAppSession,
      pAppState.value?.pAppSession.value.pRelationshipService,
      pAppState.value?.pAppSession.value.pRelationshipService.value?.pValue,
      pAppState.value?.pAppSession.value.pRelationshipService.value?.pConnectionServicePool,
    ];
  }
}
