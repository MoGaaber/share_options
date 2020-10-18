import 'dart:typed_data';

import 'package:share_options/share_options.dart';
import 'package:share_options/src/activity_info.dart';
import 'package:share_options/src/share_file_utiltiy.dart';

import 'share_option.dart';

class FileShare extends ShareOption {
  const FileShare(String name, Uint8List icon, ActivityInfo activityInfo)
      : super(name, icon, activityInfo);
  static ShareFileUtility shareFileUtility;
  // static String action, mimeType;
  // static List<String> paths;

  factory FileShare.fromMap(Map<String, dynamic> map) => FileShare(
        map['name'] as String,
        map['icon'] as Uint8List,
        ActivityInfo.fromMap(Map<String, String>.from(map['activityInfo'])),
      );

  @override
  Future<void> share() async {
    await channel.invokeMethod('shareFiles', {
      ...ShareOption.textAndSubject.toMap,
      ...FileShare.shareFileUtility.toMap,
      ...activityInfo.toMap,
    });
  }
}
