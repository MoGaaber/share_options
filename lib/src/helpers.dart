import 'dart:io';

import 'package:mime/mime.dart';

class Helpers {
  static String generalMimeType(List<String> paths) {
    final mimes = paths.map((e) => lookupMimeType(e));
    final uniqueMimes = mimes.toSet().toList();
    if (uniqueMimes.length == 1) return uniqueMimes.first;
    final types = uniqueMimes.map((e) => e.split('/')[0]);
    final uniqueTypes = types.toSet().toList();
    return (uniqueTypes.length == 1) ? ('${uniqueTypes.first}/*') : ('*/*');
  }

  static bool textIsEmpty(String text) =>
      text == null ? true : text.trim().isEmpty;

  static List<String> notNullFilePaths(List<String> paths) =>
      paths.where((element) => element != null).toList();

  static List<String> validPaths(List<String> paths) {
    var notNullPaths = notNullFilePaths(paths);
    return notNullPaths.isEmpty
        ? []
        : notNullPaths.where((e) => File(e).existsSync()).toList();
  }

  static FormatException get formatException =>
      FormatException("paths is Empty .. in this case use text method instead");
}
