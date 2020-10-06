import 'package:flutter/foundation.dart';

class ActivityInfo {
  final String name, packageName;

  ActivityInfo._({
    @required this.name,
    @required this.packageName,
  });

  ActivityInfo copyWith({
    String name,
    String packageName,
  }) {
    return ActivityInfo._(
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

  factory ActivityInfo.fromMap(Map map) {
    return new ActivityInfo._(
      name: map['name'] as String,
      packageName: map['packageName'] as String,
    );
  }

  Map<String, String> toMap() => {
        'name': this.name,
        'packageName': this.packageName,
      };
}
