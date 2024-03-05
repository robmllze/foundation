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

export 'dart:collection';

export 'package:flutter/material.dart';
export 'package:go_router/go_router.dart';

export 'package:xyz_config/xyz_config.dart';
export 'package:xyz_flutter_plus/xyz_flutter_plus.dart';
export 'package:xyz_pod/xyz_pod.dart';
export 'package:xyz_utils/xyz_utils.dart';

export 'package:_data/_common.dart';
export 'package:_service_interfaces/_common.dart';
export 'package:_services/_common.dart';
export 'package:_view/_common.dart'
    hide generatedScreenRoutes, SCREEN_MAKERS, findScreenFromConfiguration
    hide findScreenFromConfigurationAndAuthService;

export 'src/_all_src.g.dart';