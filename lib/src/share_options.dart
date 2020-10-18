// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:share_options/share_options.dart';
import 'package:share_options/src/text_subject.dart';

import 'activity_info.dart';
import 'helpers.dart';
import 'share_options/file.dart';
import 'share_options/share_option.dart';
import 'share_options/text.dart';

const channel = const MethodChannel('share_options');

class ShareOptions {
  static const _ACTION_SEND = 'android.intent.action.SEND';
  static const _SEND_MULTIPLE = 'android.intent.action.SEND_MULTIPLE';

  /// Method channel

  /// get a list of all [ShareOptions] which can be receive this [sharedContent]
  /// throw exception if provide empty [sharedContent.text ] and [sharedContent.filePaths] or invalid  [sharedContent.filePaths]
  static Future<List<FileShare>> filesShareOptions(List<String> paths,
      {String text, String subject}) async {
    String action, mimeType;

    if (paths.isEmpty) {
      throw Helpers.formatException;
    } else {
      var validPaths = Helpers.validPaths(paths).length;

      switch (validPaths) {
        case 0:
          {
            throw Helpers.formatException;
          }

          break;

        case 1:
          {
            action = _ACTION_SEND;
            if (!Helpers.textIsEmpty(text))
              mimeType = '*/*';
            else
              mimeType = lookupMimeType(paths[0]);
          }

          break;
        default:
          {
            action = _SEND_MULTIPLE;
            if (!Helpers.textIsEmpty(text))
              mimeType = '*/*';
            else
              mimeType = Helpers.generalMimeType(paths);
          }
          break;
      }
    }
    FileShare.action = action;
    FileShare.mimeType = mimeType;
    FileShare.paths = paths;

    ShareOption.textAndSubject = TextAndSubject(text: text, subject: subject);

    final shareOptions = await channel.invokeMethod<List>(
        'getShareOptions', {'action': action, 'mimeType': mimeType});
    return shareOptions
        .map((e) => FileShare.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<List<TextShare>> textShareOptions(String text,
      {String subject}) async {
    ShareOption.textAndSubject = TextAndSubject(text: text, subject: subject);

    final shareOptions = await channel.invokeMethod<List>(
        'getShareOptions', {'action': _ACTION_SEND, 'mimeType': 'text/plain'});
    return shareOptions
        .map((e) => TextShare.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// open share intent
  /// [sharedText] is a text which you managed to share it

  /// custom open share option/app/intent
  static Future<void> customShare(ActivityInfo activityInfo) async {
    if (!activityInfo.valid) {
      throw FormatException("invalid activity info");
    }
    // await channel
    //     .invokeMethod('share', {...activityInfo.toMap, ...sharedContent.toMap});
  }
}
