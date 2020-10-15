class ActivityInfo {
  /// Name of share intent.
  final String className;

  /// Package name of share intent.
  final String packageName;

  const ActivityInfo(
    this.className,
    this.packageName,
  );

  bool get valid {
    var regexp = RegExp(r'^([A-Za-z]{1}[A-Za-z\d_]*\.)*[A-Za-z][A-Za-z\d_]*$');
    return regexp.hasMatch(packageName) && regexp.hasMatch(className);
  }

  @override
  String toString() {
    return 'ActivityInfo{name: $className, packageName: $packageName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityInfo &&
          runtimeType == other.runtimeType &&
          className == other.className &&
          packageName == other.packageName);

  @override
  int get hashCode => className.hashCode ^ packageName.hashCode;

  factory ActivityInfo.fromMap(Map<String, String> map) =>
      ActivityInfo(map['name'], map['packageName']);

  Map<String, String> get toMap => {
        'name': this.className,
        'packageName': this.packageName,
      };
}
