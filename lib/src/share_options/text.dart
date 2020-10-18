import 'dart:typed_data';

import 'package:share_options/share_options.dart';
import 'package:share_options/src/activity_info.dart';

import 'share_option.dart';

class TextShare extends ShareOption {
  const TextShare(String name, Uint8List icon, ActivityInfo activityInfo)
      : super(name, icon, activityInfo);

  factory TextShare.fromMap(Map<String, dynamic> map) {
    return TextShare(
      map['name'] as String,
      map['icon'] as Uint8List,
      ActivityInfo.fromMap(Map<String, String>.from(map['activityInfo'])),
    );
  }

  @override
  Future<void> share() async {
    await channel.invokeMethod('shareText', {
      ...ShareOption.textAndSubject.toMap(),

      // 'text': ShareOption.text,
      // 'subject': ShareOption.subject,
      ...activityInfo.toMap
    });
  }
}
