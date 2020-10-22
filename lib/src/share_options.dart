import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:share_options/share_options.dart';
import 'package:share_options/src/util/constants.dart';
import 'package:share_options/src/util/helpers.dart';

import 'share_options/file.dart';
import 'share_options/share_option.dart';
import 'share_options/text.dart';
import 'shared_content/shared_files.dart';
import 'shared_content/shared_text_subject.dart';

const channel = const MethodChannel('share_options');

class ShareOptions {
  /// get a list of sharing intents which supporting files and texts
  /// [getTextShareOptions] is called if list haven't one valid path
  static Future<List<ShareOption>> getFilesShareOptions(List<String> paths,
      {String text, String subject}) async {
    String action, mimeType;

    if (paths.isEmpty) {
      // throw Helpers.formatException;
      return getTextShareOptions(text, subject: subject);
    } else {
      var validPaths = Helpers.validPaths(paths).length;

      switch (validPaths) {
        case 0:
          {
            // throw Helpers.formatException;
            return getTextShareOptions(text, subject: subject);
          }

          break;

        case 1:
          {
            action = Constants.ACTION_SINGLE;
            if (Helpers.isTextNotEmpty(text))
              mimeType = Constants.SUPPORT_ALL_MIME_TYPES;
            else
              mimeType = lookupMimeType(paths[0]);
          }

          break;
        default:
          {
            action = Constants.ACTION_MULTIPLE;
            if (Helpers.isTextNotEmpty(text))
              mimeType = Constants.SUPPORT_ALL_MIME_TYPES;
            else
              mimeType = Helpers.generalMimeType(paths);
          }
          break;
      }
    }

    FilesShareOption.sharedFiles = SharedFiles(action, mimeType, paths);
    ShareOption.textAndSubject = SharedTextAndSubject(text, subject);

    final shareOptions = await channel.invokeMethod<List>(
        'getShareOptions', {'action': action, 'mimeType': mimeType});
    return shareOptions
        .map((e) => FilesShareOption.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// get a list of sharing intents which supporting texts only
  static Future<List<TextShareOption>> getTextShareOptions(String text,
      {String subject}) async {
    ShareOption.textAndSubject = SharedTextAndSubject(text, subject);
    final shareOptions = await channel.invokeMethod<List>('getShareOptions',
        {'action': Constants.ACTION_SINGLE, 'mimeType': 'text/plain'});
    return shareOptions
        .map((e) => TextShareOption.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
