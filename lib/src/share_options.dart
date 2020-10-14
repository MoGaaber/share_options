// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart' show lookupMimeType;

import 'activity_info.dart';
import 'content.dart';

class ShareOption {
  static const _channel = MethodChannel('share_options');

  static SharedContent _sharedContent;

  /// Share option name
  final String name;

  /// Share option icon
  /// to display it into your app pass it to [Image.memory] widget
  final Uint8List icon;

  /// private field , it works internally and not visible out this file
  /// it uses in open share intent
  final ActivityInfo _activityInfo;

  /// private constructor , it works internally and not visible out this file
  /// to assign values to [ShareOption]
  ShareOption._shareOption({
    @required this.name,
    @required this.icon,
    @required ActivityInfo activityInfo,
  }) : _activityInfo = activityInfo;

  /// get a list of all [ShareOption] available in device
  static Future<List<ShareOption>> getShareOptions(
      SharedContent sharedContent) async {
    _sharedContent = sharedContent;
    List shareOptions = await _channel
        .invokeMethod('getShareOptions', {"paths": sharedContent.paths});
    return _shareOptionsFromMapList(shareOptions);
  }

  /// open share intent
  /// [sharedText] is a text which you managed to share it
  Future<void> share() async {
    var parameters = Map<String, dynamic>.from(_activityInfo.toMap());

    parameters.addAll(_sharedContent.toMap());

    await _channel.invokeMethod('share', parameters);
  }

  // static Future<void> share({SharedContent sharedContent}) async {
  //    var parameters = Map<String, dynamic>.from(_activityInfo.toMap());
  //
  //    parameters.addAll(sharedContent.toMap());
  //    print(parameters);
  //    await _channel.invokeMethod('share', parameters);
  //  }

  static List<String> _mimeTypeForPath(List<String> paths) {
    return paths
        .map((e) => lookupMimeType(e) ?? 'application/octet-stream')
        .toList();
  }

  ShareOption copyWith({
    String name,
    String icon,
    ActivityInfo activityInfo,
  }) {
    if ((name == null || identical(name, this.name)) &&
        (icon == null || identical(icon, this.icon)) &&
        (activityInfo == null || identical(activityInfo, this._activityInfo))) {
      return this;
    }

    return new ShareOption._shareOption(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      activityInfo: activityInfo ?? this._activityInfo,
    );
  }

  @override
  String toString() {
    return 'ShareOptions{name: $name, icon: $icon, _activityInfo: $_activityInfo}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShareOption &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          icon == other.icon &&
          _activityInfo == other._activityInfo);

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ _activityInfo.hashCode;

  factory ShareOption._fromMap(Map map) {
    return new ShareOption._shareOption(
      name: map['name'] as String,
      icon: map['icon'] as Uint8List,
      activityInfo: ActivityInfo.fromMap(map['activityInfo']),
    );
  }

  Map toMap() => {
        'name': this.name,
        'icon': this.icon,
      };

  static List<ShareOption> _shareOptionsFromMapList(List shareOptions) =>
      shareOptions.map((e) => ShareOption._fromMap(e)).toList();
}
