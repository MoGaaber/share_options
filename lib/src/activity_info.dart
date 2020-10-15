import 'package:flutter/foundation.dart';

class ActivityInfo {
  /// Name of share intent.
  final String name;

  /// Package name of share intent.
  final String packageName;

  const ActivityInfo({
    @required this.name,
    @required this.packageName,
  });

  ActivityInfo copyWith({
    String name,
    String packageName,
  }) {
    return ActivityInfo(
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
    );
  }

  @override
  String toString() {
    return 'ActivityInfo{name: $name, packageName: $packageName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          packageName == other.packageName);

  @override
  int get hashCode => name.hashCode ^ packageName.hashCode;

  factory ActivityInfo.fromMap(Map<String, String> map) =>
      ActivityInfo(name: map['name'], packageName: map['packageName']);

  Map<String, String> get toMap => {
        'name': this.name,
        'packageName': this.packageName,
      };
}
