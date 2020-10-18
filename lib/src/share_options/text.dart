import 'dart:typed_data';

import 'package:share_options/share_options.dart';
import 'package:share_options/src/activity_info.dart';

import 'share_option.dart';

class TextShareOption extends ShareOption {
  const TextShareOption(String name, Uint8List icon, ActivityInfo activityInfo)
      : super(name, icon, activityInfo);

  factory TextShareOption.fromMap(Map<String, dynamic> map) {
    return TextShareOption(
      map['name'] as String,
      map['icon'] as Uint8List,
      ActivityInfo.fromMap(Map<String, String>.from(map['activityInfo'])),
    );
  }

  @override
  Future<void> share() async {
    await channel.invokeMethod('shareText',
        {...ShareOption.textAndSubject.toMap, ...activityInfo.toMap});
  }
}
