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

/// The `StateBroker` serves as an intermediary between various services that
/// hold the application's data and the user interface (UI). It is not needed
/// but helps centralize and manage the state in a more maintainable, scalable,
/// and efficient manner.
abstract final class StateBroker {
  // ---------------------------------------------------------------------------
  // App Session.
  // ---------------------------------------------------------------------------

  static AppSession? appSessionSnapshot() {
    return pAppSession.value;
  }

  // ---------------------------------------------------------------------------
  // User Service.
  // ---------------------------------------------------------------------------

  static Pod<UserService?>? get pUserService {
    return appSessionSnapshot()?.pUserService;
  }

  static UserService? userServiceSnapshot() {
    return pUserService?.value;
  }

  // ---------------------------------------------------------------------------
  // User Pub Service.
  // ---------------------------------------------------------------------------

  static UserPubService? userPubServiceSnapshot() {
    return pUserPubService?.value;
  }

  static Pod<UserPubService?>? get pUserPubService {
    return appSessionSnapshot()?.pUserPubService;
  }

  // ---------------------------------------------------------------------------
  // User Event Service.
  // ---------------------------------------------------------------------------

  static EventService? userEventServiceSnapshot() {
    return pUserEventsService?.value;
  }

  static Pod<EventService?>? get pUserEventsService {
    return appSessionSnapshot()?.pUserEventsService;
  }

  static TPodList userEventPoolPlr() {
    return [
      pAppSession,
      StateBroker.pUserEventsService,
      StateBroker.pUserEventsService?.value?.pValue,
    ];
  }

  static Iterable<ModelEvent>? userEventPoolSnapshot() {
    return userEventServiceSnapshot()?.pValue.value;
  }

  // ---------------------------------------------------------------------------
  // Relationship Service.
  // ---------------------------------------------------------------------------

  // Relationship Service.

  static RelationshipService? relationshipServiceSnapshot() {
    return pRelationshipService?.value;
  }

  static Pod<RelationshipService?>? get pRelationshipService {
    return appSessionSnapshot()?.pRelationshipService;
  }

  // Relationship Pool.

  static Iterable<ModelRelationship>? relationshipPoolSnapshot() {
    return pRelationshipService?.value?.pValue.value;
  }

  static TPodList relationshipPoolPlr() {
    return [
      pAppSession,
      pRelationshipService,
      pRelationshipService?.value?.pValue,
    ];
  }

  // Relationship Event Service Pool.

  static Map<String, EventService>? relationshipEventServicePoolSnapshot() {
    return pRelationshipService?.value?.pEventServicePool.value;
  }

  static TPodList relationshipEventServicePoolPlr() {
    return [
      ...relationshipPoolPlr(),
      pRelationshipService?.value?.pEventServicePool,
    ];
  }

  // Relationship Event Pool.

  static Iterable<ModelEvent>? relationshipEventPoolSnapshot(
      String? relationshipId) {
    return pRelationshipService
        ?.value?.pEventServicePool.value[relationshipId]?.pValue.value;
  }

  static TPodList relationshipEventPoolPlr(String? relationshipId) {
    return [
      ...relationshipEventServicePoolPlr(),
      pRelationshipService
          ?.value?.pEventServicePool.value[relationshipId]?.pValue,
    ];
  }

  // Total Relationship Event Pool.

  static TPodList totalRelationshipEventPoolPlr() {
    return [
      ...relationshipEventServicePoolPlr(),
      pRelationshipService?.value?.pEventServicePool,
      ...?pRelationshipService?.value?.pEventServicePool.value.values
          .map((e) => e.pValue),
    ];
  }

  static Map<String, Iterable<ModelEvent>>?
      totalRelationshipEventPoolSnapshot() {
    return pRelationshipService?.value?.pEventServicePool.value
        .map((k, v) => MapEntry(k, v.pValue.value))
        .nonNulls;
  }

  // Connection Service Pool.

  static Map<String, UserPubService>? connectionServicePoolSnapshot() {
    return pRelationshipService?.value?.pConnectionServicePool.value;
  }

  static TPodList connectionServicePoolPlr() {
    return [
      ...relationshipPoolPlr(),
      pRelationshipService?.value?.pConnectionServicePool,
    ];
  }
}