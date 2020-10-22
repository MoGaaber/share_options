import 'dart:typed_data';

import 'package:share_options/src/activity_info.dart';
import 'package:share_options/src/shared_content/shared_text_subject.dart';

/// Base class of [FileShare] and [TextShare]
abstract class ShareOption {
  const ShareOption(this.name, this.icon, this.activityInfo);

  /// shared Text and subject
  static SharedTextAndSubject textAndSubject;

  /// Share (option/app) name
  final String name;

  /// Share (option/app) icon
  /// to display it into your app pass it to [Image.memory] widget
  final Uint8List icon;

  /// Activity info of Share (option/app)
  final ActivityInfo activityInfo;

  /// share method it's overridden in subclasses
  /// uses to share content
  Future<void> share();
}
