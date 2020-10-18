import 'dart:typed_data';

import 'activity_info.dart';

abstract class ShareOption {
  // static String text, subject;
  static String text, subject;

  /// Share option name
  final String name;

  /// Share option icon
  /// to display it into your app pass it to [Image.memory] widget
  final Uint8List icon;

  /// private field , it works internally and not visible out this file
  /// it uses in open share intent
  final ActivityInfo activityInfo;

  ShareOption(this.name, this.icon, this.activityInfo);

  Future<void> share();
}
