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

MyAppEnvironment get app => G.appEnvironmentSnapshot()!;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract final class G {
  // ---------------------------------------------------------------------------
  // App Root.
  // ---------------------------------------------------------------------------

  static TPodList mainWidgetPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.localeManager.pLocaleRef,
      pDefaultAppTheme,
      pDefaultAppScale,
    ];
  }

  static MyAppEnvironment? appEnvironmentSnapshot() {
    return pAppEnvironment.value;
  }

  static AppTheme appThemeSnapshot() {
    return pDefaultAppTheme.value;
  }

  static AppScale appScaleSnapshot() {
    return pDefaultAppScale.value;
  }

  // ---------------------------------------------------------------------------
  // App Session.
  // ---------------------------------------------------------------------------

  static Pod<MyAppSession?>? appSessionPoller() {
    return pAppEnvironment.value?.pAppSession;
  }

  static TPodList appSessionPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
    ];
  }

  static MyAppSession? appSessionSnapshot() {
    return pAppEnvironment.value?.pAppSession.value;
  }

  // ---------------------------------------------------------------------------
  // Locale Ref.
  // ---------------------------------------------------------------------------

  static Pod<LocaleRef>? localeRefPoller() {
    return pAppEnvironment.value?.localeManager.pLocaleRef;
  }

  static TPodList localeRefPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.localeManager.pLocaleRef,
    ];
  }

  static LocaleRef? localeRefSnapshot() {
    return pAppEnvironment.value?.localeManager.pLocaleRef.value;
  }

  // ---------------------------------------------------------------------------
  // User Service.
  // ---------------------------------------------------------------------------

  static Pod<UserService?>? userServicePoller() {
    return pAppEnvironment.value?.pAppSession.value.pUserService;
  }

  static TPodList userServicePlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pUserService,
    ];
  }

  static UserService? userServiceSnapshot() {
    return pAppEnvironment.value?.pAppSession.value.pUserService.value;
  }

  // ---------------------------------------------------------------------------
  // User.
  // ---------------------------------------------------------------------------

  static Pod<ModelUser?>? userPoller() {
    return pAppEnvironment.value?.pAppSession.value.pUserService.value?.pValue;
  }

  static TPodList userPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pUserService,
      pAppEnvironment.value?.pAppSession.value.pUserService.value?.pValue,
    ];
  }

  static ModelUser? userSnapshot() {
    return pAppEnvironment.value?.pAppSession.value.pUserService.value?.pValue.value;
  }

  // ---------------------------------------------------------------------------
  // User Pub Service.
  // ---------------------------------------------------------------------------

  static Pod<UserPubService?>? userPubServicePoller() {
    return pAppEnvironment.value?.pAppSession.value.pUserPubService;
  }

  static TPodList userPubServicePlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pUserPubService,
    ];
  }

  static UserPubService? userPubServiceSnapshot() {
    return pAppEnvironment.value?.pAppSession.value.pUserPubService.value;
  }

  // ---------------------------------------------------------------------------
  // User Pub.
  // ---------------------------------------------------------------------------

  static Pod<ModelUserPub?>? userPubPoller() {
    return pAppEnvironment.value?.pAppSession.value.pUserPubService.value?.pValue;
  }

  static TPodList userPubPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pUserPubService,
      pAppEnvironment.value?.pAppSession.value.pUserPubService.value?.pValue,
    ];
  }

  static ModelUserPub? userPubSnapshot() {
    return pAppEnvironment.value?.pAppSession.value.pUserPubService.value?.pValue.value;
  }

  // ---------------------------------------------------------------------------
  // User Event Service.
  // ---------------------------------------------------------------------------

  static Pod<EventService?>? userEventsServicePoller() {
    return pAppEnvironment.value?.pAppSession.value.pUserEventsService;
  }

  static EventService? userEventServiceSnapshot() {
    return pAppEnvironment.value?.pAppSession.value.pUserEventsService.value;
  }

  static TPodList userEventPoolPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pUserEventsService,
      pAppEnvironment.value?.pAppSession.value.pUserEventsService.value?.pValue,
    ];
  }

  static Iterable<ModelEvent>? userEventPoolSnapshot() {
    return pAppEnvironment.value?.pAppSession.value.pUserEventsService.value?.pValue.value;
  }

  // ---------------------------------------------------------------------------
  // Relationship Service.
  // ---------------------------------------------------------------------------

  static Pod<RelationshipService?>? relationshipServicePoller() {
    return pAppEnvironment.value?.pAppSession.value.pRelationshipService;
  }

  static RelationshipService? relationshipServiceSnapshot() {
    return pAppEnvironment.value?.pAppSession.value.pRelationshipService.value;
  }

  // ---------------------------------------------------------------------------
  // Relationship Pool.
  // ---------------------------------------------------------------------------

  static Pod<Iterable<ModelRelationship>?>? relationshipPoolPoller() {
    return pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pValue;
  }

  static Iterable<ModelRelationship>? relationshipPoolSnapshot() {
    return pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pValue.value;
  }

  static TPodList relationshipPoolPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pValue,
    ];
  }

  // ---------------------------------------------------------------------------
  // Relationship Event Services.
  // ---------------------------------------------------------------------------

  static Pod<Map<String, EventService>>? relationshipEventServicePoller() {
    return pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool;
  }

  static Map<String, EventService>? relationshipEventServicePoolSnapshot() {
    return pAppEnvironment
        .value?.pAppSession.value.pRelationshipService.value?.pEventServicePool.value;
  }

  static TPodList relationshipEventServicePoolPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool,
    ];
  }

  // ---------------------------------------------------------------------------
  // Relationship Event Pool.
  // ---------------------------------------------------------------------------

  static Iterable<ModelEvent>? relationshipEventPoolSnapshot(String? relationshipId) {
    return pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool
        .value[relationshipId]?.pValue.value;
  }

  static TPodList relationshipEventPoolPlr(String? relationshipId) {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool
          .value[relationshipId]?.pValue,
    ];
  }

  // ---------------------------------------------------------------------------
  // Cumulative Relationship Event Pool.
  // ---------------------------------------------------------------------------

  static TPodList cumulativeRelationshipEventPoolPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pEventServicePool,
      ...?pAppEnvironment
          .value?.pAppSession.value.pRelationshipService.value?.pEventServicePool.value.values
          .map((e) => e.pValue),
    ];
  }

  static Map<String, Iterable<ModelEvent>>? cumulativeRelationshipEventPoolSnapshot() {
    return pAppEnvironment
        .value?.pAppSession.value.pRelationshipService.value?.pEventServicePool.value
        .map((k, v) => MapEntry(k, v.pValue.value))
        .nonNulls;
  }

  // ---------------------------------------------------------------------------
  // Connection Service Pool.
  // ---------------------------------------------------------------------------

  static Map<String, UserPubService>? connectionServicePoolSnapshot() {
    return pAppEnvironment
        .value?.pAppSession.value.pRelationshipService.value?.pConnectionServicePool.value;
  }

  static TPodList connectionServicePoolPlr() {
    return [
      pAppEnvironment,
      pAppEnvironment.value?.pAppSession,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pValue,
      pAppEnvironment.value?.pAppSession.value.pRelationshipService.value?.pConnectionServicePool,
    ];
  }
}
