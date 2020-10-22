import 'dart:typed_data';

import 'package:share_options/share_options.dart';
import 'package:share_options/src/activity_info.dart';
import 'package:share_options/src/shared_content/shared_files.dart';

import 'share_option.dart';

class FilesShareOption extends ShareOption {
  const FilesShareOption(String name, Uint8List icon, ActivityInfo activityInfo)
      : super(name, icon, activityInfo);

  static SharedFiles sharedFiles;

  factory FilesShareOption.fromMap(Map<String, dynamic> map) =>
      FilesShareOption(
        map['name'] as String,
        map['icon'] as Uint8List,
        ActivityInfo.fromMap(Map<String, String>.from(map['activityInfo'])),
      );

  @override
  Future<void> share() async {
    await channel.invokeMethod('shareFiles', {
      ...ShareOption.textAndSubject.toMap,
      ...FilesShareOption.sharedFiles.toMap,
      ...activityInfo.toMap,
    });
  }
}
