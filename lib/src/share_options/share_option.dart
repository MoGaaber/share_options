import 'dart:typed_data';

import 'package:share_options/src/activity_info.dart';
import 'package:share_options/src/text_subject.dart';

abstract class ShareOption {
  const ShareOption(this.name, this.icon, this.activityInfo);

  // static String text, subject;
  static TextAndSubject textAndSubject;

  /// Share option name
  final String name;

  /// Share option icon
  /// to display it into your app pass it to [Image.memory] widget
  final Uint8List icon;

  /// private field , it works internally and not visible out this file
  /// it uses in open share intent
  final ActivityInfo activityInfo;
  Future<void> share();
}
