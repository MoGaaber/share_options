class ActivityInfo {
  const ActivityInfo(
    this.className,
    this.packageName,
  );

  /// Name of share intent.
  final String className;

  /// Package name of share intent.
  final String packageName;

  bool get valid {
    var regexp = RegExp(r'^([A-Za-z]{1}[A-Za-z\d_]*\.)*[A-Za-z][A-Za-z\d_]*$');
    return regexp.hasMatch(packageName) && regexp.hasMatch(className);
  }

  factory ActivityInfo.fromMap(Map<String, String> map) =>
      ActivityInfo(map['name'], map['packageName']);

  Map<String, String> get toMap => {
        'name': this.className,
        'packageName': this.packageName,
      };
}
