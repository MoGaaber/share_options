import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:share_options/src/content.dart';

import 'activity_info.dart';

class ShareOption {
  static const _channel = MethodChannel('share_options');

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
  const ShareOption._shareOption({
    @required this.name,
    @required this.icon,
    @required ActivityInfo activityInfo,
  }) : _activityInfo = activityInfo;

  /// get a list of all [ShareOption] available in device

  static Future<List<ShareOption>> get getShareOptions async {
    List shareOptions = await _channel.invokeMethod('getShareOptions');
    return _shareOptionsFromMapList(shareOptions);
  }

  /// open share intent
  /// [sharedText] is a text which you managed to share it
  Future<void> share(Content content) async {
    await _channel.invokeMethod('share',
        {"activityInfo": _activityInfo.toMap(), "content": content.toMap()});
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
