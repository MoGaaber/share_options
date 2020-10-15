// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'activity_info.dart';
import 'content.dart';

class ShareOptions {
  /// Method channel
  static const _channel = MethodChannel('share_options');

  static SharedContent _sharedContent;

  /// Share option name
  final String name;

  /// Share option icon
  /// to display it into your app pass it to [Image.memory] widget
  final Uint8List icon;

  /// private field , it works internally and not visible out this file
  /// it uses in open share intent
  final ActivityInfo activityInfo;

  /// private constructor , it works internally and not visible out this file
  /// to assign values to [ShareOptions._shareOption]
  ShareOptions._shareOption({
    @required this.name,
    @required this.icon,
    @required this.activityInfo,
  });

  /// get a list of all [ShareOptions]
  /// if you pass [sharedContent.paths] it will retrieve all available sharing app/intent/options which can be receive this [sharedContent]
  /// if you pass null to [sharedContent] or [sharedContent.paths] it will retrieve all available sharing app/intent/options on device

  static Future<List<ShareOptions>> getShareOptions(
      {SharedContent sharedContent}) async {
    _sharedContent = sharedContent ?? SharedContent();

    var shareOptions = await _channel.invokeMethod<List>(
        'getShareOptions', _sharedContent.toSpecificMap);
    return shareOptions
        .map((e) => ShareOptions._fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// open share intent
  /// [sharedText] is a text which you managed to share it
  Future<void> share() async {
    await _channel.invokeMethod(
        'share', {...activityInfo.toMap, ..._sharedContent.toMap});
  }

  /// custom open share option/app/intent
  static Future<void> customShare(
      SharedContent sharedContent, ActivityInfo activityInfo) async {
    await _channel
        .invokeMethod('share', {...activityInfo.toMap, ...sharedContent.toMap});
  }

  factory ShareOptions._fromMap(Map<String, dynamic> map) =>
      ShareOptions._shareOption(
        name: map['name'] as String,
        icon: map['icon'] as Uint8List,
        activityInfo:
            ActivityInfo.fromMap(Map<String, String>.from(map['activityInfo'])),
      );
}
